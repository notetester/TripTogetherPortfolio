package org.triptogether.config;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Spring MVC 공통 설정.
 *
 * <p>현재 프로젝트에서 이 설정 클래스는 크게 두 가지 역할을 맡는다.</p>
 * <ol>
 *     <li>파일 업로드 디렉터리를 /upload/** URL로 노출</li>
 *     <li>로그인/관리자 전용 인터셉터를 경로별로 등록</li>
 * </ol>
 */
@Configuration
@RequiredArgsConstructor
public class WebConfig implements WebMvcConfigurer {

    /**
     * application.properties 의 상대 경로.
     * 예: src/main/resources/upload/
     */
    @Value("${file.upload.path}")
    private String uploadPath;

    private final LoginInterceptor loginInterceptor;
    private final AdminInterceptor adminInterceptor;
    private final AdminModeInterceptor adminModeInterceptor;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Windows / Linux / macOS 모두 동일하게 처리되도록 경로 구분자를 정규화한다.
        String fullPath = System.getProperty("user.dir").replace("\\", "/") + "/" + uploadPath;

        // /upload/** 요청을 실제 파일 시스템 디렉터리로 매핑한다.
        // 예: /TripTogether/upload/community/xxx.jpg
        registry.addResourceHandler("/upload/**")
                .addResourceLocations("file:" + fullPath);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 일반 로그인 필요 영역
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns(
                        "/mypage/**",
                        "/auth/link/**",
                        "/inquiry/**"
                )
                .excludePathPatterns(
                        "/mypage/temp",
                        "/mypage/temp/**"
                );

        // 관리자 전용 영역
        registry.addInterceptor(adminInterceptor)
                .addPathPatterns("/admin/**");

        // 전체 페이지 어드민모드 인터셉터
        registry.addInterceptor(adminModeInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/resources/**", "/upload/**", "/api/**");
    }
}
