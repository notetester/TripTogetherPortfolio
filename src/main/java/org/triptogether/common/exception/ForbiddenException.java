package org.triptogether.common.exception;

/** 권한 부족(403). 인증은 됐지만 운영진 권한 등이 부족할 때 던진다. */
public class ForbiddenException extends BusinessException {

    public ForbiddenException(String message) {
        super(403, message);
    }

    public ForbiddenException() {
        this("권한이 없습니다.");
    }
}
