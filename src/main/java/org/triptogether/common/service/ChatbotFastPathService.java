package org.triptogether.common.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.triptogether.common.vo.ChatbotResponseVO;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 자주 반복되는 단순 네비게이션 요청을 LLM 호출 없이 즉답하는 빠른 경로.
 *
 * 원칙:
 *   - 메시지 길이 15자 이하인 짧은 요청만 대상 (복합 의도는 LLM 쪽으로)
 *   - 로그인 여부에 따라 분기되는 경우 처리
 *   - 매칭 안 되면 null 반환 → 기존 LLM 파이프라인 그대로 진행
 */
@Slf4j
@Service
public class ChatbotFastPathService {

    private static final int MAX_LEN = 15;

    /**
     * 메시지가 단순 네비게이션 요청이면 즉답 생성, 아니면 null.
     */
    public ChatbotResponseVO resolveOrNull(String userMessage, boolean loggedIn) {
        if (userMessage == null) return null;
        String m = userMessage.trim().toLowerCase().replaceAll("\\s+", " ");
        if (m.isEmpty() || m.length() > MAX_LEN) return null;

        // ── 로그인 ──
        if (m.contains("로그인")) {
            return loggedIn
                    ? build("이미 로그인하고 계세요! 🙂",
                            list(link("마이페이지", "/mypage", "👤")),
                            list("인기 여행지 추천", "내 여행 코스 보기"))
                    : build("로그인 페이지로 안내해드릴게요! 🔑",
                            list(link("로그인", "/auth/login", "🔑"),
                                 link("회원가입", "/auth/register", "✨")),
                            list());
        }

        // ── 회원가입 ──
        if (m.contains("회원가입") || m.contains("가입")) {
            return loggedIn
                    ? build("이미 가입하신 회원이에요! 🎉",
                            list(link("마이페이지", "/mypage", "👤")),
                            list())
                    : build("회원가입 페이지로 안내해드릴게요! ✨",
                            list(link("회원가입", "/auth/register", "✨"),
                                 link("로그인", "/auth/login", "🔑")),
                            list());
        }

        // ── 홈 / 메인 ──
        if (m.contains("홈으로") || m.contains("메인으로") || m.contains("메인 페이지")
                || m.contains("첫 페이지") || m.equals("홈") || m.equals("메인")) {
            return build("홈 페이지로 이동할게요! 🏠",
                    list(link("홈", "/", "🏠")),
                    list("인기 여행지 추천", "AI 도우미 써보기"));
        }

        // ── 커뮤니티 ──
        if (m.contains("커뮤니티") || m.contains("게시판")) {
            return build("커뮤니티 게시판으로 안내해드릴게요! 💬",
                    list(link("커뮤니티", "/community/list", "💬")),
                    list("인기 후기 보기", "여행 팁 보기"));
        }

        // ── 여행지 탐색 ──
        if (m.contains("여행지 탐색") || m.contains("탐색 페이지") || m.equals("탐색")) {
            return build("여행지 탐색 페이지로 안내할게요! 🗺️",
                    list(link("여행지 탐색", "/explore", "🗺️")),
                    list("인기 여행지 추천"));
        }

        // ── 여행 코스 ──
        if (m.contains("코스 목록") || m.contains("코스 보여") || m.equals("코스")
                || m.contains("여행 코스")) {
            return build("여행 코스 목록으로 안내할게요! 🧭",
                    list(link("여행 코스", "/courses", "🧭")),
                    list("인기 코스 추천"));
        }

        // ── 패키지 ──
        if (m.contains("패키지 목록") || m.contains("상품 목록") || m.equals("패키지")
                || m.contains("여행 패키지")) {
            return build("여행 패키지 목록을 보여드릴게요! 🎁",
                    list(link("여행 패키지", "/packages", "🎁")),
                    list());
        }

        // ── AI 도우미 ──
        if (m.contains("ai 도우미") || m.contains("ai도우미")
                || m.contains("일정 만들") || m.contains("일정 짜")) {
            return build("AI 도우미가 여행 일정 만들어드려요! ✨",
                    list(link("AI 도우미", "/assistant", "✨")),
                    list("인기 여행지 추천"));
        }

        // ── 마이페이지 ──
        if (m.contains("마이페이지") || m.contains("내 정보") || m.contains("내 페이지")) {
            return loggedIn
                    ? build("마이페이지로 안내할게요! 👤",
                            list(link("마이페이지", "/mypage", "👤")),
                            list())
                    : build("마이페이지는 로그인이 필요해요.",
                            list(link("로그인", "/auth/login", "🔑")),
                            list());
        }

        // ── 문의 ──
        if (m.contains("문의") || m.contains("고객센터") || m.contains("1:1")) {
            return build("문의 페이지로 안내할게요! 📩",
                    list(link("문의하기", "/inquiry/list", "📩")),
                    list());
        }

        // ── 인사 ──
        if (m.equals("안녕") || m.equals("안녕하세요") || m.equals("하이") || m.equals("반가워")
                || m.equals("hi") || m.equals("hello")) {
            return build("안녕하세요! 여행 관련 무엇이든 물어보세요! 🌍",
                    list(),
                    list("인기 여행지 추천", "여행 코스 보기", "AI 도우미 써보기"));
        }

        return null;
    }

    // ── 헬퍼 ──

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

    private ChatbotResponseVO.SiteLink link(String label, String url, String icon) {
        return ChatbotResponseVO.SiteLink.builder().label(label).url(url).icon(icon).build();
    }

    @SafeVarargs
    private final <T> List<T> list(T... items) {
        if (items == null || items.length == 0) return Collections.emptyList();
        return new ArrayList<>(List.of(items));
    }
}
