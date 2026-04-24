package org.triptogether.assistant.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.assistant.vo.ChatCommentVO;
import org.triptogether.assistant.vo.ChatPostVO;

import java.util.List;

@Mapper
public interface AssistantMapper {

    int insertChatPost(ChatPostVO chatPost);

    int insertChatComment(ChatCommentVO chatComment);

    List<ChatPostVO> selectRecentChatPosts(@Param("userIdx") Long userIdx);

    List<ChatCommentVO> selectChatComments(@Param("chatPostIdx") Long chatPostIdx,
                                           @Param("userIdx") Long userIdx);

    int updateChatPostTitle(@Param("chatPostIdx") Long chatPostIdx,
                            @Param("userIdx") Long userIdx,
                            @Param("title") String title);

    int deleteChatComments(@Param("chatPostIdx") Long chatPostIdx,
                           @Param("userIdx") Long userIdx);

    int deleteChatPost(@Param("chatPostIdx") Long chatPostIdx,
                       @Param("userIdx") Long userIdx);

    Integer selectMaxCommentOrder(@Param("chatPostIdx") Long chatPostIdx);
}