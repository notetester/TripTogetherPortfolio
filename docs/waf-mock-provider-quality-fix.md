# WAF Mock/Demo Provider Routing Fix

## Problem

Demo WAF providers can use `mock://` endpoints. These endpoints must never be passed to Java's real `HttpClient`.

Observed failure pattern:

```text
[WAF] sync provider call failed
java.lang.IllegalArgumentException: invalid URI scheme mock
```

## Root Cause

`MockWafSyncAdapter` only supported `MOCK_WAF_SERVICE`. Demo provider codes such as `DEMO_AWS_WAF_REGIONAL`, `DEMO_CLOUDFLARE_DIRECT`, and `DEMO_MOCK_WAF_SERVICE` were not caught by the mock adapter and could flow into `GenericWafCdnHttpAdapter` and `WafSyncHttpClient`.

## Code Fix

### MockWafSyncAdapter

The adapter now handles WAF providers when one of these is true:

- `providerCode == MOCK_WAF_SERVICE`
- `providerCode` starts with `DEMO_`
- `providerCode` contains `_MOCK_`
- `providerCode` ends with `_MOCK`
- `providerCode` contains `MOCK_WAF`
- `endpointUrl` starts with `mock://`
- `modelName` starts with `mock-`
- `modelName` contains `mode=mock`

### GenericWafCdnHttpAdapter

The generic HTTP adapter now supports only `http://` or `https://` endpoints. Non-HTTP schemes are not considered external HTTP providers.

### WafSyncHttpClient

The HTTP client has a final guard:

- Demo/mock providers are locally completed as `SYNCED` with `MOCK_SYNCED` detail.
- Blank endpoints fail with a clear message.
- Non-`http`/`https` schemes fail before `HttpRequest` construction.

## DB Fix

`LOGIN_RISK_WAF_SYNC_QUEUE.status` must support `EXTERNAL_PROVIDER_PENDING`, which is 25 characters. The column is widened from `varchar(20)` to `varchar(40)`.

Migration:

```text
docs/migration/20260513_waf_mock_provider_and_status_fix.sql
```

## Expected Result

These warnings should disappear:

```text
invalid URI scheme mock
[WAF] sync provider call failed
```

For demo/mock providers, WAF queue detail should include:

```text
result=MOCK_SYNCED
Demo/mock WAF endpoint was handled locally without an external HTTP request.
```

## Verification

Run locally:

```bash
mvn -DskipTests compile
```

Then start the application and check that WAF scheduled sync no longer emits `invalid URI scheme mock` warnings.
