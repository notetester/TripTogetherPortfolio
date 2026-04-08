package org.triptogether.explore.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.mapper.ExploreMapper;
import org.triptogether.explore.vo.ExploreCreateDto;
import org.triptogether.explore.vo.ExploreSearchDto;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.ReviewVO;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExploreServiceImpl implements ExploreService {

    private final ExploreMapper exploreMapper;

    /** application.properties의 file.upload.path 값 (예: src/main/resources/upload/) */
    @Value("${file.upload.path}")
    private String uploadPath;

    /* ============================================================
       목록 조회
       ============================================================ */

    @Override
    public List<ExploreVO> getSpotList(ExploreSearchDto search) {
        List<ExploreVO> list = exploreMapper.selectSpotList(search);
        splitTags(list);
        return list;
    }

    @Override
    public List<ExploreVO> getRatingSpotList(ExploreSearchDto search) {
        List<ExploreVO> list = exploreMapper.selectRatingSpotList(search);
        splitTags(list);
        return list;
    }

    @Override
    public List<ExploreVO> getLikesSpotList(ExploreSearchDto search) {
        List<ExploreVO> list = exploreMapper.selectLikesSpotList(search);
        splitTags(list);
        return list;
    }

    @Override
    public int getTotalCount(ExploreSearchDto search) {
        String tab = search.getTab();
        if ("rating".equals(tab)) {
            return exploreMapper.selectRatingTotalCount(search);
        } else if ("likes".equals(tab)) {
            return exploreMapper.selectLikesTotalCount(search);
        }
        return exploreMapper.selectTotalCount(search);
    }

    @Override
    public int getTotalPage(ExploreSearchDto search) {
        int total = getTotalCount(search);
        int size  = search.getPageSize();
        return (int) Math.ceil((double) total / size);
    }

    /* ============================================================
       필터 데이터
       ============================================================ */

    @Override
    public List<String> getRegionList() {
        return exploreMapper.selectRegionList();
    }

    @Override
    public List<String> getTagList() {
        return exploreMapper.selectTagList();
    }

    @Override
    public List<String> getWriteTagList() {
        return exploreMapper.selectAllTagList();
    }

    /* ============================================================
       상세 조회
       ============================================================ */

    @Override
    public ExploreVO getSpotDetail(Long spotIdx, Long loginUserIdx) {
        ExploreVO vo = exploreMapper.selectSpotDetail(spotIdx);
        if (vo == null) return null;

        vo.setTags(exploreMapper.selectSpotTags(spotIdx));

        if (loginUserIdx != null) {
            vo.setFavorited(exploreMapper.selectFavoriteCount(spotIdx, loginUserIdx) > 0);
            vo.setLiked(exploreMapper.selectLikeCount(spotIdx, loginUserIdx) > 0);
        }
        return vo;
    }

    @Override
    public Long createSpot(ExploreCreateDto spotCreateDto, UsersVO loginUser) {
        /* ── 1. SPOT_TRAVEL 테이블에 기본 정보 INSERT ── */
        ExploreVO spot = new ExploreVO();
        spot.setSpotId(generateUniqueSpotId());
        spot.setName(trimToNull(spotCreateDto.getName()));
        spot.setRegion(trimToNull(spotCreateDto.getRegion()));
        spot.setAddress(trimToNull(spotCreateDto.getAddress()));
        spot.setLatitude(spotCreateDto.getLatitude());
        spot.setLongitude(spotCreateDto.getLongitude());
        spot.setDescription(trimToNull(spotCreateDto.getDescription()));

        exploreMapper.insertSpot(spot);

        /* ── 2. 이미지 파일이 있으면 저장 후 SPOT_IMAGE 테이블에 INSERT ── */
        MultipartFile imageFile = spotCreateDto.getImage();
        if (imageFile != null && !imageFile.isEmpty()) {
            String imageUrl = saveSpotImage(imageFile);
            if (imageUrl != null) {
                exploreMapper.insertSpotImage(spot.getSpotIdx(), generateImageId(loginUser), imageUrl);
            }
        }

        saveSpotTags(spot.getSpotIdx(), spotCreateDto.getTags());

        return spot.getSpotIdx();
    }

    /* ============================================================
       리뷰
       ============================================================ */

    @Override
    public List<ReviewVO> getReviewList(Long spotIdx) {
        return exploreMapper.selectReviewList(spotIdx);
    }

    @Override
    public boolean canWriteReview(Long spotIdx, Long userIdx) {
        // 이미 작성한 리뷰가 없어야 작성 가능
        return exploreMapper.selectMyReviewCount(spotIdx, userIdx) == 0;
    }

    @Override
    public void writeReview(ReviewVO review) {
        exploreMapper.insertReview(review);
    }

    @Override
    public void deleteReview(Long reviewIdx, Long userIdx) {
        exploreMapper.deleteReview(reviewIdx, userIdx);
    }

    /* ============================================================
       찜 / 좋아요 토글
       ============================================================ */

    @Override
    public boolean toggleFavorite(Long spotIdx, Long userIdx) {
        boolean already = exploreMapper.selectFavoriteCount(spotIdx, userIdx) > 0;
        if (already) { exploreMapper.deleteFavorite(spotIdx, userIdx); return false; }
        else          { exploreMapper.insertFavorite(spotIdx, userIdx); return true;  }
    }

    @Override
    public boolean toggleLike(Long spotIdx, Long userIdx) {
        boolean already = exploreMapper.selectLikeCount(spotIdx, userIdx) > 0;
        if (already) { exploreMapper.deleteLike(spotIdx, userIdx); return false; }
        else          { exploreMapper.insertLike(spotIdx, userIdx); return true;  }
    }

    /* ============================================================
       내부 유틸 - GROUP_CONCAT → List<String>
       ============================================================ */
    private void splitTags(List<ExploreVO> list) {
        if (list == null) return;
        for (ExploreVO vo : list) {
            String concat = vo.getTagsConcat();
            vo.setTags(concat != null && !concat.isBlank()
                    ? Arrays.asList(concat.split(","))
                    : Collections.emptyList());
        }
    }

    private String generateUniqueSpotId() {
        String spotId;
        do {
            spotId = "SPOT-" + UUID.randomUUID().toString().replace("-", "")
                    .substring(0, 16).toUpperCase();
        } while (exploreMapper.countBySpotId(spotId) > 0);
        return spotId;
    }

    private String generateImageId(UsersVO loginUser) {
        String userId = loginUser != null ? trimToNull(loginUser.getUserId()) : null;
        if (userId == null && loginUser != null && loginUser.getUserIdx() != null) {
            userId = "user" + loginUser.getUserIdx();
        }
        if (userId == null) {
            userId = "guest";
        }

        String uploadedAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String uuid = UUID.randomUUID().toString().replace("-", "");
        return userId + "_" + uploadedAt + "_" + uuid;
    }

    private void saveSpotTags(Long spotIdx, List<String> tagNames) {
        if (spotIdx == null || tagNames == null || tagNames.isEmpty()) {
            return;
        }

        Set<String> uniqueTags = new LinkedHashSet<>();
        for (String tagName : tagNames) {
            String trimmedTag = trimToNull(tagName);
            if (trimmedTag != null) {
                uniqueTags.add(trimmedTag);
            }
        }

        for (String tagName : uniqueTags) {
            Integer tagIdx = exploreMapper.selectTagIdxByName(tagName);
            if (tagIdx != null) {
                exploreMapper.insertSpotTag(spotIdx, tagIdx);
            }
        }
    }

    private String trimToNull(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    /**
     * 여행지 이미지 파일을 서버에 저장하고, 접근 가능한 URL 경로를 반환한다.
     * - 저장 경로: {프로젝트루트}/{uploadPath}/explore/{UUID}.{확장자}
     * - 반환 URL:  /TripTogether/upload/explore/{UUID}.{확장자}
     *
     * @param file 업로드된 이미지 파일
     * @return 저장된 이미지의 웹 접근 경로, 실패 시 null
     */
    private String saveSpotImage(MultipartFile file) {
        /* 확장자 추출 및 허용 형식 검증 */
        String ext = getExtension(file.getOriginalFilename()).toLowerCase();
        if (!ext.equals(".jpg") && !ext.equals(".jpeg")
                && !ext.equals(".png") && !ext.equals(".gif")
                && !ext.equals(".webp")) {
            log.warn("허용되지 않는 여행지 이미지 파일 형식: {}", ext);
            return null;
        }

        try {
            /* 저장 디렉터리 생성 (없으면 자동 생성) */
            String dir = System.getProperty("user.dir").replace("\\", "/")
                    + "/" + uploadPath + "/explore/";
            File dirFile = new File(dir);
            if (!dirFile.exists()) dirFile.mkdirs();

            /* UUID 기반 고유 파일명 생성 후 저장 */
            String fileName = UUID.randomUUID().toString() + ext;
            file.transferTo(new File(dir + fileName));

            /* 웹에서 접근 가능한 URL 경로 반환 */
            return "/TripTogether/upload/explore/" + fileName;
        } catch (IOException e) {
            log.error("여행지 이미지 파일 저장 실패", e);
            return null;
        }
    }

    /**
     * 파일명에서 확장자를 추출한다. (예: "photo.jpg" → ".jpg")
     */
    private String getExtension(String fileName) {
        if (fileName == null) return "";
        int dotIdx = fileName.lastIndexOf('.');
        return dotIdx >= 0 ? fileName.substring(dotIdx) : "";
    }
}
