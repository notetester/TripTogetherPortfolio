# TripTogether 수동 마이그레이션 이력 메모

이 문서는 사람이 적용 순서를 파악하기 위한 메모입니다.  
AI 작업 컨텍스트의 핵심 기준은 `docs/security-governance-worklist.md`이며, 이 파일은 필요할 때만 참고합니다.

## 원칙

- `SCHEMA_MIGRATION_HISTORY`는 운영 기능과 연결하지 않는다.
- 이 테이블은 삭제되어도 사이트 기능에 영향이 없어야 한다.
- 실제 적용 여부는 DB에서 직접 확인한다.
- 이 문서는 사람의 수동 운영 보조용이다.

## 주요 보안 마이그레이션

- `20260501_login_risk_policy.sql`
- `20260501_login_risk_policy_demo_seed.sql`
- `20260501_login_risk_followup.sql`
- `20260501_login_risk_external_assessment_ready.sql`
- `20260501_security_risk_assessment_user_block_enhancement.sql`
- `20260501_security_appeal_public_flow.sql`
- `20260501_security_governance_cleanup.sql`
- `20260501_security_remaining_operations.sql`

## 확인 쿼리

```sql
SELECT migration_id, status, applied_at, notes
FROM SCHEMA_MIGRATION_HISTORY
ORDER BY applied_at DESC;
```

```sql
SELECT provider_code, provider_kind, is_enabled, status, endpoint_url, api_key_ref
FROM SECURITY_ASSESSMENT_PROVIDER_CONFIG
ORDER BY provider_code;
```

```sql
SELECT status, COUNT(*)
FROM LOGIN_RISK_WAF_SYNC_QUEUE
GROUP BY status;
```


## 후속 작업 원칙

- 새 코드 패치에 DB 변경이 없다면 새 SQL을 만들지 않는다.
- 과거 마이그레이션 SQL을 반복 작성하지 않는다.
- 실제 적용 여부는 DB에서 직접 확인한다.
