---
layout: home

hero:
  name: TripTogether
  text: 통합 여행 플랫폼
  tagline: 여행지 탐색 · AI 추천 · 코스 작성 · 커뮤니티 · 예약 · 포인트/지갑 · 관리자 운영을 하나로 묶은 Spring Boot 기반 풀스택 프로젝트
  actions:
    - theme: brand
      text: 라이브 데모 둘러보기 →
      link: https://notetester.github.io/TripTogetherPortfolio/
    - theme: alt
      text: 프로젝트 개요
      link: /overview
    - theme: alt
      text: GitHub 소스
      link: https://github.com/notetester/TripTogetherPortfolio

features:
  - icon: 🔐
    title: 인증 · 계정 · 보안
    details: 자체 로그인 + 카카오/네이버/구글 OAuth, 이메일 인증, BCrypt, 로그인 위험도 평가와 차단/해제 흐름
    link: /auth
  - icon: 💬
    title: 커뮤니티 · 신고
    details: 게시글·댓글·태그·좋아요, Perspective 독성 감지와 신고 상태머신, 소프트 삭제 기반 운영
    link: /community
  - icon: 🗺️
    title: 여행 코스 · AI 일정
    details: 방문지 순서가 있는 여행 계획 작성, GPT 구조화 출력으로 일정 자동 생성
    link: /courses
  - icon: 🧭
    title: 탐색 · 커머스
    details: 여행지 탐색·추천, 여행 패키지 예약, 포인트샵·캐시/마일리지 지갑
    link: /explore
  - icon: 🤖
    title: AI 통합
    details: Claude 어시스턴트 · Gemini 챗봇 · GPT 일정 생성 · Perspective 모더레이션, 멀티모델 폴백
    link: /ai
  - icon: 🛠️
    title: 관리자 · 운영
    details: 회원/신고/문의 관리, 로그인·보안 감사 로그, 통계, 최고관리자(superAdmin) 운영
    link: /admin
  - icon: 📨
    title: 문의 · 알림 · 마이페이지
    details: 1:1 문의와 관리자 답변, SSE 실시간 알림, 프로필·소셜 연동 관리
    link: /inquiry
  - icon: 🧩
    title: 공통 · 인프라 · i18n
    details: 인터셉터 체인, MyBatis 매퍼, 파일 업로드(Cloudinary), 4개 국어(ko/en/ja/zh) 다국어
    link: /common
---

## 이 문서에 대하여

이 사이트는 **TripTogether** 프로젝트의 **기능별 기술 설명서**입니다. 각 도메인이 *무엇을* 하고, *왜* 그렇게 설계했으며, *어떻게* 구현됐는지를 실제 코드 기준으로 정리했습니다.

- 🔎 **라이브 데모**: 백엔드 없이 화면을 둘러볼 수 있는 정적 데모 — <https://notetester.github.io/TripTogetherPortfolio/>
- 📦 **소스 코드**: 비공개 원본에서 **API 키·비밀번호 등 민감정보를 전체 커밋 이력에서 제거**한 공개본 — [GitHub](https://github.com/notetester/TripTogetherPortfolio)
- 🧱 **기술 스택**: Spring Boot 4 · Java 21 · MyBatis · MySQL · JSP/JSTL · VitePress(문서)

> 설계 배경과 트레이드오프는 [설계 결정(ADR 종합)](/decisions) 문서에서 다룹니다.

## 데모 이용 안내

[라이브 데모](https://notetester.github.io/TripTogetherPortfolio/)는 **로그아웃 상태로 시작**하며, 로그인 화면의 **🧪 데모 계정 선택 패널**에서 가상 계정으로 로그인해 둘러볼 수 있습니다.

| 로그인 방식 | 자격증명 | 역할 |
| --- | --- | --- |
| 카카오 · 네이버 · 구글 | 소셜 버튼 클릭 | 일반 |
| 이메일 | `user@test.com` / `1234` | 일반 |
| 아이디 | `user` / `1234` | 일반 |
| 아이디(관리자) | `admin` / `1234` | **관리자** 🛠 |

::: tip 관리자 화면 바로 보기
관리자 페이지는 관리자 계정으로 로그인해야 열립니다. 데모 주소 끝에 `?demoacct=admin` 을 붙이면 바로 진입할 수 있습니다 — 예: [관리자 대시보드](https://notetester.github.io/TripTogetherPortfolio/admin.html?demoacct=admin)
:::
