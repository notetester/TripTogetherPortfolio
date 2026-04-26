package org.triptogether.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 컨트롤러 메서드에 붙이면 AOP(AuthorizationAspect)가 진입 직전 세션의 loginUser 존재를 확인한다.
 * 미인증 시 UnauthorizedException(401) 을 던지고, GlobalExceptionHandler 가 표준 응답으로 변환한다.
 *
 * 정책: ADR-0011 (어노테이션 기반 권한 체크)
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface RequireLogin {
}
