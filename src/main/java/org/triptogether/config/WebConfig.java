package org.triptogether.config;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.Locale;

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
    private final SuperAdminInterceptor superAdminInterceptor;
    private final AdminModeInterceptor adminModeInterceptor;
    private final ActivityLogInterceptor activityLogInterceptor;
    private final IpBlockInterceptor ipBlockInterceptor;
    private final NotificationInterceptor notificationInterceptor;

    /**
     * 다국어 메시지 파일을 읽는 스프링 기본 MessageSource 빈.
     *
     * <p>메시지 번들은 기능/도메인별로 분리되어 있으며, 각 basename 은 locale suffix 를 가진
     * {@code *_ko.properties}, {@code *_en.properties}, {@code *_ja.properties},
     * {@code *_zh.properties} 파일을 자동으로 읽는다.</p>
     */
    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasenames(
                "classpath:messages/admin",
                "classpath:messages/auth",
                "classpath:messages/community",
                "classpath:messages/detail",
                "classpath:messages/explore",
                "classpath:messages/footer",
                "classpath:messages/header",
                "classpath:messages/home",
                "classpath:messages/inquiry",
                "classpath:messages/mypage",
                "classpath:messages/package",
                "classpath:messages/report",
                "classpath:messages/recommend",
                "classpath:messages/shop",
                "classpath:messages/wallet"
        );
        messageSource.setDefaultEncoding("UTF-8");
        // 키를 아직 번역 파일에 넣지 못한 경우, 에러 대신 키 자체를 보여주면 누락 확인이 쉽다.
        messageSource.setUseCodeAsDefaultMessage(true);
        return messageSource;
    }

    /**
     * 현재 사용자의 언어 정보를 세션에 저장한다.
     *
     * <p>예를 들어 헤더에서 영어를 선택하면 세션에 {@code en} 이 저장되고,
     * 이후 같은 브라우저 세션에서는 계속 영어 문구를 우선 사용한다.</p>
     */
    @Bean
    public LocaleResolver localeResolver() {
        SessionLocaleResolver localeResolver = new SessionLocaleResolver();
        localeResolver.setDefaultLocale(Locale.KOREAN);
        return localeResolver;
    }

    /**
     * 요청 파라미터 {@code lang} 값을 보고 언어를 바꾼다.
     *
     * <p>예: {@code /explore?lang=en}</p>
     */
    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor();
        interceptor.setParamName("lang");
        return interceptor;
    }

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
        // 헤더 언어 선택 시 ?lang=en 같은 파라미터를 읽어 세션 locale 을 바꾼다.
        registry.addInterceptor(localeChangeInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/resources/**", "/upload/**", "/favicon.ico",
                        "/error", "/css/**", "/js/**", "/images/**"
                );

        // IP 차단
        registry.addInterceptor(ipBlockInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/resources/**", "/upload/**", "/favicon.ico",
                        "/error", "/css/**", "/js/**", "/images/**"
                );

        // 일반 활동 로그
        registry.addInterceptor(activityLogInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/resources/**", "/upload/**", "/favicon.ico",
                        "/error", "/css/**", "/js/**", "/images/**"
                );

        // 일반 로그인 필요 영역
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns(
                        "/mypage/**",
                        "/wallet/**",
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

        // 최고관리자 전용 영역
        registry.addInterceptor(superAdminInterceptor)
                .addPathPatterns("/superAdmin/**");

        // 전체 페이지 어드민모드 인터셉터
        registry.addInterceptor(adminModeInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/resources/**", "/upload/**", "/api/**");

        // 헤더 알림 데이터 주입 (로그인 유저 한정, View 있는 페이지만)
        registry.addInterceptor(notificationInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/resources/**", "/upload/**", "/api/**", "/sse/**",
                        "/favicon.ico", "/error", "/css/**", "/js/**", "/images/**"
                );
    }
}
