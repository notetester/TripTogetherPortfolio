# 탐색 · 커머스

여행지를 발견하고(탐색), 마음에 드는 곳을 결제·예약하며(커머스), 그 과정에서 쌓인 보상을 다시 사용하는(지갑) 순환 구조를 다룹니다. 사용자는 `/explore`에서 여행지를 검색·필터링하고 AI 개인화 추천을 받으며, `/detail/{spotIdx}`에서 해당 여행지의 항공권 견적과 여행 패키지를 함께 확인해 그 자리에서 캐시·마일리지로 결제합니다. 결제로 쌓인 마일리지·포인트는 회원 등급을 끌어올리고, 포인트는 다시 포인트샵에서 꾸미기 아이템 구매에 사용됩니다.

이 도메인은 세 개의 자산(캐시 / 마일리지 / 포인트)으로 구성된 **3-지갑 모델**을 중심으로, 실제 결제 게이트웨이(Toss Payments) 연동과 시뮬레이션 결제를 함께 제공합니다. 외부 항공권 API가 없는 환경을 고려해 항공권은 **결정론적 Mock 견적 제공자**로 추상화했고, 여행 패키지는 판매자 등록 → 관리자 승인 → 사용자 예약으로 이어지는 마켓플레이스 워크플로를 갖춥니다.

## 주요 기능

- **여행지 탐색**: 탭(전체/지역/테마/평점/좋아요/찜/AI)별 목록, 키워드 통합 검색, 검색 자동완성(`/explore/suggest`), 페이지네이션
- **찜 · 좋아요**: 여행지 단위 토글(AJAX), 좋아요 시 작성자/행위자 양쪽에 보상 지급
- **여행지 등록 · 리뷰**: 사용자 직접 여행지 등록(지도 좌표 검증), 별점 리뷰 1인 1건, 리뷰 좋아요
- **AI 개인화 추천**: 체류 시간·방문 빈도 기반 관심 태그 추출 → Gemini 호출 → 후보 재정렬, 결과 없으면 "요즘 뜨는 여행지" 폴백
- **항공권 커머스**: 여행지 상세에서 왕복 항공권 견적 조회·최저가 표시·예매·취소(국내 여행지 제외, 등급 할인 적용)
- **여행 패키지 마켓플레이스**: 판매자 등록·수정·상태관리, 관리자 승인/반려·수정요청(revision) 심사, 사용자 예약·취소
- **3-지갑(캐시/마일리지/포인트)**: 충전(Toss 실결제 + 시뮬레이션), 결제·환불, 자산별 이력, 회원 등급 자동 재계산
- **포인트샵**: 닉네임 색상·효과·뱃지·말풍선 아이템 포인트 구매 및 보유/장착

## 핵심 구현

### 1. 탐색 목록과 탭 분기 (`ExploreController`, `ExploreServiceImpl`)

`GET /explore`는 `tab` 파라미터로 조회 경로를 분기합니다. `ExploreController.explore()`가 `tab` 값에 따라 서로 다른 서비스 메서드를 호출합니다.

- `rating` → `getRatingSpotList()`, `likes` → `getLikesSpotList()`, `favorite` → `getFavoriteSpotList()`
- `ai` → 서버에서는 빈 목록을 반환하고, 화면에서 `/recommend/spots` AJAX로 비동기 로드(불필요한 페이징 블록 방지)
- 그 외 → `getSpotList()`

검색 조건은 `ExploreSearchDto`(탭·지역·테마·키워드·페이지)로 캡슐화하며, 컨트롤러의 `buildSearch()`가 입력을 trim·정규화하고 `calcOffset()`으로 페이지 오프셋을 계산합니다(페이지 크기 12). 서비스는 매퍼 조회 후 `splitTags()`로 `GROUP_CONCAT` 태그 문자열을 `List<String>`으로 분해하고, `applyUserActionState()`로 각 카드에 로그인 사용자의 찜/좋아요 상태를 표시합니다. 마지막으로 `SpotTextTranslationService`를 거쳐 여행지명·지역·태그 등 동적 문구를 현재 로케일로 번역합니다(번역 캐시 테이블 `SPOT_TEXT_TRANSLATION_CACHE` 사용).

자동완성 `GET /explore/suggest`는 입력이 비어 있으면 DB 조회 없이 빈 배열을 반환하고, 그렇지 않으면 `SPOT_TRAVEL`을 LIKE 검색해 최대 7건을 돌려줍니다.

### 2. AI 개인화 추천 파이프라인 (`RecommendController`, `RecommendService`)

추천은 **암묵 신호(체류 시간 + 방문 빈도)**를 수집해 관심 태그를 만들고, 후보를 점수화한 뒤 Gemini로 최종 3건을 고르는 다단계 구조입니다.

1. **신호 수집** — 상세 페이지 이탈 시 `POST /recommend/view-log`로 체류 시간을 `SPOT_VIEW_LOG`에 적재합니다. `saveViewLog()`는 값을 1~3600초로 클램프하고, 기록 직후 `invalidateCache()`로 추천 캐시(`SPOT_RECOMMEND`)를 무효화해 다음 조회에서 즉시 재계산되게 합니다.
2. **관심 태그 추출** — 최근 로그(최대 30건)에서 spot별 체류 시간과 방문 횟수를 집계하고, `buildInterestProfile()`에서 `체류 점수 + 방문 횟수×180` 가중치로 태그별 관심도를 합산해 상위 8개 태그를 뽑습니다.
3. **후보 재정렬** — `selectCandidateSpots()`로 미방문·태그 매칭 후보를 가져온 뒤 `computeCandidatePriority()`로 우선순위를 계산합니다. 우선순위는 `현재 보는 여행지 태그 겹침 ×1,000,000 + tag_match_score ×100,000 + 관심 프로필 가중치 − 방문 플래그 ×10,000` 형태로, 현재 맥락을 가장 강하게 반영합니다.
4. **Gemini 호출** — `gemini-2.5-flash` 엔드포인트에 관심 태그·체류 이력·후보 목록·금지 목록(최근 방문/이전 추천)을 담은 프롬프트를 보내고, JSON 배열만 받도록 출력 형식을 강제합니다. 응답 파싱(`parseGeminiResponse` → `extractCompletedObjects`)은 코드펜스를 제거하고, 토큰 한도로 **잘린 JSON에서도 완성된 객체만 중괄호 깊이 추적으로 안전하게 추출**합니다.
5. **병합·보정·폴백** — `mergeWithTopCandidates()` / `ensureExactRecommendationCount()`로 AI 결과가 부족하면 상위 후보로 채워 항상 정확히 3건을 보장하고, 그래도 비면 `getTrendingSpots()`("요즘 뜨는 여행지")로 폴백합니다. 저장 전 후보 집합으로 FK 유효성을 검증해 존재하지 않는 `spot_idx`를 걸러냅니다.

### 3. 항공권 커머스 — Mock 견적 추상화 (`FlightService`, `MockFlightOfferProvider`)

외부 항공권 API 의존을 피하기 위해 `FlightOfferProvider` 인터페이스로 견적 제공을 추상화하고, 구현체 `MockFlightOfferProvider`를 주입합니다(생성되는 견적 ID는 `MOCK-` 접두어로 식별). Mock은 **결정론적**입니다.

- `supports()`는 위경도가 한국 영역(위도 33.0~39.6, 경도 124.0~132.0) 안이거나 지명에 국내 키워드가 포함되면 항공권 대상에서 제외합니다(국내선 미지원).
- 가격은 `spotIdx + 공항코드 + 날짜` 해시를 시드로 사용해, 같은 여행지·같은 날짜면 항상 같은 가격이 나오도록 만듭니다. 목적지는 지명 키워드 매칭으로 공항/소요시간을 결정하고(`도쿄→NRT`, `파리→CDG` 등), 권역별 가격대(`PriceRange`)와 주말·임박·장기 일정에 따른 보정 계수(`applyDateFactor`)를 적용합니다.

`FlightServiceImpl`은 출발 14일 후·5일 일정을 기본값으로 견적을 만들고, 회원 등급 할인율(`MEMBER_GRADE_POLICY`)을 견적 총액에 반영합니다. 상세 페이지에는 `getLowestOffer()`로 최저가만 노출합니다. 결제 시 **캐시 + 마일리지 합이 최종가와 정확히 일치**해야 하며, 마일리지는 결제액의 최대 30%(`floorToThousand`로 천 단위 내림)까지만 사용 가능합니다. 잔액 차감·`USER_PAYMENT_HISTORY` 기록·자산별 `USER_WALLET_HISTORY` 기록·`FLIGHT_PURCHASE_SIMULATION` 적재를 한 트랜잭션으로 처리하고, 취소 시 동일 금액을 REFUND로 환불합니다.

### 4. 여행 패키지 마켓플레이스 (`TravelPackageController`, `TravelPackageServiceImpl`)

판매자 권한(`UsersVO.canManagePackage()`)을 가진 사용자가 패키지를 등록하고, 관리자가 심사하는 상태 기계입니다.

- **상태 전이**: `DRAFT` → `PENDING`(제출) → `APPROVED` / `REJECTED`. 승인된(`APPROVED`) 패키지의 수정은 원본을 즉시 바꾸지 않고 `TRAVEL_PACKAGE_REVISION`에 **수정요청 행**을 만들어 별도 심사를 받습니다(`REVISION_PENDING` → 적용 시 원본 반영). 모든 심사 결과는 `TRAVEL_PACKAGE_REVIEW_HISTORY`에 남깁니다.
- **목록·노출**: `/packages`는 승인된 패키지만 키워드 검색·페이징(페이지 크기 9)으로 보여주며, 여행지 상세에는 `getApprovedPackagesBySpot()`로 해당 여행지 패키지를 함께 노출합니다.
- **예약 결제**(`bookPackage`): `selectApprovedPackageForUpdate()`로 행을 잠그고, 인원수 검증 → `단가 × 인원` 총액(`Math.multiplyExact`로 오버플로 방지) → 마일리지 한도(30%) 검증 → 캐시/마일리지 잔액 차감을 한 트랜잭션으로 수행합니다. 결제 후 `loginUser` 세션을 갱신해 잔액을 즉시 반영하고, 취소 시 사용 자산을 환불하며 예약 카운트(`increase/decreasePackageBookingCount`)를 동기화합니다.

### 5. 3-지갑과 Toss Payments 연동 (`WalletController`, `WalletServiceImpl`, `WalletChargeLimitAspect`)

`UsersVO`는 `cashBalance`(캐시)·`mileageBalance`(마일리지)·`pointBalance`(포인트) 세 자산을 보유하며, 자산 변동은 모두 `USER_WALLET_HISTORY`에 `assetType`(CASH/MILEAGE)·`changeType`(CHARGE/EARN/USE/REFUND)로 기록됩니다.

- **충전 두 갈래**: `simulateCashCharge()`는 즉시 `COMPLETED` 결제를 남기는 시뮬레이션 충전이고, Toss 실결제는 **선저장-후승인** 패턴을 씁니다. `prepareTossCharge()`가 결제창 오픈 전 `READY` 주문을 DB에 저장(orderId 발급)하므로, 성공 콜백(`/wallet/charge/success`)이 세션에 의존하지 않고 orderId로 정확한 충전 건을 복원합니다.
- **승인 멱등성**: `completeTossCharge()`는 주문 행을 잠그고 `TossPaymentsClient.confirmPayment()`로 금액·상태(`DONE`)·주문ID를 교차 검증한 뒤에만 `COMPLETED`로 전이하며 캐시를 지급합니다. 이미 `COMPLETED`면 중복 적립 없이 기존 결과를 반환해 **콜백 재호출에도 안전**합니다. 충전 시 충전액의 10%를 마일리지로 적립합니다.
- **등급 자동 재계산**: 충전 후 `recalculateMemberGrade()`가 직전 달 결제 총액과 `MEMBER_GRADE_POLICY`를 비교해 등급을 갱신하고, `USER_GRADE_HISTORY` 기록 + 마이페이지 알림을 남깁니다.
- **충전 한도(AOP)**: `WalletChargeLimitAspect`가 `simulateCashCharge`/`prepareTossCharge` 진입 직전에 1회·일·월 한도(`WALLET_LIMIT_POLICY`)를 검사합니다. **서비스 본 코드를 건드리지 않고** 횡단 관심사로 분리했으며, 정책 조회 실패 시 결제를 막지 않는 **FAIL-OPEN** 방침을 둡니다.

### 6. 포인트샵과 보상 엔진 (`ShopServiceImpl`, `RewardServiceImpl`)

포인트샵 `/shop`은 닉네임 색상/효과·프로필 뱃지·말풍선 4개 섹션의 꾸미기 아이템을 판매합니다. 섹션·아이템 메타데이터는 컨트롤러에서 메시지 코드 기반으로 구성하고(i18n), 가격·판매상태 등 실데이터는 `POINT_SHOP_ITEM`에서 조회합니다. `purchaseItem()`은 사용자·아이템 행을 잠그고 중복 보유(비반복 아이템)·포인트 잔액을 검증한 뒤, 포인트 차감 → `USER_POINT_PURCHASE_HISTORY` → `USER_POINT_ITEM_INVENTORY` upsert → `USER_POINT_HISTORY`(USE)를 한 트랜잭션으로 처리합니다. 보유 아이템은 슬롯별 장착(`USER_POINT_ITEM_EQUIP`)이 가능합니다.

탐색·커머스 곳곳의 행동은 `RewardService.awardAction(userIdx, rewardCode, sourceId, amountBasis, detail)` 한 진입점으로 모입니다(여행지 등록 `SPOT_POST`, 리뷰 `SPOT_REVIEW`, 좋아요 `SPOT_LIKE`, 결제 `PAYMENT` 등). 보상 엔진은 `sourceId` 기준으로 **중복 지급을 멱등 차단**하고(포인트/경험치 각각 이력 카운트 확인), 포인트 정책(`POINT_REWARD_POLICY`)과 경험치 정책으로 지급액을 산정합니다. 경험치 누적으로 레벨이 오르면 `EXP_LEVEL_POLICY`(QUADRATIC/EXPONENTIAL/HYBRID 모드 + `EXP_LEVEL_OVERRIDE`)로 새 레벨을 계산하고, 구간 내 미지급 레벨업 보상(`LEVEL_UP_REWARD_POLICY`)을 포인트/캐시/마일리지/아이템으로 정산한 뒤 잔액을 한 번에 갱신합니다. 좋아요 보상은 `대상ID×1,000,000 + 행위자ID`를 `sourceId`로 합성해, 같은 사용자가 같은 대상에 반복 토글해도 1회만 지급되도록 했습니다.

## 설계 결정과 트레이드오프

- **암묵 신호 기반 추천 + 다층 폴백**: 별도의 평점 입력 없이 체류 시간·방문 빈도라는 암묵 신호만으로 개인화하므로 사용자 부담이 없습니다. 대신 신호가 적은 신규 사용자는 추천 품질이 낮아질 수 있어, 후보 재정렬 → AI → 트렌딩의 다층 폴백으로 **"항상 정확히 3건"**을 보장하는 쪽을 택했습니다. AI 비결정성·토큰 절단에 대비해 잘린 JSON 복구 파서를 직접 구현했습니다.
- **항공권 제공자 추상화**: 실 항공권 API 비용·키 관리 부담을 피하면서도 결제·예약 흐름은 실제처럼 검증하기 위해 `FlightOfferProvider` 인터페이스로 분리하고 결정론적 Mock을 주입했습니다. 추후 실제 제공자 구현체로 교체해도 서비스 계층은 변경이 없습니다(전략 패턴).
- **충전 한도를 AOP로 분리**: 한도 검증은 충전 비즈니스 로직과 독립적인 횡단 관심사이므로, `WalletService` 본 코드를 수정하지 않고 `@Before` 어드바이스로 주입했습니다. 가용성을 위해 정책 조회 실패 시 결제를 막지 않는 FAIL-OPEN을 의도적으로 채택했습니다(보안보다 사용자 경험 우선, 한도는 보조 장치).
- **Toss 선저장-후승인 + 멱등 승인**: 결제 콜백은 세션 만료·중복 호출 위험이 있어, `READY` 주문을 먼저 DB에 남겨 orderId로 복원하고 승인 단계에서 금액·상태를 교차 검증했습니다. 이미 완료된 주문은 재적립 없이 기존 결과를 반환해 멱등성을 확보했습니다.
- **결제·환불의 단일 트랜잭션화**: 잔액 변경·결제 이력·자산 이력·구매/예약 행 적재를 모두 한 트랜잭션으로 묶어, 중간 실패 시 부분 반영을 방지했습니다(`*ForUpdate` 행 잠금으로 동시 충전·결제 경합 차단).
- **블로킹은 삭제가 아닌 상태값(ADR-0003)**: 리뷰·패키지의 관리자 차단은 물리 삭제 대신 상태값(`BLOCKED` 등)으로 처리해 데이터 추적성을 유지합니다(콘텐츠 삭제 역시 `DELETED` 소프트 삭제로 처리 — ADR-0008).
- **i18n 전면 적용(ADR-0013)**: 패키지·지갑·샵의 사용자 노출 문구는 `MessageSource`로 출력하고, 여행지명·태그 등 DB 동적 문구는 `SpotTextTranslationService` 번역 캐시로 다국어를 지원합니다.

## 데이터 모델 / 연동

탐색·커머스 도메인의 주요 테이블입니다.

- **탐색**: `SPOT_TRAVEL`(여행지) · `SPOT_IMAGE` · `SPOT_TAG`/`SPOT_TAG_LIST`(태그) · `SPOT_FAVORITE`(찜) · `SPOT_LIKE`(좋아요) · `SPOT_REVIEW`/`SPOT_REVIEW_LIKE`(리뷰)
- **추천**: `SPOT_VIEW_LOG`(체류 신호) · `SPOT_RECOMMEND`(추천 캐시) · `SPOT_TEXT_TRANSLATION_CACHE`(번역 캐시)
- **항공권**: `FLIGHT_PURCHASE_SIMULATION`(예매 시뮬레이션)
- **패키지**: `TRAVEL_PACKAGE` · `TRAVEL_PACKAGE_IMAGE` · `TRAVEL_PACKAGE_BOOKING` · `TRAVEL_PACKAGE_REVISION`(수정요청) · `TRAVEL_PACKAGE_REVIEW_HISTORY`(심사 이력)
- **지갑·결제**: `USER_PAYMENT_HISTORY`(결제) · `USER_WALLET_HISTORY`(캐시/마일리지 변동) · `WALLET_LIMIT_POLICY`(충전 한도) · `WALLET_REWARD_POLICY` · `WALLET_REFUND_LOG` · `MEMBER_GRADE_POLICY` · `USER_GRADE_HISTORY`
- **포인트·보상**: `POINT_SHOP_ITEM` · `USER_POINT_PURCHASE_HISTORY` · `USER_POINT_ITEM_INVENTORY` · `USER_POINT_ITEM_EQUIP` · `USER_POINT_HISTORY` · `POINT_REWARD_POLICY` · `EXP_LEVEL_POLICY`/`EXP_LEVEL_OVERRIDE` · `LEVEL_UP_REWARD_POLICY`/`USER_LEVEL_UP_REWARD_HISTORY`

외부 연동: **Google Gemini**(`gemini-2.5-flash`, 키 이름 `gemini.api.key`) — 여행지 추천 / **Google Maps**(키 이름 `google.maps.api-key`) — 여행지 등록 좌표·지도 / **Toss Payments**(키 이름 `toss.payments.client-key`) — 캐시 충전 실결제.

## 사용 기술

- Spring Boot 4 / Java 21 / MyBatis / MySQL / JSP·JSTL
- `@Transactional` 트랜잭션 경계 + `SELECT ... FOR UPDATE` 비관적 잠금
- Spring AOP(`@Aspect`) — 충전 한도 검증의 횡단 관심사 분리
- 전략 패턴(`FlightOfferProvider`) — 항공권 견적 제공 추상화
- `RestTemplate` 기반 외부 API 호출(Gemini / Toss), Gson JSON 파싱(절단 JSON 복구 포함)
- Spring `MessageSource` 기반 i18n(ko/en/ja/zh) + DB 동적 문구 번역 캐시
- Lombok, SSE 기반 알림 연동(등급 변경·레벨업 알림)
