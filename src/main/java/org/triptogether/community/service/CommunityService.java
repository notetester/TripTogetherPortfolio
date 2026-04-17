package org.triptogether.community.service;

import org.triptogether.community.vo.*;
import java.util.List;

public interface CommunityService {

    // ===== 목록 =====
    // 검색 조건에 맞는 게시글 목록 가져옴
    List<CommunityPostDto> getPostList(CommunitySearchDto search);
    // 검색 조건에 맞는 게시글 총 개수 가져옴 (페이지네이션용)
    int getTotalCount(CommunitySearchDto search);
    // 총 페이지 수 계산
    int getTotalPage(CommunitySearchDto search);

    // ===== 상세 =====
    // 게시글 하나 가져옴
    CommunityPostDto getPost(Long postId);
    // 게시글에 첨부된 이미지 목록 가져옴
    List<CommunityPostImageDto> getImageList(Long postId);
    // 게시글에 달린 태그 목록 가져옴
    List<String> getTagList(Long postId);
    // 댓글 목록 가져옴 (기본 정렬: 최신순)
    List<CommunityCommentDto> getCommentList(Long postId);
    // 댓글 목록 가져옴 (sort: created / likes)
    List<CommunityCommentDto> getCommentList(Long postId, String sort);
    // 댓글 하나 가져옴 (알림용)
    CommunityCommentDto getComment(Long commentId);
    // 팁 카테고리 가져옴 (tip 유형 게시글 전용)
    String getTipCategory(Long postId);
    // 질문 해결 여부 가져옴 (question 유형 게시글 전용)
    boolean isSolved(Long postId);
    // 같은 태그 기반 추천 게시글 목록 가져옴
    List<CommunityPostDto> getRelatedList(Long postId);
    // 최신 게시글 목록 가져옴 (excludeIds: 이미 보여준 게시글은 제외)
    List<CommunityPostDto> getLatestList(List<Long> excludeIds, int page, int pageSize);
    // 최신 게시글 총 개수 가져옴
    int getLatestTotalCount(List<Long> excludeIds);
    // 최신 게시글 총 페이지 수 계산
    int getLatestTotalPage(List<Long> excludeIds, int pageSize);

    // ===== 조회수 =====
    // 조회수 1 올림
    void increaseViewCount(Long postId);

    // ===== 글쓰기 =====
    // 게시글 작성. 도배 방지 → 저장 → 이미지 → 태그 순으로 처리함. 생성된 postId 반환
    Long writePost(CommunityWriteDto writeDto, Long userIdx);

    // ===== 수정 =====
    // 게시글 수정. 이미지/태그는 전부 지우고 다시 등록함
    void editPost(Long postId, CommunityWriteDto writeDto, List<String> existingImages, Long userIdx);

    // ===== 삭제 =====
    // 게시글 삭제. 실제 삭제가 아니라 status를 'DELETED'로 바꿈 (소프트 딜리트)
    void deletePost(Long postId);

    // ===== 좋아요 =====
    // 해당 유저가 이 게시글에 좋아요 눌렀는지 확인
    boolean isLiked(Long postId, Long userIdx);
    // 좋아요 토글. 눌렀으면 취소, 안 눌렀으면 추가. true면 좋아요 추가된 상태
    boolean toggleLike(Long postId, Long userIdx);
    // 좋아요 수 가져옴
    int getLikeCount(Long postId);

    // ===== 댓글 =====
    // 댓글 작성. 도배 방지 체크 후 저장함. 생성된 commentId 반환
    Long addComment(Long postId, Long userIdx, String content);
    // 댓글 삭제. 소프트 딜리트
    void deleteComment(Long commentId);

    // ===== 대댓글 =====
    // 대댓글 작성. 도배 방지 체크 후 저장함. 생성된 commentId 반환
    Long addReply(Long postId, Long userIdx, String content, Long parentCommentId);

    // ===== 댓글 좋아요 =====
    // 해당 유저가 이 댓글에 좋아요 눌렀는지 확인
    boolean isCommentLiked(Long commentId, Long userIdx);
    // 댓글 좋아요 토글
    boolean toggleCommentLike(Long commentId, Long userIdx);
    // 댓글 좋아요 수 가져옴
    int getCommentLikeCount(Long commentId);

    // ===== 질문 채택 =====
    // 질문 게시글에서 특정 댓글을 채택된 답변으로 표시함
    void acceptComment(Long postId, Long commentId);
    // 채택된 댓글 ID 가져옴
    Long getAcceptedCommentId(Long postId);

    // ===== 태그 공출현 =====
    // 이 게시글의 태그들 간 공출현 관계를 업데이트함 (태그 추천 기능용)
    void updateTagRelation(Long postId);

    // ===== 신고 =====
    // 게시글 신고 횟수 캐시 업데이트. 3회 이상이면 자동 차단함
    void updatePostReportCache(Long postId);
    // 댓글 신고 횟수 캐시 업데이트. 3회 이상이면 자동 차단함
    void updateCommentReportCache(Long commentId);
    // 게시글 신고 횟수 가져옴
    int getPostReportCount(Long postId);
    // 댓글 신고 횟수 가져옴
    int getCommentReportCount(Long commentId);

    // ===== 차단 (어드민) =====
    // 유저 차단/해제
    void blockUser(Long userIdx);
    void unblockUser(Long userIdx);
    // 게시글 차단/해제
    void blockPost(Long postId);
    void unblockPost(Long postId);
    // 댓글/대댓글 차단/해제
    void blockComment(Long commentId);
    void unblockComment(Long commentId);

    // ===== IP 저장 =====
    // 게시글 작성 시 IP 저장
    void savePostIp(Long postId, String ipAddress);
    // 댓글/대댓글 작성 시 IP 저장
    void saveCommentIp(Long commentId, String ipAddress);

    // ===== 일괄 처리 (게시글) =====
    // 여러 게시글 한번에 삭제
    void bulkDeletePosts(List<Long> postIds);
    // 여러 게시글 작성자 한번에 차단
    void bulkBlockUsersByPosts(List<Long> postIds);
    // 여러 게시글의 IP 목록 가져옴
    List<String> getIpsByPostIds(List<Long> postIds);

    // ===== 일괄 처리 (댓글/대댓글) =====
    // 여러 댓글 한번에 삭제
    void bulkDeleteComments(List<Long> commentIds);
    // 여러 댓글 작성자 한번에 차단
    void bulkBlockUsersByComments(List<Long> commentIds);
    // 여러 댓글의 IP 목록 가져옴
    List<String> getIpsByCommentIds(List<Long> commentIds);

    // ===== 인기 게시글 (전체 기간) =====
    // 좋아요 순 상위 목록 가져옴 (limit 지정)
    List<CommunityPostDto> getPopularList(int limit);

}
