package org.triptogether.community.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.triptogether.cloudinary.CloudinaryService;
import org.triptogether.community.mapper.CommunityMapper;
import org.triptogether.community.vo.*;
import org.triptogether.config.IpBlockMapper;
import org.triptogether.explore.service.SpotTextTranslationService;
import org.triptogether.moderation.service.ModerationPolicyService;
import org.triptogether.moderation.vo.ContentModerationPolicyVO;
import org.triptogether.myPage.function.NotificationUrlBuilder;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.reward.service.RewardService;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService {

    private final CommunityMapper communityMapper;
    private final CommunityImageScheduler communityImageScheduler;
    private final CloudinaryService cloudinaryService;
    private final MyPageService myPageService;
    private final IpBlockMapper ipBlockMapper;
    private final SpotTextTranslationService spotTextTranslationService;
    private final RewardService rewardService;
    private final ModerationPolicyService moderationPolicyService;

    // ===== 목록 =====

    // 검색 조건에 맞는 게시글 목록 가져옴
    @Override
    public List<CommunityPostDto> getPostList(CommunitySearchDto search) {
        List<CommunityPostDto> postList = communityMapper.selectPostList(search);
        spotTextTranslationService.translateCommunityPosts(postList);
        return postList;
    }

    // 검색 조건에 맞는 게시글 총 개수 가져옴 (페이지네이션용)
    @Override
    public int getTotalCount(CommunitySearchDto search) {
        return communityMapper.selectTotalCount(search);
    }

    // 총 페이지 수 계산함 (올림 처리)
    @Override
    public int getTotalPage(CommunitySearchDto search) {
        int totalCount = communityMapper.selectTotalCount(search);
        return (int) Math.ceil((double) totalCount / search.getPageSize());
    }

    // ===== 상세 =====

    // 게시글 하나 가져옴
    @Override
    public CommunityPostDto getPost(Long postId) {
        CommunityPostDto post = communityMapper.selectPost(postId);
        spotTextTranslationService.translateCommunityPost(post);
        return post;
    }

    // 게시글에 첨부된 이미지 목록 가져옴
    @Override
    public List<CommunityPostImageDto> getImageList(Long postId) {
        return communityMapper.selectImageList(postId);
    }

    // 게시글에 달린 태그 목록 가져옴
    @Override
    public List<String> getTagList(Long postId) {
        List<String> tagList = communityMapper.selectTagList(postId);
        return spotTextTranslationService.translateCommunityTags(tagList);
    }

    // 댓글 목록 가져옴 (기본 정렬: 최신순)
    @Override
    public List<CommunityCommentDto> getCommentList(Long postId) {
        List<CommunityCommentDto> commentList = communityMapper.selectCommentList(postId, "created");
        spotTextTranslationService.translateCommunityComments(commentList);
        return commentList;
    }

    // 댓글 목록 가져옴 (sort: created=최신순 / likes=좋아요순)
    @Override
    public List<CommunityCommentDto> getCommentList(Long postId, String sort) {
        List<CommunityCommentDto> commentList = communityMapper.selectCommentList(postId, sort);
        spotTextTranslationService.translateCommunityComments(commentList);
        return commentList;
    }

    // 댓글 하나 가져옴 (대댓글 알림 발송할 때 부모 댓글 조회에 씀)
    @Override
    public CommunityCommentDto getComment(Long commentId) {
        return communityMapper.selectComment(commentId);
    }

    // 팁 카테고리 가져옴 (tip 유형 게시글 전용)
    @Override
    public String getTipCategory(Long postId) {
        return communityMapper.selectTipCategory(postId);
    }

    // 질문 해결 여부 가져옴 (1이면 해결, 나머지는 미해결)
    @Override
    public boolean isSolved(Long postId) {
        Integer result = communityMapper.selectIsSolved(postId);
        return result != null && result == 1;
    }

    // 같은 태그 기반 추천 게시글 목록 가져옴
    @Override
    public List<CommunityPostDto> getRelatedList(Long postId) {
        List<CommunityPostDto> relatedList = communityMapper.selectRelatedList(postId);
        spotTextTranslationService.translateCommunityPosts(relatedList);
        return relatedList;
    }

    // 최신 게시글 목록 가져옴 (이미 보여준 게시글 ID는 excludeIds로 제외)
    @Override
    public List<CommunityPostDto> getLatestList(List<Long> excludeIds, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        List<CommunityPostDto> latestList = communityMapper.selectLatestList(excludeIds, pageSize, offset);
        spotTextTranslationService.translateCommunityPosts(latestList);
        return latestList;
    }

    // 최신 게시글 총 개수 가져옴
    @Override
    public int getLatestTotalCount(List<Long> excludeIds) {
        return communityMapper.selectLatestTotalCount(excludeIds);
    }

    // 최신 게시글 총 페이지 수 계산함
    @Override
    public int getLatestTotalPage(List<Long> excludeIds, int pageSize) {
        int total = communityMapper.selectLatestTotalCount(excludeIds);
        return (int) Math.ceil((double) total / pageSize);
    }

    // ===== 조회수 =====

    // 조회수 1 올림
    @Override
    public void increaseViewCount(Long postId) {
        communityMapper.updateViewCount(postId);
    }

    // ===== 글쓰기 =====

    // 게시글 작성함. 도배 방지 → 저장 → 이미지 → 태그 순으로 처리함. 생성된 postId 반환
    @Override
    @Transactional
    public Long writePost(CommunityWriteDto writeDto, Long userIdx) {

        ContentModerationPolicyVO policy = moderationPolicyService.getPolicy();
        if (communityMapper.countRecentPostsByUser(userIdx, policy.getPostWindowMinutes()) >= policy.getPostMaxCount()) {
            throw new IllegalStateException(
                    policy.getPostWindowMinutes() + "분 내 게시글을 " + policy.getPostMaxCount() + "개 이상 작성할 수 없습니다.");
        }

        // 1. COMMUNITY_POST INSERT
        CommunityPostDto post = new CommunityPostDto();
        post.setUserIdx(userIdx);
        post.setTitle(writeDto.getTitle());
        post.setContent(writeDto.getContent());
        communityMapper.insertPost(post);
        Long postId = post.getPostId(); // useGeneratedKeys로 자동 주입

        // 2. 지역/유형 업데이트
        communityMapper.updatePostRegionType(postId, writeDto.getRegion(), writeDto.getPostType());

        // 3. COMMUNITY_POST_IMAGE INSERT (이미지 파일 업로드)
        int imageSortOrder = 1;
        if (writeDto.getImages() != null && !writeDto.getImages().isEmpty()) {
            for (MultipartFile file : writeDto.getImages()) {
                if (file == null || file.isEmpty()) continue;
                String savedUrl = saveFile(file);
                if (savedUrl != null) {
                    communityMapper.insertImage(postId, savedUrl, imageSortOrder++);
                }
            }
        }
        // 이미지 없으면 Pixabay 자동추천 이미지 배정
        if (imageSortOrder == 1) {
            assignAutoImage(postId, writeDto.getRegion());
        }

        // 4. COMMUNITY_TAG UPSERT + COMMUNITY_POST_TAG INSERT
        if (writeDto.getTags() != null && !writeDto.getTags().isEmpty()) {
            String[] tagArr = writeDto.getTags().split(",");
            for (String tagName : tagArr) {
                tagName = tagName.trim();
                if (tagName.isEmpty()) continue;
                communityMapper.upsertTag(tagName);
                Long tagId = communityMapper.selectTagId(tagName);
                communityMapper.insertPostTag(postId, tagId);
            }
        }

        // 5. COMMUNITY_POST_TIP INSERT (tip 유형)
        if ("tip".equals(writeDto.getPostType())) {
            String tipCategory = writeDto.getTipCategory() != null
                    ? writeDto.getTipCategory() : "other";
            communityMapper.insertPostTip(postId, tipCategory);
        }

        // 6. COMMUNITY_POST_QUESTION INSERT (question 유형)
        if ("question".equals(writeDto.getPostType())) {
            communityMapper.insertPostQuestion(postId);
        }

        // 7. 태그 공출현 업데이트
        updateTagRelation(postId);

        rewardService.awardAction(
                userIdx,
                "COMMUNITY_POST",
                postId,
                0L,
                "커뮤니티 게시글 작성 보상"
        );

        return postId;
    }

    // ===== 수정 =====

    // 게시글 수정함. 이미지/태그는 전부 지우고 다시 등록함
    @Override
    @Transactional
    public void editPost(Long postId, CommunityWriteDto writeDto,
                         List<String> existingImages, Long userIdx) {

        // 1. COMMUNITY_POST 제목/본문 수정
        communityMapper.updatePost(postId, writeDto.getTitle(), writeDto.getContent());

        // 2. 지역/유형 수정
        communityMapper.updatePostRegionType(postId, writeDto.getRegion(), writeDto.getPostType());

        // 3. 이미지 처리 - 기존 이미지 전부 삭제 후 재등록
        communityMapper.deleteImages(postId);

        // 3-1. 기존 이미지 중 유지할 것 재등록 (자동추천 URL은 http로 시작 → 제외)
        int sortOrder = 1;
        if (existingImages != null) {
            for (String imageUrl : existingImages) {
                if (imageUrl == null || imageUrl.startsWith("http")) continue;
                communityMapper.insertImage(postId, imageUrl, sortOrder++);
            }
        }

        // 3-2. 새로 추가된 이미지 저장
        if (writeDto.getImages() != null) {
            for (MultipartFile file : writeDto.getImages()) {
                if (file == null || file.isEmpty()) continue;
                String savedUrl = saveFile(file);
                if (savedUrl != null) {
                    communityMapper.insertImage(postId, savedUrl, sortOrder++);
                }
            }
        }

        // 이미지 없으면 Pixabay 자동추천 이미지 재배정
        if (sortOrder == 1) {
            assignAutoImage(postId, writeDto.getRegion());
        }

        // 4. 태그 처리 - 기존 태그 전부 삭제 후 재등록
        communityMapper.deletePostTags(postId);

        if (writeDto.getTags() != null && !writeDto.getTags().isEmpty()) {
            String[] tagArr = writeDto.getTags().split(",");
            for (String tagName : tagArr) {
                tagName = tagName.trim();
                if (tagName.isEmpty()) continue;
                communityMapper.upsertTag(tagName);
                Long tagId = communityMapper.selectTagId(tagName);
                communityMapper.insertPostTag(postId, tagId);
            }
        }

        // 5. tip 카테고리 수정
        if ("tip".equals(writeDto.getPostType())) {
            String tipCategory = writeDto.getTipCategory() != null
                    ? writeDto.getTipCategory() : "other";
            communityMapper.upsertPostTip(postId, tipCategory);
        }

        // 6. 태그 공출현 업데이트
        updateTagRelation(postId);
    }

    // ===== 삭제 =====

    // 게시글 삭제함. 실제 삭제가 아니라 status를 'DELETED'로 바꿈 (소프트 딜리트)
    @Override
    @Transactional
    public void deletePost(Long postId) {
        communityMapper.updatePostStatus(postId, "DELETED");
    }

    // ===== 좋아요 =====

    // 해당 유저가 이 게시글에 좋아요 눌렀는지 확인함
    @Override
    public boolean isLiked(Long postId, Long userIdx) {
        return communityMapper.selectLikeCount(postId, userIdx) > 0;
    }

    // 좋아요 토글함. 눌렀으면 취소, 안 눌렀으면 추가. true면 좋아요 추가된 상태
    @Override
    @Transactional
    public boolean toggleLike(Long postId, Long userIdx) {
        if (isLiked(postId, userIdx)) {
            // 좋아요 취소
            communityMapper.deleteLike(postId, userIdx);
            communityMapper.decreaseLikeCount(postId);
            return false;
        } else {
            // 좋아요 추가
            communityMapper.insertLike(postId, userIdx);
            communityMapper.increaseLikeCount(postId);
            // 알림 발송 (본인 글 제외)
            CommunityPostDto post = communityMapper.selectPost(postId);
            if (post != null && !post.getUserIdx().equals(userIdx)) {
                FeedNotificationDto notification = new FeedNotificationDto();
                notification.setUserIdx(post.getUserIdx());
                notification.setSourceType("community");
                notification.setSourceId(postId);
                notification.setMessage("내 글에 좋아요가 달렸어요.");
                notification.setTargetUrl(NotificationUrlBuilder.community(postId));
                myPageService.addNotification(notification);

                rewardService.awardAction(
                        userIdx,
                        "COMMUNITY_POST_LIKE_ACTION",
                        buildRewardSourceId(postId, userIdx),
                        0L,
                        "커뮤니티 게시글 좋아요 실행 보상"
                );

                rewardService.awardAction(
                        post.getUserIdx(),
                        "COMMUNITY_POST_LIKE",
                        buildRewardSourceId(postId, userIdx),
                        0L,
                        "커뮤니티 게시글 좋아요 수신 보상"
                );
            }
            return true;
        }
    }

    // 게시글 좋아요 수 가져옴
    @Override
    public int getLikeCount(Long postId) {
        return communityMapper.selectPostLikeCount(postId);
    }

    // ===== 댓글 =====

    // 댓글 작성함. 도배 방지 체크 후 저장함. 생성된 commentId 반환
    @Override
    @Transactional
    public Long addComment(Long postId, Long userIdx, String content) {
        ContentModerationPolicyVO policy = moderationPolicyService.getPolicy();
        if (communityMapper.countRecentCommentsByUser(userIdx, policy.getCommentWindowMinutes()) >= policy.getCommentMaxCount()) {
            throw new IllegalStateException(
                    policy.getCommentWindowMinutes() + "분 내 댓글을 " + policy.getCommentMaxCount() + "개 이상 작성할 수 없습니다.");
        }
        CommunityCommentDto dto = new CommunityCommentDto();
        dto.setPostId(postId);
        dto.setUserIdx(userIdx);
        dto.setContent(content);
        communityMapper.insertComment(dto);
        communityMapper.increaseCommentCount(postId);

        // 글 작성자에게 알림 생성 (본인 글에 본인 댓글이면 제외)
        CommunityPostDto post = communityMapper.selectPost(postId);
        if (post != null && !post.getUserIdx().equals(userIdx)) {
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(post.getUserIdx());
            notification.setSourceType("community");
            notification.setSourceId(postId);
            notification.setMessage("내 글에 새 댓글이 달렸어요.");
            notification.setTargetUrl(NotificationUrlBuilder.communityComment(postId, dto.getCommentId()));
            myPageService.addNotification(notification);
        }
        rewardService.awardAction(
                userIdx,
                "COMMUNITY_COMMENT",
                dto.getCommentId(),
                0L,
                "커뮤니티 댓글 작성 보상"
        );

        return dto.getCommentId();
    }

    // 댓글 삭제함. 소프트 딜리트 + 댓글 수 캐시 감소
    @Override
    @Transactional
    public void deleteComment(Long commentId) {
        // comment_status = 'DELETED' 로 변경 (실제 삭제 X)
        communityMapper.updateCommentStatus(commentId, "DELETED");
        Long postId = communityMapper.selectPostIdByCommentId(commentId);
        if (postId != null) {
            communityMapper.decreaseCommentCount(postId);
        }
    }

    // ===== 대댓글 =====

    // 대댓글 작성함. 도배 방지 체크 후 저장함. 생성된 commentId 반환
    @Override
    @Transactional
    public Long addReply(Long postId, Long userIdx, String content, Long parentCommentId) {
        ContentModerationPolicyVO policy = moderationPolicyService.getPolicy();
        if (communityMapper.countRecentCommentsByUser(userIdx, policy.getCommentWindowMinutes()) >= policy.getCommentMaxCount()) {
            throw new IllegalStateException(
                    policy.getCommentWindowMinutes() + "분 내 댓글을 " + policy.getCommentMaxCount() + "개 이상 작성할 수 없습니다.");
        }
        CommunityCommentDto dto = new CommunityCommentDto();
        dto.setPostId(postId);
        dto.setUserIdx(userIdx);
        dto.setContent(content);
        dto.setParentCommentId(parentCommentId);
        communityMapper.insertReply(dto);
        communityMapper.increaseCommentCount(postId);

        // 글 작성자에게 알림 생성 (본인 글에 본인 대댓글이면 제외)
        CommunityPostDto post = communityMapper.selectPost(postId);
        if (post != null && !post.getUserIdx().equals(userIdx)) {
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(post.getUserIdx());
            notification.setSourceType("community");
            notification.setSourceId(postId);
            notification.setMessage("내 글에 새 대댓글이 달렸어요.");
            notification.setTargetUrl(NotificationUrlBuilder.communityComment(postId, dto.getCommentId()));
            myPageService.addNotification(notification);
        }

        // 부모 댓글 작성자에게 알림 생성 (글 작성자와 중복이면 제외)
        CommunityCommentDto parentComment = communityMapper.selectComment(parentCommentId);
        if (parentComment != null && !parentComment.getUserIdx().equals(userIdx)) {
            // 부모 댓글 작성자 != 글 작성자인 경우에만 알림 (중복 방지)
            if (post == null || !parentComment.getUserIdx().equals(post.getUserIdx())) {
                FeedNotificationDto notification = new FeedNotificationDto();
                notification.setUserIdx(parentComment.getUserIdx());
                notification.setSourceType("community");
                notification.setSourceId(postId);
                notification.setMessage("내 댓글에 새 답글이 달렸어요.");
                notification.setTargetUrl(NotificationUrlBuilder.communityComment(postId, dto.getCommentId()));
                myPageService.addNotification(notification);
            }
        }
        rewardService.awardAction(
                userIdx,
                "COMMUNITY_COMMENT",
                dto.getCommentId(),
                0L,
                "커뮤니티 댓글 작성 보상"
        );

        return dto.getCommentId();
    }

    // ===== 댓글 좋아요 =====

    // 해당 유저가 이 댓글에 좋아요 눌렀는지 확인함
    @Override
    public boolean isCommentLiked(Long commentId, Long userIdx) {
        return communityMapper.selectCommentLikeCount(commentId, userIdx) > 0;
    }

    // 댓글 좋아요 토글함
    @Override
    @Transactional
    public boolean toggleCommentLike(Long commentId, Long userIdx) {
        if (isCommentLiked(commentId, userIdx)) {
            communityMapper.deleteCommentLike(commentId, userIdx);
            communityMapper.decreaseCommentLikeCount(commentId);
            return false;
        } else {
            communityMapper.insertCommentLike(commentId, userIdx);
            communityMapper.increaseCommentLikeCount(commentId);

            CommunityCommentDto comment = communityMapper.selectComment(commentId);
            if (comment != null && !comment.getUserIdx().equals(userIdx)) {
                rewardService.awardAction(
                        userIdx,
                        "COMMUNITY_COMMENT_LIKE_ACTION",
                        buildRewardSourceId(commentId, userIdx),
                        0L,
                        "커뮤니티 댓글 좋아요 실행 보상"
                );

                rewardService.awardAction(
                        comment.getUserIdx(),
                        "COMMUNITY_COMMENT_LIKE",
                        buildRewardSourceId(commentId, userIdx),
                        0L,
                        "커뮤니티 댓글 좋아요 수신 보상"
                );
            }
            return true;
        }
    }

    // 댓글 좋아요 수 가져옴
    @Override
    public int getCommentLikeCount(Long commentId) {
        return communityMapper.selectCommentLikeCountById(commentId);
    }

    // ===== 질문 채택 =====

    // 질문 게시글에서 특정 댓글을 채택된 답변으로 표시함
    @Override
    @Transactional
    public void acceptComment(Long postId, Long commentId) {
        communityMapper.acceptComment(postId, commentId);
    }

    // 채택된 댓글 ID 가져옴
    @Override
    public Long getAcceptedCommentId(Long postId) {
        return communityMapper.selectAcceptedCommentId(postId);
    }

    // ===== 태그 공출현 =====

    // 이 게시글의 태그들 간 공출현 관계를 업데이트함 (태그 추천 기능용)
    @Override
    public void updateTagRelation(Long postId) {
        List<Long> tagIds = communityMapper.selectTagIdList(postId);
        if (tagIds == null || tagIds.size() < 2) return;
        // 태그 쌍마다 공출현 횟수 +1
        for (int i = 0; i < tagIds.size(); i++) {
            for (int j = i + 1; j < tagIds.size(); j++) {
                communityMapper.upsertTagRelation(tagIds.get(i), tagIds.get(j));
            }
        }
    }

    // ===== 신고 =====

    // 게시글 신고 횟수 캐시 업데이트함. 3회 이상이면 리스트/상세에서 BLUR 처리됨 (post_status 는 ACTIVE 유지)
    @Override
    @Transactional
    public void updatePostReportCache(Long postId) {
        CommunityPostDto post = communityMapper.selectPost(postId);
        if (post == null) return;
        boolean wasBlurred = (post.getReportCount() >= 3) || post.isAiFlagged();
        communityMapper.increasePostReportCount(postId);
        boolean nowBlurred = ((post.getReportCount() + 1) >= 3) || post.isAiFlagged();
        if (!wasBlurred && nowBlurred) {
            notifyPostBlurred(post, "다수의 신고");
        }
    }

    // 댓글 신고 횟수 캐시 업데이트함. 3회 이상이면 리스트/상세에서 BLUR 처리됨 (comment_status 는 ACTIVE 유지)
    @Override
    @Transactional
    public void updateCommentReportCache(Long commentId) {
        CommunityCommentDto comment = communityMapper.selectComment(commentId);
        if (comment == null) return;
        boolean wasBlurred = (comment.getReportCount() >= 3) || comment.isAiFlagged();
        communityMapper.increaseCommentReportCount(commentId);
        boolean nowBlurred = ((comment.getReportCount() + 1) >= 3) || comment.isAiFlagged();
        if (!wasBlurred && nowBlurred) {
            notifyCommentBlurred(comment, "다수의 신고");
        }
    }

    // 게시글 신고 횟수 가져옴
    @Override
    public int getPostReportCount(Long postId) {
        return communityMapper.selectPostReportCount(postId);
    }

    // ===== AI 욕설 감지 =====

    // 게시글 AI 감지 플래그 세팅 (비동기 Perspective 검사 후 호출됨)
    @Override
    @Transactional
    public void flagPostAsToxic(Long postId) {
        CommunityPostDto post = communityMapper.selectPost(postId);
        if (post == null) return;
        boolean wasBlurred = (post.getReportCount() >= 3) || post.isAiFlagged();
        communityMapper.setPostAiFlagged(postId);
        if (!wasBlurred) {
            notifyPostBlurred(post, "부적절한 표현 감지");
        }
    }

    // 댓글 AI 감지 플래그 세팅
    @Override
    @Transactional
    public void flagCommentAsToxic(Long commentId) {
        CommunityCommentDto comment = communityMapper.selectComment(commentId);
        if (comment == null) return;
        boolean wasBlurred = (comment.getReportCount() >= 3) || comment.isAiFlagged();
        communityMapper.setCommentAiFlagged(commentId);
        if (!wasBlurred) {
            notifyCommentBlurred(comment, "부적절한 표현 감지");
        }
    }

    // BLUR 전환 시 작성자에게 알림 발송 (글)
    private void notifyPostBlurred(CommunityPostDto post, String cause) {
        FeedNotificationDto notification = new FeedNotificationDto();
        notification.setUserIdx(post.getUserIdx());
        notification.setSourceType("community");
        notification.setSourceId(post.getPostId());
        notification.setMessage("작성하신 글이 " + cause + "으로 가림 처리되었어요.");
        notification.setTargetUrl(NotificationUrlBuilder.community(post.getPostId()));
        myPageService.addNotification(notification);
    }

    // BLUR 전환 시 작성자에게 알림 발송 (댓글)
    private void notifyCommentBlurred(CommunityCommentDto comment, String cause) {
        FeedNotificationDto notification = new FeedNotificationDto();
        notification.setUserIdx(comment.getUserIdx());
        notification.setSourceType("community");
        notification.setSourceId(comment.getPostId());
        notification.setMessage("작성하신 댓글이 " + cause + "으로 가림 처리되었어요.");
        notification.setTargetUrl(NotificationUrlBuilder.communityComment(comment.getPostId(), comment.getCommentId()));
        myPageService.addNotification(notification);
    }

    // 게시글 BLUR 해제 (관리자: ai_flagged=0 + report_count=0)
    @Override
    @Transactional
    public void clearPostBlur(Long postId) {
        communityMapper.clearPostBlur(postId);
    }

    // 댓글 BLUR 해제 (관리자: ai_flagged=0 + report_count=0)
    @Override
    @Transactional
    public void clearCommentBlur(Long commentId) {
        communityMapper.clearCommentBlur(commentId);
    }

    // 댓글 신고 횟수 가져옴
    @Override
    public int getCommentReportCount(Long commentId) {
        return communityMapper.selectCommentReportCount(commentId);
    }

    // ===== 차단 (어드민) =====

    // 유저 차단함 (account_status = 'BLOCKED')
    @Override
    public void blockUser(Long userIdx) {
        communityMapper.blockUser(userIdx);
    }

    // 유저 차단 해제함 (account_status = 'ACTIVE')
    @Override
    public void unblockUser(Long userIdx) {
        communityMapper.unblockUser(userIdx);
    }

    // 게시글 차단함 (post_status = 'BLOCKED')
    @Override
    public void blockPost(Long postId) {
        communityMapper.blockPost(postId);
    }

    // 게시글 차단 해제함
    @Override
    public void unblockPost(Long postId) {
        communityMapper.unblockPost(postId);
    }

    // 댓글/대댓글 차단함 (comment_status = 'BLOCKED')
    @Override
    public void blockComment(Long commentId) {
        communityMapper.blockComment(commentId);
    }

    // 댓글/대댓글 차단 해제함
    @Override
    public void unblockComment(Long commentId) {
        communityMapper.unblockComment(commentId);
    }

    // ===== IP 저장 =====

    // 게시글 작성 시 IP 저장함
    @Override
    public void savePostIp(Long postId, String ipAddress) {
        if (ipAddress != null) communityMapper.updatePostIp(postId, ipAddress);
    }

    // 댓글/대댓글 작성 시 IP 저장함
    @Override
    public void saveCommentIp(Long commentId, String ipAddress) {
        if (ipAddress != null) communityMapper.updateCommentIp(commentId, ipAddress);
    }

    // ===== 일괄 처리 (게시글) =====

    // 여러 게시글 한번에 삭제함 (소프트 딜리트)
    @Override
    @Transactional
    public void bulkDeletePosts(List<Long> postIds) {
        if (postIds == null || postIds.isEmpty()) return;
        communityMapper.bulkDeletePosts(postIds);
    }

    // 여러 게시글 작성자 한번에 차단함
    @Override
    @Transactional
    public void bulkBlockUsersByPosts(List<Long> postIds) {
        if (postIds == null || postIds.isEmpty()) return;
        List<Long> userIdxes = communityMapper.selectUserIdxsByPostIds(postIds);
        if (!userIdxes.isEmpty()) communityMapper.bulkBlockUsers(userIdxes);
    }

    // 여러 게시글의 IP 목록 가져옴
    @Override
    public List<String> getIpsByPostIds(List<Long> postIds) {
        if (postIds == null || postIds.isEmpty()) return List.of();
        return communityMapper.selectIpsByPostIds(postIds);
    }

    // ===== 일괄 처리 (댓글/대댓글) =====

    // 여러 댓글 한번에 삭제함 (소프트 딜리트)
    @Override
    @Transactional
    public void bulkDeleteComments(List<Long> commentIds) {
        if (commentIds == null || commentIds.isEmpty()) return;
        communityMapper.bulkDeleteComments(commentIds);
    }

    // 여러 댓글 작성자 한번에 차단함
    @Override
    @Transactional
    public void bulkBlockUsersByComments(List<Long> commentIds) {
        if (commentIds == null || commentIds.isEmpty()) return;
        List<Long> userIdxes = communityMapper.selectUserIdxsByCommentIds(commentIds);
        if (!userIdxes.isEmpty()) communityMapper.bulkBlockUsers(userIdxes);
    }

    // 여러 댓글의 IP 목록 가져옴
    @Override
    public List<String> getIpsByCommentIds(List<Long> commentIds) {
        if (commentIds == null || commentIds.isEmpty()) return List.of();
        return communityMapper.selectIpsByCommentIds(commentIds);
    }

    // 전체 기간 좋아요 순 상위 목록 가져옴
    @Override
    public List<CommunityPostDto> getPopularList(int limit) {
        List<CommunityPostDto> popularList = communityMapper.selectPopularList(limit);
        spotTextTranslationService.translateCommunityPosts(popularList);
        return popularList;
    }

    // ===== private 유틸 =====

    // Pixabay 자동추천 이미지 배정함 (이미지 없는 게시글에 지역별 기본 이미지 넣어줌)
    private void assignAutoImage(Long postId, String region) {
        try {
            String imageUrl = communityImageScheduler.getRandomImage(region);
            if (imageUrl != null) {
                communityMapper.insertAutoImage(postId, imageUrl);
            }
        } catch (Exception e) {
            log.warn("자동추천 이미지 배정 실패 (postId={}, region={}): {}", postId, region, e.getMessage());
        }
    }

    // 이미지 파일 Cloudinary에 업로드하고 URL 반환함
    /**
     * 히스토리 테이블 source_id가 Long 하나만 받기 때문에
     * 좋아요 대상 ID와 좋아요를 누른 사용자 ID를 합쳐서
     * 동일 사용자-동일 대상 조합의 중복 지급을 막는다.
     */
    private Long buildRewardSourceId(Long targetId, Long actorUserIdx) {
        if (targetId == null || actorUserIdx == null) {
            return null;
        }
        return (targetId * 1_000_000L) + actorUserIdx;
    }

    private String saveFile(MultipartFile file) {
        return cloudinaryService.uploadImage(file, "community");
    }

}
