package org.triptogether.common.vo;

/**
 * 자동화 작업(AI 욕설 감지, 스케줄러, 배치 등)이 DB 레코드의 "주체"로 사용할
 * 시스템 봇 계정 상수.
 *
 * USERS 테이블 user_idx=18, user_role='SYSTEM', nickname='SYSTEM' 계정을 가리킨다.
 * 로그인 불가이며 감사 추적(REPORT.user_idx, *_created_by 등)에 쓰인다.
 */
public final class SystemUser {

    /** 시스템 봇 계정의 USERS.user_idx */
    public static final Long BOT_USER_IDX = 18L;

    private SystemUser() {}
}
