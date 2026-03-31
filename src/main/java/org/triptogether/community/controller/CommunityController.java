package org.triptogether.community.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.community.service.CommunityService;
import org.triptogether.community.vo.*;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
public class CommunityController {

    private final CommunityService communityService;

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
                       Model model) {

        CommunitySearchDto search = new CommunitySearchDto();
        search.setRegion(region);
        search.setType(type);
        search.setSort(sort);
        search.setKeyword(keyword);
        search.setPage(page);
        search.calcOffset();

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
        model.addAttribute("relatedList", communityService.getRelatedList(postId));

        return "community/detail";
    }

    /* =============================================
       GET /community/write - 글쓰기 폼
       ============================================= */
    @GetMapping("/write")
    public String writeForm(HttpSession session) {
// 테스트용 임시 주석
//        if (session.getAttribute("loginUser") == null) {
//            return "redirect:/auth/login";
//        }
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
            communityService.reportPost(postId, loginUserIdx);
            result.put("success", true);
        } catch (Exception e) {
            log.error("신고 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

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
}
