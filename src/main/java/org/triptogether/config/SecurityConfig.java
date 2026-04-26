package org.triptogether.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.RequestMatcher;

/**
 * Spring Security 설정.
 *
 * <p>본 프로젝트는 자체 세션 + 인터셉터 + AOP 로 인증/인가를 처리하므로,
 * Spring Security 의 인증 메커니즘은 비활성화하고 <b>CSRF 보호만</b> 활용한다.</p>
 *
 * <h3>CSRF 적용 범위 (부분 도입)</h3>
 * <ul>
 *   <li>적용: 본인 담당 모듈 — {@code /community, /report, /inquiry} 의 POST/PUT/DELETE</li>
 *   <li>미적용: 그 외 모든 요청 (점진적 확장 예정)</li>
 * </ul>
 *
 * <p>정책: ADR-0012 (Spring Security CSRF 부분 도입 + 점진적 확장)</p>
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // 모든 인증/인가는 자체 인터셉터/AOP 가 담당.
                // Spring Security 는 CSRF 보호 용도로만 사용.
                .authorizeHttpRequests(auth -> auth.anyRequest().permitAll())

                // 본인 담당 모듈의 변경 요청에 대해서만 CSRF 토큰 검증
                .csrf(csrf -> csrf.requireCsrfProtectionMatcher(victorModuleMatcher()))

                // Spring Security 기본 로그인 폼/HTTP Basic/로그아웃 비활성화 (자체 시스템 사용)
                .formLogin(form -> form.disable())
                .httpBasic(basic -> basic.disable())
                .logout(logout -> logout.disable());

        return http.build();
    }

    /**
     * CSRF 검증 대상 매처: Victor 담당 모듈의 변경 요청.
     * GET 은 본질적으로 CSRF 무관하므로 제외.
     *
     * Spring Security 7+ 에서 AntPathRequestMatcher 가 제거되어 람다(RequestMatcher functional interface) 사용.
     * URI 는 contextPath 를 포함하므로 contains() 로 매칭한다.
     */
    private RequestMatcher victorModuleMatcher() {
        return request -> {
            String method = request.getMethod();
            if (!"POST".equalsIgnoreCase(method)
                    && !"PUT".equalsIgnoreCase(method)
                    && !"DELETE".equalsIgnoreCase(method)) {
                return false;
            }
            String uri = request.getRequestURI();
            if (uri == null) return false;
            return uri.contains("/community/")
                    || uri.contains("/report/")
                    || uri.contains("/inquiry/");
        };
    }
}
