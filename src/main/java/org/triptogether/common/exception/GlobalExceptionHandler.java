package org.triptogether.common.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

/**
 * 도메인 예외(BusinessException) 와 일반 예외를 표준 JSON 응답으로 변환.
 *
 * <p>현재 시범 적용 단계로, AJAX(@ResponseBody) 메서드에서 발생한 예외에 대해 동작한다.
 * 일반 페이지 컨트롤러는 영향을 받지 않도록 도메인 예외는 시범 적용 메서드에서만 발생시킨다.</p>
 *
 * 정책: ADR-0011 (도메인 예외 + 글로벌 예외 처리)
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<Map<String, Object>> handleBusiness(BusinessException e) {
        Map<String, Object> body = new HashMap<>();
        body.put("success", false);
        body.put("message", e.getMessage());
        return ResponseEntity.status(e.getHttpStatus()).body(body);
    }
}
