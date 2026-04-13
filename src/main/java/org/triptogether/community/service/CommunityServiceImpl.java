package org.triptogether.community.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.triptogether.community.mapper.CommunityMapper;
import org.triptogether.community.mapper.CommunityImageCacheMapper;
import org.triptogether.community.vo.*;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService {

    private final CommunityMapper communityMapper;
    private final CommunityImageCacheMapper communityImageCacheMapper;
    private final MyPageService myPageService;

    @Value("${file.upload.path}")
    private String uploadPath;

    // ===== 목록 =====

    @Override
    public List<CommunityPostDto> getPostList(CommunitySearchDto search) {
        return communityMapper.selectPostList(search);
    }

    @Override
    public int getTotalCount(CommunitySearchDto search) {
        return communityMapper.selectTotalCount(search);
    }

    @Override
    public int getTotalPage(CommunitySearchDto search) {
        int totalCount = communityMapper.selectTotalCount(search);
        return (int) Math.ceil((double) totalCount / search.getPageSize());
    }

    // ===== 상세 =====

    @Override
    public CommunityPostDto getPost(Long postId) {
        return communityMapper.selectPost(postId);
    }

    @Override
    public List<CommunityPostImageDto> getImageList(Long postId) {
        return communityMapper.selectImageList(postId);
    }

    @Override
    public List<String> getTagList(Long postId) {
        return communityMapper.selectTagList(postId);
    }

    @Override
    public List<CommunityCommentDto> getCommentList(Long postId) {
        return communityMapper.selectCommentList(postId, "created");
    }

    @Override
    public List<CommunityCommentDto> getCommentList(Long postId, String sort) {
        return communityMapper.selectCommentList(postId, sort);
    }

    @Override
    public CommunityCommentDto getComment(Long commentId) {
        return communityMapper.selectComment(commentId);
    }

    @Override
    public String getTipCategory(Long postId) {
        return communityMapper.selectTipCategory(postId);
    }

    @Override
    public boolean isSolved(Long postId) {
        Integer result = communityMapper.selectIsSolved(postId);
        return result != null && result == 1;
    }

    @Override
    public List<CommunityPostDto> getRelatedList(Long postId) {
        return communityMapper.selectRelatedList(postId);
    }

    @Override
    public List<CommunityPostDto> getLatestList(List<Long> excludeIds, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return communityMapper.selectLatestList(excludeIds, pageSize, offset);
    }

    @Override
    public int getLatestTotalCount(List<Long> excludeIds) {
        return communityMapper.selectLatestTotalCount(excludeIds);
    }

    @Override
    public int getLatestTotalPage(List<Long> excludeIds, int pageSize) {
        int total = communityMapper.selectLatestTotalCount(excludeIds);
        return (int) Math.ceil((double) total / pageSize);
    }

    // ===== 조회수 =====

    @Override
    public void increaseViewCount(Long postId) {
        communityMapper.updateViewCount(postId);
    }

    // ===== 글쓰기 =====

    @Override
    @Transactional
    public Long writePost(CommunityWriteDto writeDto, Long userIdx) {

        // 도배 방지: 5분 내 3개 이상이면 거부
        if (communityMapper.countRecentPostsByUser(userIdx, 5) >= 3) {
            throw new IllegalStateException("5분 내 게시글을 3개 이상 작성할 수 없습니다.");
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

        return postId;
    }

    // ===== 수정 =====
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

    @Override
    @Transactional
    public void deletePost(Long postId) {
        // post_status = 'DELETED' 로 변경 (실제 삭제 X)
        communityMapper.updatePostStatus(postId, "DELETED");
    }

    // ===== 태그 공출현 =====
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

    // ===== 좋아요 =====

    @Override
    public boolean isLiked(Long postId, Long userIdx) {
        return communityMapper.selectLikeCount(postId, userIdx) > 0;
    }

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
                myPageService.addNotification(notification);
            }
            return true;
        }
    }

    @Override
    public int getLikeCount(Long postId) {
        return communityMapper.selectPostLikeCount(postId);
    }

    // ===== 댓글 =====

    @Override
    @Transactional
    public void addComment(Long postId, Long userIdx, String content) {
        // 도배 방지: 1분 내 5개 이상이면 거부
        if (communityMapper.countRecentCommentsByUser(userIdx, 1) >= 5) {
            throw new IllegalStateException("1분 내 댓글을 5개 이상 작성할 수 없습니다.");
        }
        communityMapper.insertComment(postId, userIdx, content);
        communityMapper.increaseCommentCount(postId);

        // 글 작성자에게 알림 생성 (본인 글에 본인 댓글이면 제외)
        CommunityPostDto post = communityMapper.selectPost(postId);
        if (post != null && !post.getUserIdx().equals(userIdx)) {
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(post.getUserIdx());
            notification.setSourceType("community");
            notification.setSourceId(postId);
            notification.setMessage("내 글에 새 댓글이 달렸어요.");
            myPageService.addNotification(notification);
        }
    }
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
    @Override
    @Transactional
    public void addReply(Long postId, Long userIdx, String content, Long parentCommentId) {
        // 도배 방지: 댓글+대댓글 합산 1분 내 5개 이상이면 거부
        if (communityMapper.countRecentCommentsByUser(userIdx, 1) >= 5) {
            throw new IllegalStateException("1분 내 댓글을 5개 이상 작성할 수 없습니다.");
        }
        communityMapper.insertReply(postId, userIdx, content, parentCommentId);
        communityMapper.increaseCommentCount(postId);

        // 글 작성자에게 알림 생성 (본인 글에 본인 대댓글이면 제외)
        CommunityPostDto post = communityMapper.selectPost(postId);
        if (post != null && !post.getUserIdx().equals(userIdx)) {
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(post.getUserIdx());
            notification.setSourceType("community");
            notification.setSourceId(postId);
            notification.setMessage("내 글에 새 대댓글이 달렸어요.");
            myPageService.addNotification(notification);
        }

        // 대댓글 알람: 부모 댓글 작성자에게 알림 생성
        CommunityCommentDto parentComment = communityMapper.selectComment(parentCommentId);
        if (parentComment != null && !parentComment.getUserIdx().equals(userIdx)) {
            // 부모 댓글 작성자 != 글 작성자인 경우에만 알림 (중복 제거)
            if (!parentComment.getUserIdx().equals(post.getUserIdx())) {
                FeedNotificationDto notification = new FeedNotificationDto();
                notification.setUserIdx(parentComment.getUserIdx());
                notification.setSourceType("community");
                notification.setSourceId(postId);
                notification.setMessage("내 댓글에 새 답글이 달렸어요.");
                myPageService.addNotification(notification);
            }
        }
    }

    // ===== 질문 채택 =====
    @Override
    @Transactional
    public void acceptComment(Long postId, Long commentId) {
        communityMapper.acceptComment(postId, commentId);
    }

    @Override
    public Long getAcceptedCommentId(Long postId) {
        return communityMapper.selectAcceptedCommentId(postId);
    }

    // ===== 댓글 좋아요 =====
    @Override
    public boolean isCommentLiked(Long commentId, Long userIdx) {
        return communityMapper.selectCommentLikeCount(commentId, userIdx) > 0;
    }

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
            return true;
        }
    }

    @Override
    public int getCommentLikeCount(Long commentId) {
        return communityMapper.selectCommentLikeCountById(commentId);
    }

    // ===== 신고 =====

    @Override
    public void updatePostReportCache(Long postId) {
        communityMapper.increasePostReportCount(postId);
        int reportCount = communityMapper.selectPostReportCount(postId);
        if (reportCount >= 3) communityMapper.blockPost(postId);
    }

    @Override
    public void updateCommentReportCache(Long commentId) {
        communityMapper.increaseCommentReportCount(commentId);
        int reportCount = communityMapper.selectCommentReportCount(commentId);
        if (reportCount >= 3) communityMapper.blockComment(commentId);
    }

    @Override
    public int getPostReportCount(Long postId) {
        return communityMapper.selectPostReportCount(postId);
    }

    @Override
    public int getCommentReportCount(Long commentId) {
        return communityMapper.selectCommentReportCount(commentId);
    }

    // ===== Pixabay 자동추천 이미지 배정 =====

    private void assignAutoImage(Long postId, String region) {
        try {
            String imageUrl = "etc".equals(region)
                    ? communityImageCacheMapper.selectRandomCacheImageFromAll()
                    : communityImageCacheMapper.selectRandomCacheImage(region);
            if (imageUrl != null) {
                communityMapper.insertAutoImage(postId, imageUrl);
            }
        } catch (Exception e) {
            log.warn("자동추천 이미지 배정 실패 (postId={}, region={}): {}", postId, region, e.getMessage());
        }
    }

    // ===== 파일 저장 유틸 =====

    private String saveFile(MultipartFile file) {
        // 파일 형식 검증
        String ext = getExtension(file.getOriginalFilename()).toLowerCase();
        if (!ext.equals(".jpg") && !ext.equals(".jpeg")
                && !ext.equals(".png") && !ext.equals(".gif")
                && !ext.equals(".webp")) {
            log.warn("허용되지 않는 파일 형식 업로드 시도: {}", ext);
            return null;
        }

        try {
            String dir = System.getProperty("user.dir").replace("\\", "/")
                    + "/" + uploadPath + "/community/";
            File dirFile = new File(dir);
            if (!dirFile.exists()) dirFile.mkdirs();

            String fileName = UUID.randomUUID().toString() + ext;
            file.transferTo(new File(dir + fileName));

            return "/upload/community/" + fileName;
        } catch (IOException e) {
            log.error("파일 저장 실패", e);
            return null;
        }
    }

    private String getExtension(String originalFilename) {
        if (originalFilename == null || !originalFilename.contains(".")) return "";
        return originalFilename.substring(originalFilename.lastIndexOf("."));
    }

    @Override
    public List<CommunityPostDto> getPopularPostList() {
        return communityMapper.selectPopularPostList();
    }

    @Override
    public List<CommunityPostDto> getTodayPopularList() {
        return communityMapper.selectTodayPopularList();
    }

    @Override
    public void blockUser(Long userIdx) {
        communityMapper.blockUser(userIdx);
    }

    @Override
    public void unblockUser(Long userIdx) {
        communityMapper.unblockUser(userIdx);
    }

    @Override public void blockPost(Long postId) { communityMapper.blockPost(postId); }
    @Override public void unblockPost(Long postId) { communityMapper.unblockPost(postId); }
    @Override public void blockComment(Long commentId) { communityMapper.blockComment(commentId); }
    @Override public void unblockComment(Long commentId) { communityMapper.unblockComment(commentId); }
}
