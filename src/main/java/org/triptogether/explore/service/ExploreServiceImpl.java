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

    /** application.properties??file.upload.path 媛?(?? src/main/resources/upload/) */
    @Value("${file.upload.path}")
    private String uploadPath;

    /* ============================================================
       紐⑸줉 議고쉶
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
       ?꾪꽣 ?곗씠??
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
       ?곸꽭 議고쉶
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
        /* ?? 1. SPOT_TRAVEL ?뚯씠釉붿뿉 湲곕낯 ?뺣낫 INSERT ?? */
        ExploreVO spot = new ExploreVO();
        spot.setSpotId(generateUniqueSpotId());
        spot.setName(trimToNull(spotCreateDto.getName()));
        spot.setRegion(trimToNull(spotCreateDto.getRegion()));
        spot.setAddress(trimToNull(spotCreateDto.getAddress()));
        spot.setLatitude(spotCreateDto.getLatitude());
        spot.setLongitude(spotCreateDto.getLongitude());
        spot.setDescription(trimToNull(spotCreateDto.getDescription()));

        exploreMapper.insertSpot(spot);

        /* ?? 2. ?대?吏 ?뚯씪???덉쑝硫??????SPOT_IMAGE ?뚯씠釉붿뿉 INSERT ?? */
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
       由щ럭
       ============================================================ */

    @Override
    public List<ReviewVO> getReviewList(Long spotIdx) {
        return exploreMapper.selectReviewList(spotIdx);
    }

    @Override
    public boolean canWriteReview(Long spotIdx, Long userIdx) {
        // ?대? ?묒꽦??由щ럭媛 ?놁뼱???묒꽦 媛??
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
       李?/ 醫뗭븘???좉?
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
       ?대? ?좏떥 - GROUP_CONCAT ??List<String>
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
     * ?ы뻾吏 ?대?吏 ?뚯씪???쒕쾭????ν븯怨? ?묎렐 媛?ν븳 URL 寃쎈줈瑜?諛섑솚?쒕떎.
     * - ???寃쎈줈: {?꾨줈?앺듃猷⑦듃}/{uploadPath}/explore/{UUID}.{?뺤옣??
     * - 諛섑솚 URL:  /TripTogether/upload/explore/{UUID}.{?뺤옣??
     *
     * @param file ?낅줈?쒕맂 ?대?吏 ?뚯씪
     * @return ??λ맂 ?대?吏?????묎렐 寃쎈줈, ?ㅽ뙣 ??null
     */
    private String saveSpotImage(MultipartFile file) {
        /* ?뺤옣??異붿텧 諛??덉슜 ?뺤떇 寃利?*/
        String ext = getExtension(file.getOriginalFilename()).toLowerCase();
        if (!ext.equals(".jpg") && !ext.equals(".jpeg")
                && !ext.equals(".png") && !ext.equals(".gif")
                && !ext.equals(".webp")) {
            log.warn("?덉슜?섏? ?딅뒗 ?ы뻾吏 ?대?吏 ?뚯씪 ?뺤떇: {}", ext);
            return null;
        }

        try {
            /* ????붾젆?곕━ ?앹꽦 (?놁쑝硫??먮룞 ?앹꽦) */
            String dir = System.getProperty("user.dir").replace("\\", "/")
                    + "/" + uploadPath + "/explore/";
            File dirFile = new File(dir);
            if (!dirFile.exists()) dirFile.mkdirs();

            /* UUID 湲곕컲 怨좎쑀 ?뚯씪紐??앹꽦 ?????*/
            String fileName = UUID.randomUUID().toString() + ext;
            file.transferTo(new File(dir + fileName));

            /* ?뱀뿉???묎렐 媛?ν븳 URL 寃쎈줈 諛섑솚 */
            return "/TripTogether/upload/explore/" + fileName;
        } catch (IOException e) {
            log.error("?ы뻾吏 ?대?吏 ?뚯씪 ????ㅽ뙣", e);
            return null;
        }
    }

    /**
     * ?뚯씪紐낆뿉???뺤옣?먮? 異붿텧?쒕떎. (?? "photo.jpg" ??".jpg")
     */
    private String getExtension(String fileName) {
        if (fileName == null) return "";
        int dotIdx = fileName.lastIndexOf('.');
        return dotIdx >= 0 ? fileName.substring(dotIdx) : "";
    }
}
