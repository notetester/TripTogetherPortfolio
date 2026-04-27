package org.triptogether.common.resolver;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.annotation.LoginUser;

/**
 * @LoginUser UsersVO user 파라미터에 세션의 loginUser 를 자동 주입한다.
 *
 * <p>비로그인 상태면 null 을 주입한다. 메서드에 @RequireLogin / @RequireAdmin 이 붙어 있으면
 * AOP 가 먼저 차단하므로 컨트롤러 본문은 user 가 항상 non-null 이라고 가정해도 안전하다.</p>
 *
 * 정책: ADR-0011 (@LoginUser 파라미터 자동 주입)
 */
@Component
public class LoginUserArgumentResolver implements HandlerMethodArgumentResolver {

    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.hasParameterAnnotation(LoginUser.class)
                && UsersVO.class.isAssignableFrom(parameter.getParameterType());
    }

    @Override
    public Object resolveArgument(MethodParameter parameter,
                                  ModelAndViewContainer mavContainer,
                                  NativeWebRequest webRequest,
                                  WebDataBinderFactory binderFactory) {
        HttpServletRequest request = webRequest.getNativeRequest(HttpServletRequest.class);
        if (request == null) return null;
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object loginUser = session.getAttribute("loginUser");
        return (loginUser instanceof UsersVO) ? loginUser : null;
    }
}
