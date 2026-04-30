package org.triptogether.config;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.common.vo.IpBlockRuleVO;
import org.triptogether.common.vo.UserBlockRuleVO;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface IpBlockMapper {

    /** 현재 유효한 IP 차단 규칙 목록 조회 */
    List<IpBlockRuleVO> findActiveIpBlockRules();

    /** 현재 유효한 회원 차단 규칙 목록 조회 */
    List<UserBlockRuleVO> findActiveUserBlockRules();

    /** 레거시 단일 IP 차단 등록 */
    void insertBlockedIp(@Param("ipAddress") String ipAddress,
                         @Param("reason") String reason);

    /** 레거시 다건 IP 차단 등록 (bulk) */
    void insertBlockedIps(@Param("list") List<String> ipAddresses,
                          @Param("reason") String reason);

    /** 관리자 차단 이력과 연결된 IP 차단 규칙 등록/갱신 */
    void upsertBlockedIpWithHistory(@Param("ipAddress") String ipAddress,
                                    @Param("blockTargetKey") String blockTargetKey,
                                    @Param("reason") String reason,
                                    @Param("userIdx") Long userIdx,
                                    @Param("blockType") String blockType,
                                    @Param("blockedByUserIdx") Long blockedByUserIdx,
                                    @Param("expiresAt") LocalDateTime expiresAt,
                                    @Param("blockRequestId") String blockRequestId,
                                    @Param("sourceHistoryBlockIdx") Long sourceHistoryBlockIdx,
                                    @Param("sourceBlocklistIdx") Long sourceBlocklistIdx);

    /** 특정 IP에 대해 가장 최근의 활성 USER_BLOCK_HISTORY 기반 규칙 조회 */
    IpBlockRuleVO findLatestActiveHistoryRuleByIp(@Param("ipAddress") String ipAddress);

    /** 사용자와 연결된 현재 IP 차단 규칙 비활성화 */
    void deactivateBlockedIpsByUser(@Param("userIdx") Long userIdx,
                                    @Param("releasedByUserIdx") Long releasedByUserIdx);

    /** 현재 IP 차단 규칙 비활성화 */
    void deactivateBlockedIpByTargetKey(@Param("blockTargetKey") String blockTargetKey,
                                        @Param("releasedByUserIdx") Long releasedByUserIdx);

    /** USER_ACTION 범위의 현재 IP 차단 규칙 비활성화 */
    void deactivateUserActionBlockedIpByTargetKey(@Param("blockTargetKey") String blockTargetKey,
                                                  @Param("releasedByUserIdx") Long releasedByUserIdx);
}
