package org.triptogether.config;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RuntimeSettingMapper {
    RuntimeSettingVO findActiveSettingByKey(@Param("settingKey") String settingKey);

    List<RuntimeSettingVO> findRuntimeSettings(@Param("settingGroup") String settingGroup,
                                               @Param("keyword") String keyword,
                                               @Param("includeInactive") boolean includeInactive);

    List<RuntimeSettingHistoryVO> findRuntimeSettingHistory(@Param("settingKey") String settingKey,
                                                            @Param("limit") int limit);

    RuntimeSettingVO findRuntimeSettingByIdx(@Param("settingIdx") Long settingIdx);

    RuntimeSettingVO findRuntimeSettingByKey(@Param("settingKey") String settingKey);

    void insertRuntimeSetting(RuntimeSettingVO setting);

    void updateRuntimeSetting(RuntimeSettingVO setting);

    void insertRuntimeSettingHistory(@Param("settingIdx") Long settingIdx,
                                     @Param("settingKey") String settingKey,
                                     @Param("changeType") String changeType,
                                     @Param("actorUserIdx") Long actorUserIdx,
                                     @Param("beforeValue") String beforeValue,
                                     @Param("afterValue") String afterValue,
                                     @Param("beforeFallbackValue") String beforeFallbackValue,
                                     @Param("afterFallbackValue") String afterFallbackValue,
                                     @Param("beforeConfigJson") String beforeConfigJson,
                                     @Param("afterConfigJson") String afterConfigJson);
}
