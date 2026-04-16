package org.triptogether.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.community.vo.*;
import java.util.List;

@Mapper
public interface CommunityMapper {

    // ===== 목록 =====
    // 검색 조건에 맞는 게시글 목록 조회
    List<CommunityPostDto> selectPostList(CommunitySearchDto search);
    // 검색 조건에 맞는 게시글 총 개수 조회 (페이지네이션용)
    int selectTotalCount(CommunitySearchDto search);

    // ===== 상세 =====
    // 게시글 하나 조회
    CommunityPostDto selectPost(@Param("postId") Long postId);
    // 게시글 이미지 목록 조회 (sort_order 순)
    List<CommunityPostImageDto> selectImageList(@Param("postId") Long postId);
    // 게시글 태그 목록 조회
    List<String> selectTagList(@Param("postId") Long postId);
    // 댓글 목록 조회 (ACTIVE/BLOCKED 상태만, 정렬 선택 가능)
    List<CommunityCommentDto> selectCommentList(@Param("postId") Long postId, @Param("sort") String sort);
    // 댓글 하나 조회 (대댓글 알림용)
    CommunityCommentDto selectComment(@Param("commentId") Long commentId);
    // 팁 카테고리 조회
    String selectTipCategory(@Param("postId") Long postId);
    // 질문 해결 여부 조회 (1: 해결, 0: 미해결)
    Integer selectIsSolved(@Param("postId") Long postId);
    // 추천 게시글 목록 조회 (같은 태그 기반)
    List<CommunityPostDto> selectRelatedList(@Param("postId") Long postId);
    // 최신 게시글 목록 조회 (excludeIds 제외)
    List<CommunityPostDto> selectLatestList(@Param("excludeIds") List<Long> excludeIds,
                                            @Param("pageSize") int pageSize,
                                            @Param("offset") int offset);
    // 최신 게시글 총 개수 조회
    int selectLatestTotalCount(@Param("excludeIds") List<Long> excludeIds);

    // ===== 조회수 =====
    // 조회수 1 증가
    void updateViewCount(@Param("postId") Long postId);

    // ===== 글쓰기 =====
    // 게시글 INSERT. useGeneratedKeys → post.postId에 자동 주입됨
    void insertPost(CommunityPostDto post);
    // 게시글 지역/유형 업데이트
    void updatePostRegionType(@Param("postId") Long postId,
                              @Param("region") String region,
                              @Param("postType") String postType);
    // 유저가 직접 업로드한 이미지 INSERT
    void insertImage(@Param("postId") Long postId,
                     @Param("imageUrl") String imageUrl,
                     @Param("sortOrder") int sortOrder);
    // Pixabay 자동추천 이미지 INSERT (이미지 없을 때 대신 배정됨)
    void insertAutoImage(@Param("postId") Long postId,
                         @Param("imageUrl") String imageUrl);
    // 태그 없으면 INSERT, 있으면 무시 (UPSERT)
    void upsertTag(@Param("tagName") String tagName);
    // 태그 ID 조회
    Long selectTagId(@Param("tagName") String tagName);
    // 게시글-태그 연결 INSERT
    void insertPostTag(@Param("postId") Long postId, @Param("tagId") Long tagId);
    // 팁 카테고리 INSERT (tip 유형 게시글 전용)
    void insertPostTip(@Param("postId") Long postId, @Param("tipCategory") String tipCategory);
    // 질문 초기화 INSERT (question 유형 게시글 전용)
    void insertPostQuestion(@Param("postId") Long postId);

    // ===== 수정 =====
    // 게시글 제목/본문 수정
    void updatePost(@Param("postId") Long postId,
                    @Param("title") String title,
                    @Param("content") String content);
    // 게시글 이미지 전체 삭제 (수정 시 전부 지우고 다시 등록함)
    void deleteImages(@Param("postId") Long postId);
    // 게시글 태그 연결 전체 삭제 (수정 시 전부 지우고 다시 등록함)
    void deletePostTags(@Param("postId") Long postId);
    // 팁 카테고리 수정 (없으면 INSERT, 있으면 UPDATE)
    void upsertPostTip(@Param("postId") Long postId,
                       @Param("tipCategory") String tipCategory);

    // ===== 삭제 =====
    // 게시글 status 변경 (소프트 딜리트: 'DELETED' / 차단: 'BLOCKED')
    void updatePostStatus(@Param("postId") Long postId, @Param("status") String status);

    // ===== 좋아요 =====
    // 해당 유저의 좋아요 여부 확인 (0: 없음, 1: 있음)
    int selectLikeCount(@Param("postId") Long postId, @Param("userIdx") Long userIdx);
    // 게시글 좋아요 수 조회
    int selectPostLikeCount(@Param("postId") Long postId);
    // 좋아요 INSERT
    void insertLike(@Param("postId") Long postId, @Param("userIdx") Long userIdx);
    // 좋아요 DELETE
    void deleteLike(@Param("postId") Long postId, @Param("userIdx") Long userIdx);
    // 좋아요 수 캐시 +1
    void increaseLikeCount(@Param("postId") Long postId);
    // 좋아요 수 캐시 -1
    void decreaseLikeCount(@Param("postId") Long postId);

    // ===== 댓글 =====
    // 댓글 INSERT
    void insertComment(CommunityCommentDto comment);
    // 댓글 status 변경 (소프트 딜리트: 'DELETED' / 차단: 'BLOCKED')
    void updateCommentStatus(@Param("commentId") Long commentId, @Param("status") String status);
    // 댓글 ID로 게시글 ID 조회 (댓글 삭제 시 comment_count 감소용)
    Long selectPostIdByCommentId(@Param("commentId") Long commentId);
    // 게시글 댓글 수 캐시 +1
    void increaseCommentCount(@Param("postId") Long postId);
    // 게시글 댓글 수 캐시 -1
    void decreaseCommentCount(@Param("postId") Long postId);

    // ===== 대댓글 =====
    // 대댓글 INSERT
    void insertReply(CommunityCommentDto comment);

    // ===== 댓글 좋아요 =====
    // 해당 유저의 댓글 좋아요 여부 확인 (0: 없음, 1: 있음)
    int selectCommentLikeCount(@Param("commentId") Long commentId, @Param("userIdx") Long userIdx);
    // 댓글 좋아요 수 조회
    int selectCommentLikeCountById(@Param("commentId") Long commentId);
    // 댓글 좋아요 INSERT
    void insertCommentLike(@Param("commentId") Long commentId, @Param("userIdx") Long userIdx);
    // 댓글 좋아요 DELETE
    void deleteCommentLike(@Param("commentId") Long commentId, @Param("userIdx") Long userIdx);
    // 댓글 좋아요 수 캐시 +1
    void increaseCommentLikeCount(@Param("commentId") Long commentId);
    // 댓글 좋아요 수 캐시 -1
    void decreaseCommentLikeCount(@Param("commentId") Long commentId);

    // ===== 질문 채택 =====
    // 댓글 채택 처리 (is_solved = 1, accepted_comment_id 업데이트)
    void acceptComment(@Param("postId") Long postId, @Param("commentId") Long commentId);
    // 채택된 댓글 ID 조회
    Long selectAcceptedCommentId(@Param("postId") Long postId);

    // ===== 태그 공출현 =====
    // 태그 두 개 간 공출현 횟수 +1 (없으면 INSERT, 있으면 UPDATE)
    void upsertTagRelation(@Param("tagIdA") Long tagIdA, @Param("tagIdB") Long tagIdB);
    // 게시글의 태그 ID 목록 조회 (공출현 계산용)
    List<Long> selectTagIdList(@Param("postId") Long postId);

    // ===== 신고 =====
    // 게시글 신고 INSERT
    int insertReport(@Param("postId") Long postId, @Param("userIdx") Long userIdx);
    // 댓글 신고 INSERT
    int reportComment(@Param("commentId") Long commentId, @Param("userIdx") Long userIdx);
    // 게시글 신고 횟수 조회
    int selectPostReportCount(@Param("postId") Long postId);
    // 댓글 신고 횟수 조회
    int selectCommentReportCount(@Param("commentId") Long commentId);
    // 게시글 신고 횟수 캐시 +1
    void increasePostReportCount(@Param("postId") Long postId);
    // 댓글 신고 횟수 캐시 +1
    void increaseCommentReportCount(@Param("commentId") Long commentId);

    // ===== 차단 (어드민) =====
    // 유저 차단 (account_status = 'BLOCKED')
    void blockUser(@Param("userIdx") Long userIdx);
    // 유저 차단 해제 (account_status = 'ACTIVE')
    void unblockUser(@Param("userIdx") Long userIdx);
    // 게시글 차단 (post_status = 'BLOCKED')
    void blockPost(@Param("postId") Long postId);
    // 게시글 차단 해제
    void unblockPost(@Param("postId") Long postId);
    // 댓글/대댓글 차단 (comment_status = 'BLOCKED')
    void blockComment(@Param("commentId") Long commentId);
    // 댓글/대댓글 차단 해제
    void unblockComment(@Param("commentId") Long commentId);

    // ===== IP 저장 =====
    // 게시글 작성 IP 저장
    void updatePostIp(@Param("postId") Long postId, @Param("ipAddress") String ipAddress);
    // 댓글/대댓글 작성 IP 저장
    void updateCommentIp(@Param("commentId") Long commentId, @Param("ipAddress") String ipAddress);

    // ===== 일괄 처리 (게시글) =====
    // 여러 게시글의 작성자 userIdx 목록 조회
    List<Long>   selectUserIdxsByPostIds(@Param("postIds") List<Long> postIds);
    // 여러 게시글의 IP 목록 조회
    List<String> selectIpsByPostIds(@Param("postIds") List<Long> postIds);
    // 여러 게시글 한번에 소프트 딜리트
    void bulkDeletePosts(@Param("postIds") List<Long> postIds);
    // 여러 유저 한번에 차단
    void bulkBlockUsers(@Param("userIdxes") List<Long> userIdxes);

    // ===== 일괄 처리 (댓글/대댓글) =====
    // 여러 댓글의 작성자 userIdx 목록 조회
    List<Long>   selectUserIdxsByCommentIds(@Param("commentIds") List<Long> commentIds);
    // 여러 댓글의 IP 목록 조회
    List<String> selectIpsByCommentIds(@Param("commentIds") List<Long> commentIds);
    // 여러 댓글 한번에 소프트 딜리트
    void bulkDeleteComments(@Param("commentIds") List<Long> commentIds);

    // ===== 오늘 인기 게시글 =====
    // 오늘 작성된 게시글 중 좋아요 순 상위 목록 조회
    List<CommunityPostDto> selectTodayPopularList();

    // ===== 인기 게시글 (전체 기간) =====
    // 좋아요 순 상위 목록 조회 (limit 지정)
    List<CommunityPostDto> selectPopularList(@Param("limit") int limit);

    // ===== 도배 방지 =====
    // 최근 N분 내 해당 유저의 게시글 작성 수 조회
    int countRecentPostsByUser(@Param("userIdx") Long userIdx, @Param("minutes") int minutes);
    // 최근 N분 내 해당 유저의 댓글/대댓글 작성 수 조회
    int countRecentCommentsByUser(@Param("userIdx") Long userIdx, @Param("minutes") int minutes);

}
