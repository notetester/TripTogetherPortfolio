package org.triptogether.admin.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.triptogether.admin.interceptor.AdminAssistantGuardInterceptor;

/**
 * AdminAssistantGuardInterceptor 를 /assistant/chat 경로에만 등록하는 신규 WebMvcConfigurer.
 * 기존 WebConfig(팀원 공유 영역) 을 건드리지 않기 위해 별도 @Configuration 으로 분리.
 * Spring 은 여러 WebMvcConfigurer 를 모두 적용하므로 충돌 없음.
 */
@Configuration
@RequiredArgsConstructor
public class AdminAssistantGuardConfig implements WebMvcConfigurer {

    private final AdminAssistantGuardInterceptor guardInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(guardInterceptor)
                .addPathPatterns("/assistant/chat");
    }
}
