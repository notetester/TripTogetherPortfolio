package org.triptogether.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 컨트롤러 메서드 파라미터에 붙이면 LoginUserArgumentResolver 가 세션의 loginUser 를 자동 주입한다.
 * 비로그인 상태면 null 이 주입되므로 사전에 @RequireLogin / @RequireAdmin 으로 보장하는 것을 권장.
 *
 * 정책: ADR-0011 (어노테이션 기반 권한 체크)
 */
@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
public @interface LoginUser {
}
