package org.triptogether.moderation.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.moderation.vo.ContentModerationPolicyVO;

@Mapper
public interface ModerationMapper {

    ContentModerationPolicyVO selectPolicy();

    int updatePolicy(ContentModerationPolicyVO policy);
}
