package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 관리자 목록 화면 전용 페이징 VO.
 *
 * <p>기존 common.function.Paging 은 nowPage / beginBlock 스타일이라
 * admin JSP 에서 바로 사용하기 불편했기 때문에, 화면 바인딩에 맞는
 * 별도 VO 로 정리했다.</p>
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminPageVO {

    private int currentPage;
    private int pageSize;
    private int totalCount;
    private int totalPage;
    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;

    public static AdminPageVO of(int totalCount, int currentPage, int pageSize, int pageBlockSize) {
        if (currentPage < 1) currentPage = 1;
        if (pageSize < 1) pageSize = 20;
        if (pageBlockSize < 1) pageBlockSize = 10;

        int totalPage = (int) Math.ceil(totalCount / (double) pageSize);
        if (totalPage == 0) totalPage = 1;
        if (currentPage > totalPage) currentPage = totalPage;

        int startPage = ((currentPage - 1) / pageBlockSize) * pageBlockSize + 1;
        int endPage = Math.min(startPage + pageBlockSize - 1, totalPage);

        return AdminPageVO.builder()
                .currentPage(currentPage)
                .pageSize(pageSize)
                .totalCount(totalCount)
                .totalPage(totalPage)
                .startPage(startPage)
                .endPage(endPage)
                .prev(startPage > 1)
                .next(endPage < totalPage)
                .build();
    }
}
