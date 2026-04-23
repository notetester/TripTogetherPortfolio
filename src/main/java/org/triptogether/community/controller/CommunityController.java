package org.triptogether.community.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.community.service.CommunityService;
import org.triptogether.community.vo.*;
import org.triptogether.auth.vo.UserRole;
import org.triptogether.perspective.PerspectiveService;

import org.jsoup.Jsoup;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.triptogether.config.IpBlockMapper;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * =============================================
 * CommunityController - 커뮤니티 게시판 컨트롤러
 * =============================================
 * 담당 URL: /community/**
 *
 * [기능 목록]
 * - 게시글 목록 / 상세 조회
 * - 게시글 작성 / 수정 / 삭제
 * - 게시글 좋아요 토글
 * - 댓글 / 대댓글 작성 / 삭제 / 좋아요
 * - 질문 댓글 채택
 * - 신고 접수 (게시글 / 댓글)
 * - 관리자: 게시글/댓글/유저 차단·해제, 일괄 처리, 뷰 모드 전환
 *
 * [권한 구조]
 * - 비로그인  : 목록/상세 조회만 가능
 * - 일반 유저 : 게시글/댓글 작성·수정·삭제, 좋아요, 신고 가능
 * - 관리자    : 차단·해제, 일괄 처리, 뷰 모드 전환 가능
 * =============================================
 */
@Slf4j
@Controller
@RequestMapping("/community")
@RequiredArgsConstructor
public class CommunityController {

    private final CommunityService communityService;
    private final PerspectiveService perspectiveService;
    private final IpBlockMapper ipBlockMapper;

    /* =============================================
       GET /community, /community/ - 루트 리다이렉트
       ============================================= */
    /** /community, /community/ → /community/list 로 리다이렉트 */
    @GetMapping({"", "/"})
    public String communityRoot() {
        return "redirect:/community/list";
    }

    /* =============================================
       GET /community/list - 커뮤니티 목록
       파라미터: region, type, sort, keyword, searchType, page
       ============================================= */
    /**
     * 커뮤니티 목록 페이지를 보여준다.
     * - region / type / sort / keyword / searchType / page 조건으로 필터링
     * - 전체 조건일 때만 todayPopularList 추가 제공
     */
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "all")    String region,
                       @RequestParam(defaultValue = "all")    String type,
                       @RequestParam(defaultValue = "latest") String sort,
                       @RequestParam(defaultValue = "")       String keyword,
                       @RequestParam(defaultValue = "all")    String searchType,
                       @RequestParam(defaultValue = "1")      int    page,
                       HttpSession session,
                       Model model) {

        CommunitySearchDto search = new CommunitySearchDto();
        search.setRegion(region);
        search.setType(type);
        search.setSort(sort);
        search.setKeyword(keyword);
        search.setSearchType(searchType);
        search.setPage(page);
        search.calcOffset();
        search.setAdminMode(isAdminUser(session) && !"user".equals(session.getAttribute("viewMode")));

        model.addAttribute("postList",          communityService.getPostList(search));
        model.addAttribute("totalCount",        communityService.getTotalCount(search));
        model.addAttribute("currentPage",       page);
        model.addAttribute("totalPage",         communityService.getTotalPage(search));
        boolean showSections = "all".equals(region) && "all".equals(type) && "all".equals(searchType) && keyword.isEmpty();
        if (showSections) {
            model.addAttribute("popularList", communityService.getPopularList(8));
        }
        return "community/list";
    }

    /* =============================================
       GET /community/{postId} - 커뮤니티 상세
       ============================================= */
    /**
     * 커뮤니티 게시글 상세 페이지를 보여준다.
     * - 조회수 증가, 관련글 / 최신글 목록 포함
     * - 로그인 유저의 좋아요 여부 / 소유자 여부 포함
     */
    @GetMapping("/{postId}")
    public String detail(@PathVariable Long postId,
                         @RequestParam(defaultValue = "1") int latestPage,
                         HttpSession session,
                         Model model) {

        communityService.increaseViewCount(postId);

        Long loginUserIdx = getLoginUserIdx(session);

        CommunityPostDto post = communityService.getPost(postId);
        if (post == null) return "redirect:/community/list";

        List<CommunityPostDto> relatedList = communityService.getRelatedList(postId);

        // 최신글 제외 ID: 현재 게시글 + 추천글
        List<Long> excludeIds = new ArrayList<>();
        excludeIds.add(postId);
        for (CommunityPostDto r : relatedList) {
            excludeIds.add(r.getPostId());
        }

        int latestPageSize = 10;
        int latestTotalPage = communityService.getLatestTotalPage(excludeIds, latestPageSize);
        if (latestPage < 1) latestPage = 1;
        if (latestPage > latestTotalPage && latestTotalPage > 0) latestPage = latestTotalPage;

        model.addAttribute("post",        post);
        model.addAttribute("imageList",   communityService.getImageList(postId));
        model.addAttribute("tagList",     communityService.getTagList(postId));
        model.addAttribute("commentList", communityService.getCommentList(postId));
        model.addAttribute("tipCategory", communityService.getTipCategory(postId));
        model.addAttribute("isSolved",    communityService.isSolved(postId));
        model.addAttribute("isLiked",     loginUserIdx != null && communityService.isLiked(postId, loginUserIdx));
        model.addAttribute("isOwner",     loginUserIdx != null && loginUserIdx.equals(post.getUserIdx()));
        model.addAttribute("acceptedCommentId", communityService.getAcceptedCommentId(postId));
        model.addAttribute("relatedList",       relatedList);
        model.addAttribute("latestList",        communityService.getLatestList(excludeIds, latestPage, latestPageSize));
        model.addAttribute("latestPage",        latestPage);
        model.addAttribute("latestTotalPage",   latestTotalPage);

        return "community/detail";
    }

    /* =============================================
       GET /community/{postId}/comments - 댓글 목록 AJAX 프래그먼트
       파라미터: sort=created|latest|replies
       ============================================= */
    /**
     * 댓글 목록 HTML 프래그먼트를 반환한다. (AJAX용)
     * - sort: created(등록순) / latest(최신순) / replies(답글많은순)
     */
    @GetMapping("/{postId}/comments")
    public String commentFragment(@PathVariable Long postId,
                                  @RequestParam(defaultValue = "created") String sort,
                                  HttpSession session,
                                  Model model) {
        Long loginUserIdx = getLoginUserIdx(session);
        CommunityPostDto post = communityService.getPost(postId);
        if (post == null) return "redirect:/community/list";

        model.addAttribute("post",             post);
        model.addAttribute("commentList",      communityService.getCommentList(postId, sort));
        model.addAttribute("acceptedCommentId",communityService.getAcceptedCommentId(postId));
        model.addAttribute("isSolved",         communityService.isSolved(postId));
        model.addAttribute("isOwner",          loginUserIdx != null && loginUserIdx.equals(post.getUserIdx()));
        return "community/_comment_list";
    }

    /* =============================================
       GET /community/write - 글쓰기 폼
       ============================================= */
    /**
     * 글쓰기 폼 페이지를 보여준다.
     * - 비로그인 시 로그인 페이지로 리다이렉트
     */
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
    /**
     * 게시글을 등록한다.
     * - 비로그인 시 401, 차단된 계정 시 403 반환
     * - Perspective AI 욕설 감지는 비동기로 실행됨. 감지되면 ai_flagged=1 세팅되어 BLUR 처리됨
     */
    @PostMapping("/write")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> write(
            @ModelAttribute CommunityWriteDto writeDto,
            HttpServletRequest request,
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
            communityService.savePostIp(postId, getClientIp(request));

            // AI 욕설 감지 비동기 실행: 응답 지연 없이 백그라운드에서 처리됨
            // Summernote가 HTML을 저장하므로 Perspective에는 plain text로 넘김
            String contentText = stripHtml(writeDto.getContent());
            String text = (writeDto.getTitle() != null ? writeDto.getTitle() : "") + " " + contentText;
            perspectiveService.checkAndFlagPostAsync(postId, text);

            result.put("success", true);
            result.put("postId",  postId);
        } catch (IllegalStateException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.status(429).body(result);
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
    /**
     * 게시글 수정 폼 페이지를 보여준다.
     * - 비로그인 시 로그인 페이지로 리다이렉트
     */
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
    /**
     * 게시글을 수정한다.
     * - 비로그인 시 401 반환
     * - 소유자 또는 관리자만 수정 가능
     */
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

            // Summernote HTML → plain text (Perspective 정확도 보장)
            perspectiveService.checkAndFlagPostAsync(postId,
                    (writeDto.getTitle() != null ? writeDto.getTitle() : "") + " "
                  + stripHtml(writeDto.getContent()));

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
    /**
     * 게시글을 삭제한다.
     * - 비로그인 시 401 반환
     * - post_status = 'DELETED' 로 변경 (실제 삭제 X)
     */
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
    /**
     * 게시글 좋아요를 토글한다.
     * - 비로그인 시 401 반환
     * - liked(현재 좋아요 여부), likeCount(총 좋아요 수) 반환
     */
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
    /**
     * 댓글을 등록한다.
     * - 비로그인 시 401, 차단된 계정 시 403 반환
     * - Perspective AI 욕설 감지는 비동기로 실행됨. 감지되면 ai_flagged=1 세팅되어 BLUR 처리됨
     */
    @PostMapping("/{postId}/comment")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addComment(
            @PathVariable Long postId,
            @RequestParam String content,
            HttpServletRequest request,
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

            Long commentId = communityService.addComment(postId, loginUserIdx, content);
            communityService.saveCommentIp(commentId, getClientIp(request));

            // AI 욕설 감지 비동기 실행: 응답 지연 없이 백그라운드에서 처리됨
            perspectiveService.checkAndFlagCommentAsync(commentId, content);

            result.put("success", true);
        } catch (IllegalStateException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.status(429).body(result);
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
    /**
     * 댓글을 삭제한다.
     * - 비로그인 시 401 반환
     * - comment_status = 'DELETED' 로 변경 (실제 삭제 X)
     */
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
    /**
     * 대댓글을 등록한다.
     * - 비로그인 시 401, 차단된 계정 시 403 반환
     * - Perspective AI 욕설 감지는 비동기로 실행됨. 감지되면 ai_flagged=1 세팅되어 BLUR 처리됨
     */
    @PostMapping("/{postId}/comment/{commentId}/reply")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addReply(
            @PathVariable Long postId,
            @PathVariable Long commentId,
            @RequestParam String content,
            HttpServletRequest request,
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

            Long replyId = communityService.addReply(postId, loginUserIdx, content, commentId);
            communityService.saveCommentIp(replyId, getClientIp(request));

            // AI 욕설 감지 비동기 실행
            perspectiveService.checkAndFlagCommentAsync(replyId, content);

            result.put("success", true);
        } catch (IllegalStateException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.status(429).body(result);
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
    /**
     * 질문 게시글에서 댓글을 채택한다.
     * - 비로그인 시 401 반환
     * - 게시글 작성자 본인만 채택 가능 (타인 시도 시 403 반환)
     */
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
    /**
     * 댓글 좋아요를 토글한다.
     * - 비로그인 시 401 반환
     * - liked(현재 좋아요 여부), likeCount(총 좋아요 수) 반환
     */
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
   POST /community/user/{userIdx}/block - 유저 차단
   ============================================= */
    /* =============================================
       POST /community/user/{userIdx}/block - 유저 차단 (어드민)
       POST /community/user/{userIdx}/unblock - 유저 차단 해제 (어드민)
       ============================================= */
    /**
     * 유저 계정을 차단한다. (관리자 전용)
     * - 비관리자 시 403 반환
     * - account_status = 'BLOCKED' 로 변경
     */
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

    /**
     * 유저 계정 차단을 해제한다. (관리자 전용)
     * - 비관리자 시 403 반환
     */
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



    /* =============================================
       POST /community/{postId}/block   - 게시글 차단 (어드민)
       POST /community/{postId}/unblock - 게시글 차단 해제 (어드민)
       ============================================= */
    /**
     * 게시글을 차단한다. (관리자 전용)
     * - 비관리자 시 403 반환
     * - post_status = 'DORMANT' 로 변경
     */
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

    /**
     * 게시글 차단을 해제한다. (관리자 전용)
     * - 비관리자 시 403 반환
     */
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

    /* =============================================
       POST /community/comment/{commentId}/block   - 댓글 차단 (어드민)
       POST /community/comment/{commentId}/unblock - 댓글 차단 해제 (어드민)
       ============================================= */
    /**
     * 댓글을 차단한다. (관리자 전용)
     * - 비관리자 시 403 반환
     * - comment_status = 'BLOCKED' 로 변경
     */
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

    /**
     * 댓글 차단을 해제한다. (관리자 전용)
     * - 비관리자 시 403 반환
     */
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

    /* =============================================
       POST /community/{postId}/clear-blur   - 게시글 BLUR 해제 (어드민)
       POST /community/comment/{commentId}/clear-blur - 댓글 BLUR 해제 (어드민)
       ============================================= */
    /**
     * 게시글 BLUR 해제. (관리자 전용)
     * - ai_flagged=0, report_count=0 으로 초기화
     * - 비관리자 시 403 반환
     */
    @PostMapping("/{postId}/clear-blur")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> clearPostBlur(
            @PathVariable Long postId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdminUser(session)) {
            result.put("success", false); return ResponseEntity.status(403).body(result);
        }
        communityService.clearPostBlur(postId);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /**
     * 댓글 BLUR 해제. (관리자 전용)
     * - ai_flagged=0, report_count=0 으로 초기화
     * - 비관리자 시 403 반환
     */
    @PostMapping("/comment/{commentId}/clear-blur")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> clearCommentBlur(
            @PathVariable Long commentId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdminUser(session)) {
            result.put("success", false); return ResponseEntity.status(403).body(result);
        }
        communityService.clearCommentBlur(commentId);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /community/admin/viewmode - 관리자 뷰 모드 전환 (어드민)
       ============================================= */
    /**
     * 관리자의 뷰 모드를 토글한다. (admin ↔ user)
     * - 비관리자 시 403 반환
     * - 관리자가 일반 유저 시점으로 화면을 확인할 때 사용
     */
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
       POST /community/admin/bulk — 게시글 일괄 처리
       action: delete / blockUser / blockIp / blockBoth / blockAndDelete
       ============================================= */
    /**
     * 게시글 일괄 처리. (관리자 전용)
     * - action: delete / blockUser / blockIp / blockBoth / blockUserAndDelete / blockIpAndDelete / blockAndDelete
     * - 비관리자 시 403 반환
     */
    @PostMapping("/admin/bulk")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bulkAction(
            @RequestParam String action,
            @RequestParam List<Long> postIds,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        if (!isAdminUser(session)) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }
        if (postIds == null || postIds.isEmpty()) {
            result.put("success", false);
            result.put("message", "선택된 게시글이 없습니다.");
            return ResponseEntity.badRequest().body(result);
        }

        try {
            switch (action) {
                case "delete":
                    communityService.bulkDeletePosts(postIds);
                    break;
                case "blockUser":
                    communityService.bulkBlockUsersByPosts(postIds);
                    break;
                case "blockIp":
                    bulkBlockIps(communityService.getIpsByPostIds(postIds), "게시글 관리자 일괄 차단");
                    break;
                case "blockBoth":
                    communityService.bulkBlockUsersByPosts(postIds);
                    bulkBlockIps(communityService.getIpsByPostIds(postIds), "게시글 관리자 일괄 차단");
                    break;
                case "blockUserAndDelete":
                    communityService.bulkBlockUsersByPosts(postIds);
                    communityService.bulkDeletePosts(postIds);
                    break;
                case "blockIpAndDelete":
                    bulkBlockIps(communityService.getIpsByPostIds(postIds), "게시글 관리자 일괄 차단");
                    communityService.bulkDeletePosts(postIds);
                    break;
                case "blockAndDelete":
                    communityService.bulkBlockUsersByPosts(postIds);
                    bulkBlockIps(communityService.getIpsByPostIds(postIds), "게시글 관리자 일괄 차단");
                    communityService.bulkDeletePosts(postIds);
                    break;
                default:
                    result.put("success", false);
                    result.put("message", "알 수 없는 액션입니다.");
                    return ResponseEntity.badRequest().body(result);
            }
            result.put("success", true);
        } catch (Exception e) {
            log.error("게시글 일괄 처리 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /community/admin/bulk/comment — 댓글/대댓글 일괄 처리
       action: delete / blockUser / blockIp / blockBoth / blockAndDelete
       ============================================= */
    /**
     * 댓글/대댓글 일괄 처리. (관리자 전용)
     * - action: delete / blockUser / blockIp / blockBoth / blockUserAndDelete / blockIpAndDelete / blockAndDelete
     * - 비관리자 시 403 반환
     */
    @PostMapping("/admin/bulk/comment")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bulkCommentAction(
            @RequestParam String action,
            @RequestParam List<Long> commentIds,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        if (!isAdminUser(session)) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }
        if (commentIds == null || commentIds.isEmpty()) {
            result.put("success", false);
            result.put("message", "선택된 댓글이 없습니다.");
            return ResponseEntity.badRequest().body(result);
        }

        try {
            switch (action) {
                case "delete":
                    communityService.bulkDeleteComments(commentIds);
                    break;
                case "blockUser":
                    communityService.bulkBlockUsersByComments(commentIds);
                    break;
                case "blockIp":
                    bulkBlockIps(communityService.getIpsByCommentIds(commentIds), "댓글 관리자 일괄 차단");
                    break;
                case "blockBoth":
                    communityService.bulkBlockUsersByComments(commentIds);
                    bulkBlockIps(communityService.getIpsByCommentIds(commentIds), "댓글 관리자 일괄 차단");
                    break;
                case "blockUserAndDelete":
                    communityService.bulkBlockUsersByComments(commentIds);
                    communityService.bulkDeleteComments(commentIds);
                    break;
                case "blockIpAndDelete":
                    bulkBlockIps(communityService.getIpsByCommentIds(commentIds), "댓글 관리자 일괄 차단");
                    communityService.bulkDeleteComments(commentIds);
                    break;
                case "blockAndDelete":
                    communityService.bulkBlockUsersByComments(commentIds);
                    bulkBlockIps(communityService.getIpsByCommentIds(commentIds), "댓글 관리자 일괄 차단");
                    communityService.bulkDeleteComments(commentIds);
                    break;
                default:
                    result.put("success", false);
                    result.put("message", "알 수 없는 액션입니다.");
                    return ResponseEntity.badRequest().body(result);
            }
            result.put("success", true);
        } catch (Exception e) {
            log.error("댓글 일괄 처리 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    /* =============================================
   로그인 사용자 userIdx 추출 유틸
   로그인 담당자 UserDto의 getUserIdx() 메서드 호출
   ============================================= */
    /**
     * 세션에서 로그인한 유저의 idx를 꺼낸다.
     * 로그인 안 했거나 오류 시 null 반환.
     * auth 모듈 VO를 직접 import 하지 않고 리플렉션으로 접근 (담당자 간 의존성 최소화)
     */
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

    /**
     * 세션에서 로그인한 유저가 관리자 계열인지 확인한다.
     */
    private boolean isAdminUser(HttpSession session) {
        try {
            Object loginUser = session.getAttribute("loginUser");
            if (loginUser == null) return false;
            Method method = loginUser.getClass().getMethod("getUserRole");
            return UserRole.from(String.valueOf(method.invoke(loginUser))).isAdminLike();
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 세션에서 로그인한 유저가 차단된 계정인지 확인한다.
     */
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

    /**
     * 클라이언트의 실제 IP를 추출한다.
     * 프록시 / 로드밸런서 헤더를 순서대로 확인하고, 없으면 remoteAddr 반환.
     */
    private String getClientIp(HttpServletRequest request) {
        String[] headers = {
                "X-Forwarded-For", "Proxy-Client-IP", "WL-Proxy-Client-IP",
                "HTTP_CLIENT_IP", "HTTP_X_FORWARDED_FOR"
        };
        for (String h : headers) {
            String ip = request.getHeader(h);
            if (ip != null && !ip.isBlank() && !"unknown".equalsIgnoreCase(ip)) {
                return ip.split(",")[0].trim();
            }
        }
        return request.getRemoteAddr();
    }

    /**
     * IP 목록을 일괄 차단한다.
     * 빈 목록이면 아무 작업도 하지 않는다.
     */
    private void bulkBlockIps(List<String> ips, String reason) {
        if (ips == null || ips.isEmpty()) return;
        ipBlockMapper.insertBlockedIps(ips, reason);
    }

    /**
     * Summernote가 저장한 HTML 본문에서 태그를 제거해 plain text로 변환한다.
     * Perspective API는 HTML 태그를 인용문으로 오인할 수 있어 정확도 확보를 위해 필수.
     */
    private String stripHtml(String html) {
        if (html == null || html.isBlank()) return "";
        return Jsoup.parse(html).text();
    }
}
