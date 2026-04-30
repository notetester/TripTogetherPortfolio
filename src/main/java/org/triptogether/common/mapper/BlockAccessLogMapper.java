package org.triptogether.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.common.vo.BlockAccessLogVO;

@Mapper
public interface BlockAccessLogMapper {
    void insertBlockAccessLog(BlockAccessLogVO log);
}
