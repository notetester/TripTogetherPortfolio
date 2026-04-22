package org.triptogether.myPage.function;

/**
 * 알림 타겟 URL 생성 유틸리티.
 * 모든 알림 생성부에서 이 유틸을 경유하여 target_url을 세팅한다.
 * 반환 값은 contextPath를 제외한 상대경로이다.
 */
public final class NotificationUrlBuilder {

    private NotificationUrlBuilder() {
    }

    public static String community(Long postId) {
        return "/community/" + postId;
    }

    public static String communityComment(Long postId, Long commentId) {
        return "/community/" + postId + "#comment-" + commentId;
    }

    public static String inquiry(Long inquiryId) {
        return "/inquiry/" + inquiryId;
    }

    public static String report() {
        return "/mypage";
    }

    public static String levelup() {
        return "/mypage";
    }

    public static String grade() {
        return "/mypage";
    }

    public static String mypage() {
        return "/mypage";
    }
}
