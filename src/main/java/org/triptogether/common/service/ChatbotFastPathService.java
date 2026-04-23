package org.triptogether.common.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.triptogether.common.vo.ChatbotResponseVO;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

/**
 * 자주 반복되는 단순 네비게이션 요청을 LLM 호출 없이 즉답하는 빠른 경로.
 *
 * 원칙:
 *   - 메시지 길이 15자 이하인 짧은 요청만 대상 (복합 의도는 LLM 쪽으로)
 *   - 로그인 여부에 따라 분기되는 경우 처리
 *   - 다국어 키워드(영어 등) 도 일부 매칭
 *   - 모든 응답 문자열·링크 라벨은 messages/chatbot_*.properties 에서 로드
 *   - 매칭 안 되면 null 반환 → 기존 LLM 파이프라인 그대로 진행
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ChatbotFastPathService {

    private static final int MAX_LEN = 15;

    private final MessageSource messageSource;

    /**
     * 메시지가 단순 네비게이션 요청이면 즉답 생성, 아니면 null.
     */
    public ChatbotResponseVO resolveOrNull(String userMessage, boolean loggedIn) {
        if (userMessage == null) return null;
        String m = userMessage.trim().toLowerCase().replaceAll("\\s+", " ");
        if (m.isEmpty() || m.length() > MAX_LEN) return null;

        Locale locale = LocaleContextHolder.getLocale();

        // ── 로그인 ──
        if (m.contains("로그인") || m.contains("login") || m.contains("sign in")) {
            return loggedIn
                    ? build(msg(locale, "chatbot.fp.loggedIn"),
                            list(link(locale, "chatbot.link.mypage", "/mypage", "👤")),
                            list(msg(locale, "chatbot.quick.popularSpots"),
                                 msg(locale, "chatbot.quick.myCourses")))
                    : build(msg(locale, "chatbot.fp.loginPrompt"),
                            list(link(locale, "chatbot.link.login", "/auth/login", "🔑"),
                                 link(locale, "chatbot.link.register", "/auth/register", "✨")),
                            list());
        }

        // ── 회원가입 ──
        if (m.contains("회원가입") || m.contains("가입") || m.contains("sign up") || m.contains("register")) {
            return loggedIn
                    ? build(msg(locale, "chatbot.fp.registerAlready"),
                            list(link(locale, "chatbot.link.mypage", "/mypage", "👤")),
                            list())
                    : build(msg(locale, "chatbot.fp.registerPrompt"),
                            list(link(locale, "chatbot.link.register", "/auth/register", "✨"),
                                 link(locale, "chatbot.link.login", "/auth/login", "🔑")),
                            list());
        }

        // ── 홈 / 메인 ──
        if (m.contains("홈으로") || m.contains("메인으로") || m.contains("메인 페이지")
                || m.contains("첫 페이지") || m.equals("홈") || m.equals("메인")
                || m.equals("home") || m.equals("main")) {
            return build(msg(locale, "chatbot.fp.home"),
                    list(link(locale, "chatbot.link.home", "/", "🏠")),
                    list(msg(locale, "chatbot.quick.popularSpots"),
                         msg(locale, "chatbot.quick.assistantHow")));
        }

        // ── 커뮤니티 ──
        if (m.contains("커뮤니티") || m.contains("게시판") || m.contains("community") || m.contains("board")) {
            return build(msg(locale, "chatbot.fp.community"),
                    list(link(locale, "chatbot.link.community", "/community/list", "💬")),
                    list(msg(locale, "chatbot.quick.popularReviews"),
                         msg(locale, "chatbot.quick.travelTips")));
        }

        // ── 여행지 탐색 ──
        if (m.contains("여행지 탐색") || m.contains("탐색 페이지") || m.equals("탐색")
                || m.equals("explore") || m.contains("destinations")) {
            return build(msg(locale, "chatbot.fp.explore"),
                    list(link(locale, "chatbot.link.explore", "/explore", "🗺️")),
                    list(msg(locale, "chatbot.quick.popularSpots")));
        }

        // ── 여행 코스 ──
        if (m.contains("코스 목록") || m.contains("코스 보여") || m.equals("코스")
                || m.contains("여행 코스") || m.equals("courses") || m.contains("travel course")) {
            return build(msg(locale, "chatbot.fp.courses"),
                    list(link(locale, "chatbot.link.courses", "/courses", "🧭")),
                    list(msg(locale, "chatbot.quick.popularCourses")));
        }

        // ── 패키지 ──
        if (m.contains("패키지 목록") || m.contains("상품 목록") || m.equals("패키지")
                || m.contains("여행 패키지") || m.equals("packages") || m.contains("tour package")) {
            return build(msg(locale, "chatbot.fp.packages"),
                    list(link(locale, "chatbot.link.packages", "/packages", "🎁")),
                    list());
        }

        // ── AI 도우미 ──
        if (m.contains("ai 도우미") || m.contains("ai도우미")
                || m.contains("일정 만들") || m.contains("일정 짜")
                || m.contains("ai assistant") || m.contains("itinerary")) {
            return build(msg(locale, "chatbot.fp.assistant"),
                    list(link(locale, "chatbot.link.assistant", "/assistant", "✨")),
                    list(msg(locale, "chatbot.quick.popularSpots")));
        }

        // ── 마이페이지 ──
        if (m.contains("마이페이지") || m.contains("내 정보") || m.contains("내 페이지")
                || m.contains("my page") || m.contains("mypage") || m.contains("profile")) {
            return loggedIn
                    ? build(msg(locale, "chatbot.fp.mypageLoggedIn"),
                            list(link(locale, "chatbot.link.mypage", "/mypage", "👤")),
                            list())
                    : build(msg(locale, "chatbot.fp.mypageNeedLogin"),
                            list(link(locale, "chatbot.link.login", "/auth/login", "🔑")),
                            list());
        }

        // ── 문의 ──
        if (m.contains("문의") || m.contains("고객센터") || m.contains("1:1")
                || m.contains("contact") || m.contains("support")) {
            return build(msg(locale, "chatbot.fp.inquiry"),
                    list(link(locale, "chatbot.link.inquiry", "/inquiry/list", "📩")),
                    list());
        }

        // ── 인사 ──
        if (m.equals("안녕") || m.equals("안녕하세요") || m.equals("하이") || m.equals("반가워")
                || m.equals("hi") || m.equals("hello") || m.equals("hey")
                || m.equals("こんにちは") || m.equals("你好")) {
            return build(msg(locale, "chatbot.fp.greeting"),
                    list(),
                    list(msg(locale, "chatbot.quick.popularSpots"),
                         msg(locale, "chatbot.quick.courseRecommend"),
                         msg(locale, "chatbot.quick.assistantHow")));
        }

        return null;
    }

    // ── 헬퍼 ──

    private String msg(Locale locale, String code) {
        return messageSource.getMessage(code, null, code, locale);
    }

    private ChatbotResponseVO build(String message,
                                     List<ChatbotResponseVO.SiteLink> links,
                                     List<String> quickReplies) {
        return ChatbotResponseVO.builder()
                .message(message)
                .links(links)
                .quickReplies(quickReplies)
                .inappropriate(false)
                .build();
    }

    private ChatbotResponseVO.SiteLink link(Locale locale, String labelCode, String url, String icon) {
        return ChatbotResponseVO.SiteLink.builder()
                .label(msg(locale, labelCode))
                .url(url)
                .icon(icon)
                .build();
    }

    @SafeVarargs
    private final <T> List<T> list(T... items) {
        if (items == null || items.length == 0) return Collections.emptyList();
        return new ArrayList<>(List.of(items));
    }
}
