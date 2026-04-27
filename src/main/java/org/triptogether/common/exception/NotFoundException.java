package org.triptogether.common.exception;

/** 자원 없음(404). 도메인 단위로 명시적 NotFound 를 던질 때 사용. */
public class NotFoundException extends BusinessException {

    public NotFoundException(String message) {
        super(404, message);
    }

    public NotFoundException() {
        this("요청한 자원을 찾을 수 없습니다.");
    }
}
