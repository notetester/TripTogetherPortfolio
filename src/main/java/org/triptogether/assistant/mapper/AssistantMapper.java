package org.triptogether.assistant.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.assistant.vo.ChatCommentVO;
import org.triptogether.assistant.vo.ChatPostVO;

@Mapper
public interface AssistantMapper {

    int insertChatPost(ChatPostVO chatPost);
    int insertChatComment(ChatCommentVO chatComment);
}