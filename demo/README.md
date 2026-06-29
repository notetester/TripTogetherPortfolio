# TripTogether — 라이브 데모

[![Live Demo](https://img.shields.io/badge/▶_Live_Demo-둘러보기-2ea44f?logo=github)](https://notetester.github.io/TripTogetherPortfolio/)
[![메인 README](https://img.shields.io/badge/⬆_프로젝트_메인-README-blue)](../README.md)
[![기술 설명서](https://img.shields.io/badge/📖_기술_설명서-Docs-0ea5a4)](https://notetester.github.io/TripTogetherPortfolio/docs/)

이 폴더는 **TripTogether**를 백엔드 없이 둘러볼 수 있는 **정적 데모**이며, [TripTogetherPortfolio](https://github.com/notetester/TripTogetherPortfolio) 저장소의 GitHub Pages **루트(`/`)** 로 서비스됩니다. 원본은 API 키가 포함된 비공개 저장소라, 실제 화면을 렌더링한 정적 스냅샷에 가상의 목(mock) 데이터를 입혀 게시했습니다.

### ▶ 바로 체험하기 → <https://notetester.github.io/TripTogetherPortfolio/>

> 📖 각 기능이 *무엇을·왜·어떻게* 구현됐는지는 기술 설명서에서 확인하세요 → <https://notetester.github.io/TripTogetherPortfolio/docs/>

## 데모 이용 방법

1. 위 링크로 접속합니다. (**로그아웃 상태로 시작**)
2. 우측 상단 **로그인** → 로그인 페이지의 **🧪 데모 계정 선택 패널**에서 계정을 고릅니다.
3. 일반 계정으로 홈·탐색·패키지·커뮤니티·마이페이지를, **관리자 계정**으로 관리자 대시보드·운영 화면을 둘러보세요.

### 데모 계정

| 로그인 방식 | 계정(닉네임) | 자격증명 | 역할 |
| --- | --- | --- | --- |
| 카카오 | 카카오여행가 | 소셜 버튼 클릭 | 일반 |
| 네이버 | 네이버여행러 | 소셜 버튼 클릭 | 일반 |
| 구글 | 구글트래블러 | 소셜 버튼 클릭 | 일반 |
| 이메일 | 이메일여행가 | `user@test.com` / `1234` | 일반 |
| 아이디 | 여행가김철수 | `user` / `1234` | 일반 |
| **아이디(관리자)** | **최고관리자** | **`admin` / `1234`** | **관리자** |

> - 폼에 위 자격증명을 직접 입력해도 되고, 패널/소셜 버튼으로 원클릭 로그인해도 됩니다.
> - 관리자 페이지는 관리자 로그인 후 접근할 수 있습니다(미로그인 시 안내 게이트). 주소에 `?demoacct=admin` 을 붙이면 바로 진입합니다.
> - 모든 데이터는 가상 목(mock) 데이터이며 서버 호출 없이 브라우저 안에서만 동작합니다. 저장·결제는 동작하지 않습니다.

## 데모에서 볼 수 있는 것

| 영역 | 내용 |
| --- | --- |
| 홈 / 탐색 | 추천 패키지·여행지 배너, 여행지 목록과 상세(리뷰·지도·이미지) |
| 여행 패키지 | 패키지 목록·상세, 가격/일정/판매자 정보 |
| 커뮤니티 | 여행 후기·꿀팁 게시판, 게시글·댓글·태그·좋아요 |
| 여행 코스 | 직접/AI 작성 여행 일정과 방문지 |
| 마이페이지 | 예약 내역, 캐시·마일리지 지갑, 포인트 내역, 알림 |
| 포인트샵 | 닉네임 색상·뱃지·쿠폰 등 포인트 교환 아이템 |
| 관리자 | 회원/신고/문의/판매자 신청/상품 관리 운영 화면 |
| 보안 | 회원·IP 차단, 로그인 위험 탐지, AI 모더레이션 |

## 기술 스택 (원본)

| 영역 | 기술 |
| --- | --- |
| Language | Java 21 |
| Backend | Spring Boot 4.0, Spring MVC, Spring Security(CSRF) |
| Persistence | MyBatis 3, MySQL 8.0 |
| View | JSP, JSTL, Spring Message Tag (i18n) |
| 외부 연동 | OAuth(카카오/네이버/구글), Toss Payments, Cloudinary, Google Maps, Gemini/Claude/OpenAI, GCP Translate |

## 이 폴더에 대하여

- 비공개 원본 저장소의 화면을 렌더링한 **정적 스냅샷 + 목 데이터**입니다. 서버 소스 코드는 상위 저장소의 [`src/`](../src)에 있습니다.
- 화면 캡처는 [`docs/screenshots/`](docs/screenshots)에 있습니다.
- 게시 전 자격증명·내부 주소 등 민감정보 포함 여부를 [시크릿 스캔 게이트](../.github/workflows/pages.yml)로 검사한 뒤 배포합니다.
