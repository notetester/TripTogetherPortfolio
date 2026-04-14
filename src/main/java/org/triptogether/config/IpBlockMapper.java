package org.triptogether.config;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IpBlockMapper {

    /** IP가 차단 목록에 존재하는지 확인 */
    boolean isBlocked(String ipAddress);

    /** IP 단건 차단 등록 */
    void insertBlockedIp(@Param("ipAddress") String ipAddress,
                         @Param("reason")    String reason);

    /** IP 다건 차단 등록 (bulk) */
    void insertBlockedIps(@Param("list")   List<String> ipAddresses,
                          @Param("reason") String reason);

    /** IP 차단 해제 */
    void deleteBlockedIp(String ipAddress);
}
