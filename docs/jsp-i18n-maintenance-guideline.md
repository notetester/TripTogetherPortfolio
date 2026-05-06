# TripTogether JSP i18n 유지보수성 복구 보고서

## 문제

`TripTogether(46)` 전면 정적 점검 패치에서 JSP attribute 내부의 `<spring:message>` 직접 삽입을 제거하는 과정에서 `autoMsg_xxx` 형태의 난수형 변수명이 대량 생성되었다.

이 방식은 동작 안정성만 보고 적용된 자동 치환 결과이며, 유지보수 관점에서는 부적절하다.

## 원칙

- 일반 본문 출력은 `<spring:message code="..."/>`를 그대로 사용한다.
- HTML/JSP tag attribute 안에서만 `<spring:message var="의미있는변수명" code="..."/>`로 분리한다.
- 변수명은 메시지 코드에서 의미가 드러나도록 `adminDashboardTotalMembersMsg` 같은 형태로 생성한다.
- `autoMsg_xxx` 같은 난수형 변수명은 금지한다.
- attribute 내부의 `<c:out>` 직접 삽입은 `fn:escapeXml(...)` 기반 EL로 처리한다.

## 이번 복구

- `autoMsg_` 변수 선언 및 사용을 전면 제거했다.
- 본문 텍스트 출력은 `<spring:message code="..."/>`로 복원했다.
- attribute/script/style/tag 내부에서 변수 참조가 필요한 경우만 메시지 코드 기반 의미 변수명으로 유지했다.
- JSP/JSPF attribute 내부 `<spring:message>` / `<c:out>` 직접 삽입 패턴은 다시 생기지 않게 검증했다.

## 검증 결과

- `autoMsg_` 잔존: 0건
- JSP/JSPF attribute 내부 `<spring:message>` 직접 삽입: 0건
- JSP/JSPF attribute 내부 `<c:out>` 직접 삽입: 0건
- 남은 `<spring:message var="...">` 선언 수: 1327건

참고: `<script>` 블록 내부에 코드가 직접 보이는 `<spring:message code="..." javaScriptEscape="true"/>` 형식은 기존 JS 지역화 방식이며, 난수 변수 문제가 아니므로 이번 복구 대상에서 제외했다. 해당 패턴은 123건이다.
