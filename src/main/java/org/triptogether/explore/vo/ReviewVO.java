package org.triptogether.explore.vo;

import lombok.Data;
import java.util.Date;

/**
 * SPOT_REVIEW 테이블 VO
 */
@Data
public class ReviewVO {

    private Long   reviewIdx;
    private String reviewId;
    private Long   userIdx;
    private Long   spotIdx;
    private int    rating;      // 1~5
    private String content;
    private Date   createdAt;   // java.util.Date (JSP fmt:formatDate 호환)
    private int    reviewBlock; // 0: 정상, 1: 차단

    // JOIN: USERS.nickname
    private String nickname;
}
