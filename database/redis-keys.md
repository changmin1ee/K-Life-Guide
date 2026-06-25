# K-Life-Guide Redis 키 설계

대상 용도: JWT 블랙리스트, 미션 목록 캐시

## 1. JWT 블랙리스트

### 목적
로그아웃 / 비밀번호 변경 / 강제 차단(`users.status = SUSPENDED`) 등으로 access token의 자연 만료 전에 무효화해야 하는 경우를 처리.

### 전제: JWT에 `jti` claim 추가 필요
현재 `JwtTokenProvider`는 `jti`를 발급하지 않음. 블랙리스트는 토큰 단위 식별자가 있어야 의미가 있으므로 토큰 생성 시 `jti`(UUID)를 claim에 포함하고, `JwtAuthenticationFilter`에서 인증 처리 전에 블랙리스트 여부를 조회하도록 변경이 필요함.

### 키 패턴
| Key | Type | Value | TTL |
|---|---|---|---|
| `auth:blacklist:at:{jti}` | String | 차단 이유 (`LOGOUT`, `PASSWORD_CHANGED`, `ADMIN_FORCED`, `WITHDRAWN`) | 토큰의 잔여 만료 시간(`exp - now`) |
| `auth:refresh:{userId}` | String | refresh token (또는 해시값) | refresh token 만료 시간과 동일 |

### 동작 방식
- **로그아웃/강제 무효화 시**: `SETEX auth:blacklist:at:{jti} {remainingSeconds} "{reason}"`
  - TTL을 토큰 잔여 만료시간으로 맞춰서, 토큰이 자연 만료되는 시점에 키도 같이 사라지게 함 → 영구 적재 방지.
- **요청마다 검증**: `JwtAuthenticationFilter`가 서명 검증 통과 후 `EXISTS auth:blacklist:at:{jti}`를 확인, 존재하면 401 처리.
- **refresh token 재사용 탐지**: `auth:refresh:{userId}`에 저장된 값과 클라이언트가 보낸 refresh token이 다르면 탈취 의심 → 해당 유저의 모든 세션 강제 로그아웃(`auth:refresh:{userId}` 삭제 + 최근 발급된 access token jti들을 블랙리스트 처리는 운영상 비용이 크므로, 실무에서는 refresh 재사용 탐지만으로 충분한 경우가 많음).
- 디바이스별 다중 로그인을 지원해야 하면 `auth:refresh:{userId}:{deviceId}`로 세분화.

---

## 2. 미션 목록 캐시

### 목적
`GET /missions` (목록/필터/페이지네이션) 조회가 빈번하고 변경 빈도(관리자의 미션 등록/수정/아카이브)는 낮으므로 캐시로 MySQL 부하를 줄임.

### 캐시 무효화 전략: 버전 키
Redis 클러스터 환경에서 `KEYS`/`SCAN`으로 패턴 삭제하는 것은 비용이 크고 위험하므로, **버전 번호를 캐시 키에 포함**시켜 무효화함. 변경이 생기면 버전만 올리고, 이전 버전의 캐시는 TTL로 자연 소멸시킴.

| Key | Type | Value | TTL |
|---|---|---|---|
| `mission:list:version` | String (int) | 현재 목록 캐시 버전 (없으면 0으로 간주) | 없음(영구) |
| `mission:list:v{version}:cat:{categoryId\|ALL}:status:{status\|ALL}:page:{page}:size:{size}` | String | 미션 목록 응답 JSON | 5~10분 |
| `mission:detail:{missionId}` | String | 미션 단건 응답 JSON | 30분 |

### 동작 방식
- **목록 조회 시**:
  1. `GET mission:list:version` → `v` (없으면 0)
  2. `GET mission:list:v{v}:cat:{...}:status:{...}:page:{p}:size:{s}` 조회, 있으면 즉시 반환(cache hit)
  3. 없으면 MySQL 조회 후 `SETEX ... 600 {json}`으로 저장
- **미션 생성/수정/아카이브 시(관리자)**:
  1. `INCR mission:list:version` → 이후 목록 캐시는 자동으로 새 버전 키를 바라보게 되어 갱신됨(이전 버전 캐시는 TTL 만료까지 방치되어도 무해)
  2. 수정/아카이브된 미션이라면 `DEL mission:detail:{missionId}`로 단건 캐시 즉시 제거(단건은 키가 하나뿐이라 직접 삭제가 싸고 즉시 일관성 보장 가능)
- **상세 조회 시**: `GET mission:detail:{missionId}` cache miss면 MySQL 조회 후 `SETEX mission:detail:{missionId} 1800 {json}`

### 비고
- 캐시 값은 `ObjectMapper`로 직렬화한 DTO JSON 문자열로 저장(Lettuce + `RedisTemplate<String, String>` 또는 `@Cacheable` + `RedisCacheManager` 사용 가능).
- `@Cacheable`/`@CacheEvict` 같은 Spring Cache 어노테이션으로 구현 시에도 동일한 키 네이밍 규칙(`mission:list:v{version}:...`)을 `key = "..."` SpEL로 그대로 적용할 수 있음.
