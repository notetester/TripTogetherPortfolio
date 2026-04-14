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
        applyUserActionState(list, search.getLoginUserIdx());
        return list;
    }

    @Override
    public List<ExploreVO> getRatingSpotList(ExploreSearchDto search) {
        List<ExploreVO> list = exploreMapper.selectRatingSpotList(search);
        splitTags(list);
        applyUserActionState(list, search.getLoginUserIdx());
        return list;
    }

    @Override
    public List<ExploreVO> getLikesSpotList(ExploreSearchDto search) {
        List<ExploreVO> list = exploreMapper.selectLikesSpotList(search);
        splitTags(list);
        applyUserActionState(list, search.getLoginUserIdx());
        return list;
    }

    /**
     * 찜한 여행지 목록 조회
     * - loginUserIdx가 null이면(비로그인) 빈 리스트 반환
     * - SPOT_FAVORITE 테이블과 JOIN하여 현재 사용자가 찜한 여행지만 조회
     */
    @Override
    public List<ExploreVO> getFavoriteSpotList(ExploreSearchDto search) {
        // 비로그인 상태에서는 찜 기능을 사용할 수 없으므로 빈 목록 반환
        if (search.getLoginUserIdx() == null) {
            return Collections.emptyList();
        }
        // DB에서 현재 사용자가 찜한 여행지 목록 조회
        List<ExploreVO> list = exploreMapper.selectFavoriteSpotList(search);
        // GROUP_CONCAT으로 가져온 태그 문자열을 List<String>으로 분리
        splitTags(list);
        // 각 카드에 현재 사용자의 찜/좋아요 상태를 표시하기 위해 설정
        applyUserActionState(list, search.getLoginUserIdx());
        return list;
    }


    @Override
    public int getTotalCount(ExploreSearchDto search) {
        String tab = search.getTab();
        if ("rating".equals(tab)) {
            return exploreMapper.selectRatingTotalCount(search);
        } else if ("likes".equals(tab)) {
            return exploreMapper.selectLikesTotalCount(search);
        } else if ("favorite".equals(tab)) {
            // 비로그인이면 찜한 여행지가 0건
            if (search.getLoginUserIdx() == null) {
                return 0;
            }
            // 현재 사용자가 찜한 여행지의 전체 건수 반환
            return exploreMapper.selectFavoriteTotalCount(search);
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
        /* 단계 1. SPOT_TRAVEL 테이블에 기본 정보 INSERT */
        ExploreVO spot = new ExploreVO();
        spot.setSpotId(generateUniqueSpotId());
        spot.setUserIdx(loginUser != null ? loginUser.getUserIdx() : null);
        spot.setName(trimToNull(spotCreateDto.getName()));
        spot.setRegion(trimToNull(spotCreateDto.getRegion()));
        spot.setAddress(trimToNull(spotCreateDto.getAddress()));
        spot.setLatitude(spotCreateDto.getLatitude());
        spot.setLongitude(spotCreateDto.getLongitude());
        spot.setDescription(trimToNull(spotCreateDto.getDescription()));

        exploreMapper.insertSpot(spot);

        /* 단계 2. 이미지 파일이 있으면 SPOT_IMAGE 테이블에 INSERT */
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

    @Override
    public void updateSpot(Long spotIdx, ExploreCreateDto spotCreateDto, UsersVO loginUser) {
        if (spotIdx == null || spotCreateDto == null) {
            return;
        }

        ExploreVO spot = new ExploreVO();
        spot.setSpotIdx(spotIdx);
        spot.setName(trimToNull(spotCreateDto.getName()));
        spot.setRegion(trimToNull(spotCreateDto.getRegion()));
        spot.setAddress(trimToNull(spotCreateDto.getAddress()));
        spot.setLatitude(spotCreateDto.getLatitude());
        spot.setLongitude(spotCreateDto.getLongitude());
        spot.setDescription(trimToNull(spotCreateDto.getDescription()));

        exploreMapper.updateSpot(spot);

        // 관리자가 새 대표 이미지를 업로드한 경우, 기존 이미지를 지우고 새 이미지 1장으로 교체한다.
        MultipartFile imageFile = spotCreateDto.getImage();
        if (imageFile != null && !imageFile.isEmpty()) {
            String imageUrl = saveSpotImage(imageFile);
            if (imageUrl != null) {
                exploreMapper.deleteSpotImages(spotIdx);
                exploreMapper.insertSpotImage(spotIdx, generateImageId(loginUser), imageUrl);
            }
        }

        // 태그는 수정 폼에서 선택한 값으로 전체 교체한다.
        exploreMapper.deleteSpotTags(spotIdx);
        saveSpotTags(spotIdx, spotCreateDto.getTags());
    }

    @Override
    public void softDeleteSpot(Long spotIdx) {
        if (spotIdx == null) {
            return;
        }
        exploreMapper.softDeleteSpot(spotIdx);
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
        // 이미 작성한 리뷰가 없을 때만 작성 가능
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

    @Override
    public void blockReview(Long spotIdx, Long reviewIdx) {
        if (spotIdx == null || reviewIdx == null) {
            return;
        }
        exploreMapper.blockReview(reviewIdx, spotIdx);
    }

    @Override
    public void blockReviews(Long spotIdx, List<Long> reviewIdxList) {
        if (spotIdx == null || reviewIdxList == null || reviewIdxList.isEmpty()) {
            return;
        }
        exploreMapper.blockReviews(spotIdx, reviewIdxList);
    }

    /* ============================================================
       찜 / 좋아요 토글
       ============================================================ */

    /**
     * 검색 자동완성 후보 목록 조회
     * - keyword가 비어있으면 빈 리스트 반환 (불필요한 DB 호출 방지)
     * - keyword 앞뒤 공백 제거 후 SPOT_TRAVEL에서 LIKE 검색
     * @param keyword 사용자 입력 문자열
     * @return 최대 7건의 자동완성 후보 (spotIdx, name, region, address 포함)
     */
    @Override
    public java.util.List<java.util.Map<String, Object>> getSuggestList(String keyword) {
        // 빈 문자열이면 DB 조회 없이 빈 리스트 반환
        if (keyword == null || keyword.trim().isEmpty()) {
            return Collections.emptyList();
        }
        return exploreMapper.selectSuggestList(keyword.trim());
    }

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
       태그 후처리 - GROUP_CONCAT 문자열을 List<String>으로 변환
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

    private void applyUserActionState(List<ExploreVO> list, Long loginUserIdx) {
        if (list == null || list.isEmpty() || loginUserIdx == null) {
            return;
        }

        for (ExploreVO vo : list) {
            Long spotIdx = vo.getSpotIdx();
            if (spotIdx == null) {
                continue;
            }
            vo.setFavorited(exploreMapper.selectFavoriteCount(spotIdx, loginUserIdx) > 0);
            vo.setLiked(exploreMapper.selectLikeCount(spotIdx, loginUserIdx) > 0);
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
     * 여행지 이미지 파일을 서버에 저장하고 웹에서 접근 가능한 URL 경로를 반환한다.
     * - 저장 경로: {프로젝트루트}/{uploadPath}/explore/{UUID}.{확장자}
     * - 반환 URL: /TripTogether/upload/explore/{UUID}.{확장자}
     *
     * @param file 업로드한 이미지 파일
     * @return 저장된 이미지의 웹 접근 경로, 실패 시 null
     */
    private String saveSpotImage(MultipartFile file) {
        /* 확장자 추출 및 허용 형식 검증 */
        String ext = getExtension(file.getOriginalFilename()).toLowerCase();
        if (!ext.equals(".jpg") && !ext.equals(".jpeg")
                && !ext.equals(".png") && !ext.equals(".gif")
                && !ext.equals(".webp")) {
            log.warn("허용되지 않은 여행지 이미지 파일 형식: {}", ext);
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
     * 파일명에서 확장자를 추출한다. (예: "photo.jpg" -> ".jpg")
     */
    private String getExtension(String fileName) {
        if (fileName == null) return "";
        int dotIdx = fileName.lastIndexOf('.');
        return dotIdx >= 0 ? fileName.substring(dotIdx) : "";
    }
}
