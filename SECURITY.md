# 보안 정책 (Security Policy)

## 이 저장소에 대하여

이 저장소는 비공개로 개발된 팀 프로젝트 **TripTogether**의 **공개 포트폴리오 미러**입니다.
공개에 앞서, 원본 저장소에 포함되어 있던 **모든 민감정보를 전체 커밋 이력에서 제거**했습니다.

## 민감정보 제거 범위

`git filter-repo`의 **값 기반 치환(replace-text)** 으로, 최신 커밋뿐 아니라 **모든 커밋·모든 파일**에서 다음을 제거했습니다.

- 데이터베이스 비밀번호 및 접속 호스트(IP)
- 소셜 로그인(OAuth) Client ID / Client Secret — Kakao · Naver · Google
- 외부 API 키 — Google Maps · Gemini · GCP Translate · OpenAI · Claude · Perspective · Pixabay · Cloudinary
- 결제(Toss Payments) 테스트 키
- 메일(SMTP) 계정 및 앱 비밀번호

제거된 값은 모두 `YOUR_GOOGLE_MAPS_API_KEY` 형태의 **플레이스홀더**로 치환되어 있습니다.

> 참고: 위 자격증명은 공개 시점 기준으로 **이미 모두 만료/회전(rotate)** 된 것이지만, 포트폴리오의 보안 관점에서 흔적까지 남기지 않기 위해 이력에서 완전히 제거했습니다.

## 발행 단계 시크릿 게이트

GitHub Actions 배포 워크플로(`.github/workflows/pages.yml`)에는 **시크릿 스캔 게이트**가 포함되어 있어,
키/비밀번호 패턴이 다시 유입되면 **배포가 중단**됩니다.

## 로컬 실행 시 설정

`src/main/resources/application.properties`의 `YOUR_*` 플레이스홀더를 본인 환경의 값으로 채운 뒤 실행합니다.
로컬 전용 오버라이드는 `application-local.properties`(Git 미추적)에 둘 수 있습니다.

## 취약점 제보

보안 이슈를 발견하면 공개 이슈 대신 저장소 소유자에게 직접 연락 바랍니다.
