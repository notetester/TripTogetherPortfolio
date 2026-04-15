package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.service.AdminCommunityService;
import org.triptogether.admin.service.AdminService;
import org.triptogether.admin.vo.AdminCommunitySearchVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/community")
public class AdminCommunityController {

    private final AdminCommunityService adminCommunityService;
    private final AdminService adminService;

    /**
     * 커뮤니티 게시글 목록 페이지.
     */
    @GetMapping({"", "/"})
    public String postList(AdminCommunitySearchVO search, Model model) {
        model.addAllAttributes(adminCommunityService.getPostList(search));
        model.addAttribute("stats", adminCommunityService.getStats());
        model.addAttribute("activeMenu", "community");
        return "admin/community/list";
    }

    /**
     * 커뮤니티 댓글 목록 페이지.
     */
    @GetMapping("/comments")
    public String commentList(AdminCommunitySearchVO search, Model model) {
        model.addAllAttributes(adminCommunityService.getCommentList(search));
        model.addAttribute("stats", adminCommunityService.getStats());
        model.addAttribute("activeMenu", "community");
        return "admin/community/comments";
    }

    /**
     * 커뮤니티 게시글 상세 페이지.
     */
    @GetMapping("/posts/{postId}")
    public String postDetail(@PathVariable Long postId, Model model) {
        model.addAllAttributes(adminCommunityService.getPostDetail(postId));
        model.addAttribute("activeMenu", "community");
        return "admin/community/detail";
    }

    // ── 게시글 단건 차단 ──────────────────────────────────

    /**
     * 게시글 단건 차단. post_status를 BLOCKED로 변경한다.
     */
    @PostMapping("/posts/{postId}/block")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> blockPost(@PathVariable Long postId) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminCommunityService.blockPost(postId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("게시글 차단 오류 postId={}", postId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    // ── 게시글 단건 삭제 ──────────────────────────────────

    /**
     * 게시글 단건 삭제. post_status를 DELETED로 변경한다.
     */
    @PostMapping("/posts/{postId}/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deletePost(@PathVariable Long postId) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminCommunityService.deletePost(postId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("게시글 삭제 오류 postId={}", postId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    // ── 게시글 일괄 처리 ──────────────────────────────────

    /**
     * 게시글 일괄 처리. action: block(차단) / delete(삭제).
     */
    @PostMapping("/posts/bulk-action")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bulkPostAction(
            @RequestParam String action,
            @RequestParam(required = false) List<Long> ids) {

        Map<String, Object> result = new HashMap<>();
        if (ids == null || ids.isEmpty()) {
            result.put("success", false);
            result.put("message", "선택된 항목이 없습니다.");
            return ResponseEntity.badRequest().body(result);
        }
        try {
            if ("block".equals(action)) {
                adminCommunityService.bulkBlockPosts(ids);
            } else if ("delete".equals(action)) {
                adminCommunityService.bulkDeletePosts(ids);
            } else {
                result.put("success", false);
                result.put("message", "알 수 없는 처리 옵션입니다.");
                return ResponseEntity.badRequest().body(result);
            }
            result.put("success", true);
            result.put("count", ids.size());
        } catch (Exception e) {
            log.error("게시글 일괄 처리 오류 action={}", action, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    // ── 댓글 단건 차단 ──────────────────────────────────

    /**
     * 댓글 단건 차단. comment_status를 BLOCKED로 변경한다.
     */
    @PostMapping("/comments/{commentId}/block")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> blockComment(@PathVariable Long commentId) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminCommunityService.blockComment(commentId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("댓글 차단 오류 commentId={}", commentId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    // ── 댓글 단건 삭제 ──────────────────────────────────

    /**
     * 댓글 단건 삭제. comment_status를 DELETED로 변경한다.
     */
    @PostMapping("/comments/{commentId}/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteComment(@PathVariable Long commentId) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminCommunityService.deleteComment(commentId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("댓글 삭제 오류 commentId={}", commentId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    // ── 댓글 일괄 처리 ──────────────────────────────────

    /**
     * 댓글 일괄 처리. action: block(차단) / delete(삭제).
     */
    @PostMapping("/comments/bulk-action")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bulkCommentAction(
            @RequestParam String action,
            @RequestParam(required = false) List<Long> ids) {

        Map<String, Object> result = new HashMap<>();
        if (ids == null || ids.isEmpty()) {
            result.put("success", false);
            result.put("message", "선택된 항목이 없습니다.");
            return ResponseEntity.badRequest().body(result);
        }
        try {
            if ("block".equals(action)) {
                adminCommunityService.bulkBlockComments(ids);
            } else if ("delete".equals(action)) {
                adminCommunityService.bulkDeleteComments(ids);
            } else {
                result.put("success", false);
                result.put("message", "알 수 없는 처리 옵션입니다.");
                return ResponseEntity.badRequest().body(result);
            }
            result.put("success", true);
            result.put("count", ids.size());
        } catch (Exception e) {
            log.error("댓글 일괄 처리 오류 action={}", action, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    // ── 작성자 계정 차단 (게시글/댓글 상세에서) ──────────

    /**
     * 작성자 계정 차단. account_status를 BLOCKED로 변경한다.
     * 자기 자신은 차단할 수 없다.
     */
    @PostMapping("/users/{userIdx}/block")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> blockUser(@PathVariable Long userIdx,
                                                         HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
        if (loginUser != null && loginUser.getUserIdx().equals(userIdx)) {
            result.put("success", false);
            result.put("message", "자신의 계정은 차단할 수 없습니다.");
            return ResponseEntity.status(400).body(result);
        }
        try {
            adminService.changeMemberStatus(userIdx, "BLOCKED");
            result.put("success", true);
        } catch (Exception e) {
            log.error("유저 차단 오류 userIdx={}", userIdx, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }
}
