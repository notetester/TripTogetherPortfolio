package org.triptogether.common.exception;

/** 인증 누락(401). 세션에 loginUser 가 없을 때 던진다. */
public class UnauthorizedException extends BusinessException {

    public UnauthorizedException(String message) {
        super(401, message);
    }

    public UnauthorizedException() {
        this("로그인이 필요합니다.");
    }
}
