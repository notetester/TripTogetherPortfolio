package org.triptogether.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Value("${file.upload.path}")
    private String uploadPath;
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // windows와 Linux/Mac 이 경로 구분자가 다르기 때문에 통일 시키는 코드
        String fullPath = System.getProperty("user.dir").replace("\\", "/")+ "/"+ uploadPath;
        //  /upload/** 요청을  src/main/resources/upload/ 파일 시스템 경로 매핑
        registry.addResourceHandler("/upload/**").addResourceLocations("file:"+fullPath);
    }
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //마이페이지, 즐겨찾기, 좋아요 기능에 필터ㄱ
        //WebMvcConfigurer.super.addInterceptors(registry);
        // 관리자 페이지 접근 제한 (/admin/** 전체)
        registry.addInterceptor(new AdminInterceptor())
                .addPathPatterns("/admin/**");
    }
}
