package org.triptogether.community.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.community.service.CommunityService;
import org.triptogether.community.vo.*;
import org.triptogether.report.service.ReportService;

import jakarta.servlet.http.HttpSession;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
public class CommunityController {

    private final CommunityService communityService;
    private final ReportService reportService;

    /* =============================================
       GET /community/list - 커뮤니티 목록
       파라미터: region, type, sort, page
       ============================================= */
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "all")    String region,
                       @RequestParam(defaultValue = "all")    String type,
                       @RequestParam(defaultValue = "latest") String sort,
                       @RequestParam(defaultValue = "")       String keyword,
                       @RequestParam(defaultValue = "1")      int    page,
                       HttpSession session,
                       Model model) {

        CommunitySearchDto search = new CommunitySearchDto();
        search.setRegion(region);
        search.setType(type);
        search.setSort(sort);
        search.setKeyword(keyword);
        search.setPage(page);
        search.calcOffset();
        search.setAdminMode(isAdminUser(session) && !"user".equals(session.getAttribute("viewMode")));

        model.addAttribute("postList",    communityService.getPostList(search));
        model.addAttribute("totalCount",  communityService.getTotalCount(search));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage",   communityService.getTotalPage(search));
        return "community/list";
    }

    /* =============================================
       GET /community/{postId} - 커뮤니티 상세
       ============================================= */
    @GetMapping("/{postId}")
    public String detail(@PathVariable Long postId,
                         HttpSession session,
                         Model model) {

        communityService.increaseViewCount(postId);

        Long loginUserIdx = getLoginUserIdx(session);

        CommunityPostDto post = communityService.getPost(postId);
        if (post == null) return "redirect:/community/list";

        model.addAttribute("post",        post);
        model.addAttribute("imageList",   communityService.getImageList(postId));
        model.addAttribute("tagList",     communityService.getTagList(postId));
        model.addAttribute("commentList", communityService.getCommentList(postId));
        model.addAttribute("tipCategory", communityService.getTipCategory(postId));
        model.addAttribute("isSolved",    communityService.isSolved(postId));
        model.addAttribute("isLiked",     loginUserIdx != null && communityService.isLiked(postId, loginUserIdx));
        model.addAttribute("isOwner",     loginUserIdx != null && loginUserIdx.equals(post.getUserIdx()));
        model.addAttribute("acceptedCommentId", communityService.getAcceptedCommentId(postId));
        model.addAttribute("relatedList", communityService.getRelatedList(postId));

        return "community/detail";
    }

    /* =============================================
       GET /community/write - 글쓰기 폼
       ============================================= */
    @GetMapping("/write")
    public String writeForm(HttpSession session) {

       if (session.getAttribute("loginUser") == null) {
           return "redirect:/auth/login";
       }
        return "community/write";
    }

    /* =============================================
       POST /community/write - 글쓰기 등록
       ============================================= */
    @PostMapping("/write")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> write(
            @ModelAttribute CommunityWriteDto writeDto,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(result);
        }
        if (isBlocked(session)) {
            result.put("success", false);
            result.put("message", "차단된 계정은 글을 작성할 수 없습니다.");
            return ResponseEntity.status(403).body(result);
        }


        try {
            Long loginUserIdx = getLoginUserIdx(session);
            Long postId = communityService.writePost(writeDto, loginUserIdx);
            result.put("success", true);
            result.put("postId",  postId);
        } catch (Exception e) {
            log.error("글쓰기 오류", e);
            result.put("success", false);
            result.put("message", "등록 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
       GET /community/edit/{postId} - 수정 폼
       ============================================= */
    @GetMapping("/edit/{postId}")
    public String editForm(@PathVariable Long postId,
                           HttpSession session,
                           Model model) {

        if (session.getAttribute("loginUser") == null) {
            return "redirect:/auth/login";
        }

        CommunityPostDto post = communityService.getPost(postId);
        if (post == null) return "redirect:/community/list";

        model.addAttribute("post",        post);
        model.addAttribute("imageList",   communityService.getImageList(postId));
        model.addAttribute("tagList",     communityService.getTagList(postId));
        model.addAttribute("tipCategory", communityService.getTipCategory(postId));

        return "community/write";
    }

    /* =============================================
   POST /community/edit/{postId} - 수정 처리
   ============================================= */
    @PostMapping("/edit/{postId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> edit(
            @PathVariable Long postId,
            @ModelAttribute CommunityWriteDto writeDto,
            @RequestParam(required = false) List<String> existingImages,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(result);
        }

        try {
            Long loginUserIdx = getLoginUserIdx(session);
            communityService.editPost(postId, writeDto, existingImages, loginUserIdx);
            result.put("success", true);
            result.put("postId", postId);
        } catch (Exception e) {
            log.error("수정 오류", e);
            result.put("success", false);
            result.put("message", "수정 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
       DELETE /community/{postId} - 게시글 삭제
       post_status = 'DELETED' 로 변경 (실제 삭제 X)
       ============================================= */
    @DeleteMapping("/{postId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> delete(
            @PathVariable Long postId,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }

        communityService.deletePost(postId);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /community/{postId}/like - 좋아요 토글
       ============================================= */
    @PostMapping("/{postId}/like")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> like(
            @PathVariable Long postId,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }

        try {
            Long loginUserIdx = getLoginUserIdx(session);
            boolean liked    = communityService.toggleLike(postId, loginUserIdx);
            int     likeCount = communityService.getLikeCount(postId);

            result.put("liked",     liked);
            result.put("likeCount", likeCount);
        } catch (Exception e) {
            log.error("좋아요 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /community/{postId}/comment - 댓글 등록
       ============================================= */
    @PostMapping("/{postId}/comment")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addComment(
            @PathVariable Long postId,
            @RequestParam String content,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }
        if (isBlocked(session)) {
            result.put("success", false);
            result.put("message", "차단된 계정은 댓글을 작성할 수 없습니다.");
            return ResponseEntity.status(403).body(result);
        }

        try {
            Long loginUserIdx = getLoginUserIdx(session);
            communityService.addComment(postId, loginUserIdx, content);
            result.put("success", true);
        } catch (Exception e) {
            log.error("댓글 등록 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
       DELETE /community/comment/{commentId} - 댓글 삭제
       comment_status = 'DELETED' 로 변경 (실제 삭제 X)
       ============================================= */
    @DeleteMapping("/comment/{commentId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteComment(
            @PathVariable Long commentId,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }

        communityService.deleteComment(commentId);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* =============================================
   POST /community/{postId}/comment/{commentId}/reply - 대댓글 등록
   ============================================= */
    @PostMapping("/{postId}/comment/{commentId}/reply")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addReply(
            @PathVariable Long postId,
            @PathVariable Long commentId,
            @RequestParam String content,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }
        if (isBlocked(session)) {
            result.put("success", false);
            result.put("message", "차단된 계정은 댓글을 작성할 수 없습니다.");
            return ResponseEntity.status(403).body(result);
        }

        try {
            Long loginUserIdx = getLoginUserIdx(session);
            communityService.addReply(postId, loginUserIdx, content, commentId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("대댓글 등록 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }


    /* =============================================
   POST /community/{postId}/accept/{commentId} - 댓글 채택
   ============================================= */
    @PostMapping("/{postId}/accept/{commentId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> acceptComment(
            @PathVariable Long postId,
            @PathVariable Long commentId,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }

        try {
            // 작성자 본인만 채택 가능
            Long loginUserIdx = getLoginUserIdx(session);
            CommunityPostDto post = communityService.getPost(postId);
            if (!loginUserIdx.equals(post.getUserIdx())) {
                result.put("success", false);
                result.put("message", "작성자만 채택할 수 있어요.");
                return ResponseEntity.status(403).body(result);
            }

            communityService.acceptComment(postId, commentId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("댓글 채택 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }


    /* =============================================
       POST /community/comment/{commentId}/like - 댓글 좋아요 토글
       ============================================= */
    @PostMapping("/comment/{commentId}/like")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> commentLike(
            @PathVariable Long commentId,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }

        try {
            Long loginUserIdx = getLoginUserIdx(session);
            boolean liked     = communityService.toggleCommentLike(commentId, loginUserIdx);
            int likeCount     = communityService.getCommentLikeCount(commentId);

            result.put("liked",     liked);
            result.put("likeCount", likeCount);
        } catch (Exception e) {
            log.error("댓글 좋아요 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }


    /* =============================================
       POST /community/{postId}/report - 신고
       ============================================= */
    @PostMapping("/{postId}/report")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> report(
            @PathVariable Long postId,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }

        try {
            Long loginUserIdx = getLoginUserIdx(session);
            boolean reported = reportService.submitReport("post", postId, loginUserIdx, null);
            if (reported) {
                communityService.updatePostReportCache(postId);
            }
            result.put("success", true);
            result.put("message", reported ? "신고가 접수되었습니다." : "이미 신고하셨습니다.");
        } catch (Exception e) {
            log.error("신고 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
   POST /community/comment/{commentId}/report - 댓글 신고
   ============================================= */
    @PostMapping("/comment/{commentId}/report")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> reportComment(
            @PathVariable Long commentId,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }

        try {
            Long loginUserIdx = getLoginUserIdx(session);
            boolean reported = reportService.submitReport("comment", commentId, loginUserIdx, null);
            if (reported) {
                communityService.updateCommentReportCache(commentId);
            }
            result.put("success", true);
            result.put("message", reported ? "신고가 접수되었습니다." : "이미 신고하셨습니다.");
        } catch (Exception e) {
            log.error("댓글 신고 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }
    /* =============================================
   POST /community/user/{userIdx}/block - 유저 차단
   ============================================= */
    @PostMapping("/user/{userIdx}/block")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> blockUser(
            @PathVariable Long userIdx,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (!isAdminUser(session)) {
            result.put("success", false);
            result.put("message", "관리자만 차단할 수 있습니다.");
            return ResponseEntity.status(403).body(result);
        }

        try {
            communityService.blockUser(userIdx);
            result.put("success", true);
        } catch (Exception e) {
            log.error("유저 차단 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    @PostMapping("/user/{userIdx}/unblock")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> unblockUser(
            @PathVariable Long userIdx,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (!isAdminUser(session)) {
            result.put("success", false);
            result.put("message", "관리자만 차단 해제할 수 있습니다.");
            return ResponseEntity.status(403).body(result);
        }

        try {
            communityService.unblockUser(userIdx);
            result.put("success", true);
        } catch (Exception e) {
            log.error("차단 해제 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }



    /* 게시글 차단/해제 */
    @PostMapping("/{postId}/block")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> blockPost(
            @PathVariable Long postId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdminUser(session)) {
            result.put("success", false); return ResponseEntity.status(403).body(result);
        }
        communityService.blockPost(postId);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    @PostMapping("/{postId}/unblock")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> unblockPost(
            @PathVariable Long postId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdminUser(session)) {
            result.put("success", false); return ResponseEntity.status(403).body(result);
        }
        communityService.unblockPost(postId);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* 댓글/대댓글 차단/해제 */
    @PostMapping("/comment/{commentId}/block")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> blockComment(
            @PathVariable Long commentId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdminUser(session)) {
            result.put("success", false); return ResponseEntity.status(403).body(result);
        }
        communityService.blockComment(commentId);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    @PostMapping("/comment/{commentId}/unblock")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> unblockComment(
            @PathVariable Long commentId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdminUser(session)) {
            result.put("success", false); return ResponseEntity.status(403).body(result);
        }
        communityService.unblockComment(commentId);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    @PostMapping("/admin/viewmode")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleViewMode(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdminUser(session)) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }
        String current = (String) session.getAttribute("viewMode");
        String next = "user".equals(current) ? "admin" : "user";
        session.setAttribute("viewMode", next);
        result.put("success", true);
        result.put("viewMode", next);
        return ResponseEntity.ok(result);
    }


    /* =============================================
   로그인 사용자 userIdx 추출 유틸
   로그인 담당자 UserDto의 getUserIdx() 메서드 호출
   ============================================= */
    private Long getLoginUserIdx(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) return null;
        try {
            return (Long) loginUser.getClass().getMethod("getUserIdx").invoke(loginUser);
        } catch (Exception e) {
            log.warn("loginUser userIdx 추출 실패", e);
            return null;
        }
    }

    private boolean isAdminUser(HttpSession session) {
        try {
            Object loginUser = session.getAttribute("loginUser");
            if (loginUser == null) return false;
            Method method = loginUser.getClass().getMethod("getUserRole");
            return "ADMIN".equals(method.invoke(loginUser));
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isBlocked(HttpSession session) {
        try {
            Object loginUser = session.getAttribute("loginUser");
            if (loginUser == null) return false;
            Method method = loginUser.getClass().getMethod("getAccountStatus");
            return "BLOCKED".equals(method.invoke(loginUser));
        } catch (Exception e) {
            return false;
        }
    }
}
