package org.triptogether.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 컨트롤러 메서드에 붙이면 AOP(AuthorizationAspect)가 진입 직전 운영진(ADMIN/SUPERADMIN) 권한을 확인한다.
 * 미인증 시 UnauthorizedException(401), 권한 부족 시 ForbiddenException(403) 을 던진다.
 *
 * 정책: ADR-0011 (어노테이션 기반 권한 체크)
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface RequireAdmin {
}
