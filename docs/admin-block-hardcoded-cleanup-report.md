# AdminBlockServiceImpl Legacy Korean Cleanup Report

## Scope

`AdminBlockServiceImpl.java`에 남아 있던 한국어 예외 메시지/운영 메모를 정리했다.

## 처리 방식

| Type | Before | After |
|---|---|---|
| 사용자/관리자에게 노출될 수 있는 예외 메시지 | 한국어 문장 | `admin.blocks.error.*` 메시지 코드 |
| DB 운영 메모/상태 사유 | 한국어 문장 | `ADMIN_BLOCK.*` reason code |
| 변경 요약 문자열 | 한국어 조합 | 영문/코드형 토큰 |
| 표시 fallback | `개별 규칙`, `없음` | `-` |

## 추가 메시지

`admin_ko/en/ja/zh.properties`에 `admin.blocks.error.*` 키를 4언어로 추가했다.

## 검증 결과

```text
AdminBlockServiceImpl.java Korean direct string: 0
AdminBlockController.java Korean direct string: 0
admin_ko/en/ja/zh.properties key count: matched
```

## 후속 권장

DB에 이미 저장된 과거 한국어 운영 메모가 있다면, 별도 백필 SQL로 `reason_code/reason_args` 형태로 점진 전환할 수 있다.
