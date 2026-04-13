package org.triptogether.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.common.vo.UserActivityLogVO;

@Mapper
public interface ActivityLogMapper {
    void insertActivityLog(UserActivityLogVO log);
}
