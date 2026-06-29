# TripTogether — 라이브 데모

[![Live Demo](https://img.shields.io/badge/▶_Live_Demo-둘러보기-2ea44f?logo=github)](https://notetester.github.io/TripTogetherPortfolio/)
[![메인 README](https://img.shields.io/badge/⬆_프로젝트_메인-README-blue)](../README.md)
[![기술 설명서](https://img.shields.io/badge/📖_기술_설명서-Docs-0ea5a4)](https://notetester.github.io/TripTogetherPortfolio/docs/)

이 폴더는 **TripTogether**를 백엔드 없이 둘러볼 수 있는 **정적 데모**이며, [TripTogetherPortfolio](https://github.com/notetester/TripTogetherPortfolio) 저장소의 GitHub Pages **루트(`/`)** 로 서비스됩니다. 원본은 API 키가 포함된 비공개 저장소라, 실제 화면을 렌더링한 정적 스냅샷에 가상의 목(mock) 데이터를 입혀 게시했습니다.

### ▶ 바로 체험하기 → <https://notetester.github.io/TripTogetherPortfolio/>

> 📖 각 기능이 *무엇을·왜·어떻게* 구현됐는지는 기술 설명서에서 확인하세요 → <https://notetester.github.io/TripTogetherPortfolio/docs/>

## 데모 이용 방법

1. 위 링크로 접속합니다.
2. 홈 → 여행지 탐색 → 패키지 → 커뮤니티 → 마이페이지 순으로 둘러보세요.
3. 로그인 화면에서는 **아무 값이나 입력**하면 데모 계정으로 넘어갑니다.

> 모든 데이터는 가상의 목(mock) 데이터이며, 서버 호출 없이 브라우저 안에서만 동작합니다.
> 저장·결제·로그인 등 백엔드 처리는 동작하지 않으며, 일부 화면은 *"데모에 포함되지 않았습니다"* 안내가 표시될 수 있습니다.

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
