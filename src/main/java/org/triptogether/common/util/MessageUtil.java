package org.triptogether.common.util;

import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

/**
 * i18n 메시지 조회 헬퍼.
 *
 * <p>현재 요청의 Locale (LocaleContextHolder) 기준으로 messages 번들에서 메시지를 가져온다.
 * Service / Controller 어디서든 주입 받아 {@code msg.get("community.api.error.loginRequired")}
 * 형태로 사용한다.</p>
 *
 * <p>정책: ADR-0013 (API 응답 메시지 i18n 적용 — JSP 외 영역까지 4개 언어 일관 적용)</p>
 */
@Component
@RequiredArgsConstructor
public class MessageUtil {

    private final MessageSource messageSource;

    /** 단순 키 조회. 대응 메시지가 없으면 messageSource 기본 동작에 따라 키 코드 자체를 반환한다. */
    public String get(String code) {
        return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
    }

    /** {0}, {1} 같은 placeholder 가 있는 메시지용. */
    public String get(String code, Object... args) {
        return messageSource.getMessage(code, args, LocaleContextHolder.getLocale());
    }
}
