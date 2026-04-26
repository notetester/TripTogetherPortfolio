package org.triptogether.common.aop;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.exception.ForbiddenException;
import org.triptogether.common.exception.UnauthorizedException;

/**
 * @RequireLogin / @RequireAdmin 어노테이션이 붙은 컨트롤러 메서드 진입 직전에 권한을 검증한다.
 *
 * <p>실패 시 BusinessException 계열 예외를 던지며, GlobalExceptionHandler 가 표준 응답으로 변환한다.
 * 세션 추출은 RequestContextHolder 를 통해 직접 가져오므로 별도 의존 주입 없이 동작한다.</p>
 *
 * 정책: ADR-0011 (어노테이션 기반 권한 체크 + AOP)
 */
@Aspect
@Component
public class AuthorizationAspect {

    @Before("@annotation(org.triptogether.common.annotation.RequireLogin)")
    public void checkLogin() {
        if (currentLoginUser() == null) {
            throw new UnauthorizedException();
        }
    }

    @Before("@annotation(org.triptogether.common.annotation.RequireAdmin)")
    public void checkAdmin() {
        UsersVO user = currentLoginUser();
        if (user == null) {
            throw new UnauthorizedException();
        }
        if (!user.hasAdminRole()) {
            throw new ForbiddenException("운영진만 접근할 수 있습니다.");
        }
    }

    private UsersVO currentLoginUser() {
        ServletRequestAttributes attrs =
                (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (attrs == null) return null;
        HttpServletRequest request = attrs.getRequest();
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object loginUser = session.getAttribute("loginUser");
        return (loginUser instanceof UsersVO) ? (UsersVO) loginUser : null;
    }
}
