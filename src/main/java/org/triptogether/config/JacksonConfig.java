package org.triptogether.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 프로젝트 공통 Jackson 설정.
 *
 * <p>Spring Boot 4 + webmvc 조합에서 ObjectMapper 빈이 자동 등록되지 않는 환경을 대비해
 * 명시적으로 등록한다. 차단 규칙 파일 캐시와 향후 JSON 직렬화 구성에서 공통으로 사용한다.</p>
 */
@Configuration
public class JacksonConfig {

    @Bean
    public ObjectMapper objectMapper() {
        return JsonMapper.builder()
                .addModule(new JavaTimeModule())
                .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
                .build();
    }
}