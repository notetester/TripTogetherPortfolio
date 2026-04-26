package org.triptogether.community;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.triptogether.cloudinary.CloudinaryService;
import org.triptogether.common.util.MessageUtil;
import org.triptogether.community.mapper.CommunityMapper;
import org.triptogether.community.service.CommunityImageScheduler;
import org.triptogether.community.service.CommunityServiceImpl;
import org.triptogether.community.vo.CommunityPostDto;
import org.triptogether.config.IpBlockMapper;
import org.triptogether.explore.service.SpotTextTranslationService;
import org.triptogether.moderation.service.ModerationPolicyService;
import org.triptogether.moderation.vo.ContentModerationPolicyVO;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.report.service.ReportService;
import org.triptogether.reward.service.RewardService;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.lenient;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
class CommunityServiceTest {

    @Mock CommunityMapper communityMapper;
    @Mock CommunityImageScheduler communityImageScheduler;
    @Mock CloudinaryService cloudinaryService;
    @Mock MyPageService myPageService;
    @Mock IpBlockMapper ipBlockMapper;
    @Mock SpotTextTranslationService spotTextTranslationService;
    @Mock ModerationPolicyService moderationPolicyService;
    @Mock RewardService rewardService;
    @Mock ReportService reportService;
    @Mock MessageUtil msg;

    @InjectMocks CommunityServiceImpl communityService;

    private static final Long USER_IDX = 1L;
    private static final Long POST_ID  = 100L;

    /**
     * 정책 객체 stub + i18n 메시지 stub.
     * 정책: ADR-0009 (정책 외부화) — moderationPolicyService 가 제공하는 값 기준
     * 정책: ADR-0013 (i18n) — msg.get(...) 이 실제 메시지 문자열 반환하도록 stub
     */
    @BeforeEach
    void setUp() {
        ContentModerationPolicyVO policy = new ContentModerationPolicyVO();
        policy.setPostWindowMinutes(5);
        policy.setPostMaxCount(3);
        policy.setCommentWindowMinutes(1);
        policy.setCommentMaxCount(5);
        policy.setReportThreshold(3);
        lenient().when(moderationPolicyService.getPolicy()).thenReturn(policy);

        // i18n 메시지 stub - placeholder 메시지 반환 (테스트는 메시지 type 위주로 검증)
        lenient().when(msg.get(eq("community.service.error.postRateLimit"), any(), any()))
                .thenReturn("5분 내 게시글을 3개 이상 작성할 수 없습니다.");
        lenient().when(msg.get(eq("community.service.error.commentRateLimit"), any(), any()))
                .thenReturn("1분 내 댓글을 5개 이상 작성할 수 없습니다.");
        lenient().when(msg.get(anyString())).thenReturn("");
    }

    // ===== 도배 방지: 게시글 =====

    @Test
    @DisplayName("게시글 도배 방지 - 5분 내 3개 이상이면 예외 발생")
    void writePost_floodLimit_throwsException() {
        given(communityMapper.countRecentPostsByUser(USER_IDX, 5)).willReturn(3);

        assertThatThrownBy(() -> communityService.writePost(null, USER_IDX))
                .isInstanceOf(IllegalStateException.class)
                .hasMessageContaining("5분 내 게시글을 3개 이상 작성할 수 없습니다.");
    }

    @Test
    @DisplayName("게시글 도배 방지 - 5분 내 2개면 통과")
    void writePost_belowFloodLimit_passes() {
        given(communityMapper.countRecentPostsByUser(USER_IDX, 5)).willReturn(2);

        // 도배 체크 통과 후 writeDto가 null이므로 NPE 발생 — 도배 방지 로직만 검증
        try {
            communityService.writePost(null, USER_IDX);
        } catch (NullPointerException ignored) {}

        verify(communityMapper).countRecentPostsByUser(USER_IDX, 5);
    }

    // ===== 도배 방지: 댓글 =====

    @Test
    @DisplayName("댓글 도배 방지 - 1분 내 5개 이상이면 예외 발생")
    void addComment_floodLimit_throwsException() {
        given(communityMapper.countRecentCommentsByUser(USER_IDX, 1)).willReturn(5);

        assertThatThrownBy(() -> communityService.addComment(POST_ID, USER_IDX, "댓글내용"))
                .isInstanceOf(IllegalStateException.class)
                .hasMessageContaining("1분 내 댓글을 5개 이상 작성할 수 없습니다.");
    }

    @Test
    @DisplayName("댓글 도배 방지 - 1분 내 4개면 통과")
    void addComment_belowFloodLimit_passes() {
        given(communityMapper.countRecentCommentsByUser(USER_IDX, 1)).willReturn(4);
        given(communityMapper.selectPost(POST_ID)).willReturn(null);

        communityService.addComment(POST_ID, USER_IDX, "댓글내용");

        verify(communityMapper).insertComment(any());
    }

    // ===== 도배 방지: 대댓글 =====

    @Test
    @DisplayName("대댓글 도배 방지 - 1분 내 5개 이상이면 예외 발생")
    void addReply_floodLimit_throwsException() {
        given(communityMapper.countRecentCommentsByUser(USER_IDX, 1)).willReturn(5);

        assertThatThrownBy(() -> communityService.addReply(POST_ID, USER_IDX, "대댓글내용", 10L))
                .isInstanceOf(IllegalStateException.class)
                .hasMessageContaining("1분 내 댓글을 5개 이상 작성할 수 없습니다.");
    }

    // ===== 좋아요 토글 =====

    @Test
    @DisplayName("좋아요 토글 - 이미 눌렀으면 취소되고 false 반환")
    void toggleLike_alreadyLiked_cancelsAndReturnsFalse() {
        given(communityMapper.selectLikeCount(POST_ID, USER_IDX)).willReturn(1);

        boolean result = communityService.toggleLike(POST_ID, USER_IDX);

        assertThat(result).isFalse();
        verify(communityMapper).deleteLike(POST_ID, USER_IDX);
        verify(communityMapper).decreaseLikeCount(POST_ID);
    }

    @Test
    @DisplayName("좋아요 토글 - 안 눌렀으면 추가되고 true 반환")
    void toggleLike_notLiked_addsAndReturnsTrue() {
        given(communityMapper.selectLikeCount(POST_ID, USER_IDX)).willReturn(0);
        CommunityPostDto post = new CommunityPostDto();
        post.setUserIdx(99L); // 다른 유저의 글
        given(communityMapper.selectPost(POST_ID)).willReturn(post);

        boolean result = communityService.toggleLike(POST_ID, USER_IDX);

        assertThat(result).isTrue();
        verify(communityMapper).insertLike(POST_ID, USER_IDX);
        verify(communityMapper).increaseLikeCount(POST_ID);
    }

    @Test
    @DisplayName("좋아요 토글 - 본인 글에 좋아요 시 알림 미발송")
    void toggleLike_ownPost_noNotification() {
        given(communityMapper.selectLikeCount(POST_ID, USER_IDX)).willReturn(0);
        CommunityPostDto post = new CommunityPostDto();
        post.setUserIdx(USER_IDX); // 본인 글
        given(communityMapper.selectPost(POST_ID)).willReturn(post);

        communityService.toggleLike(POST_ID, USER_IDX);

        verify(myPageService, never()).addNotification(any());
    }
}
