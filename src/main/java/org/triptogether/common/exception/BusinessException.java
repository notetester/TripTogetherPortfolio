package org.triptogether.common.exception;

/**
 * 도메인 정책 위반 등 비즈니스 레벨 예외의 베이스.
 * GlobalExceptionHandler 에서 httpStatus 와 message 를 그대로 응답에 사용한다.
 *
 * 정책: ADR-0011 (도메인 예외 + 글로벌 예외 처리)
 */
public class BusinessException extends RuntimeException {

    private final int httpStatus;

    public BusinessException(int httpStatus, String message) {
        super(message);
        this.httpStatus = httpStatus;
    }

    public int getHttpStatus() {
        return httpStatus;
    }
}
