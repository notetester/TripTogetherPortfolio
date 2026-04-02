package org.triptogether.common.function;

import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Paging {
    // 페이징 기법이란 대량의 데이터를 한 화면에 모두 표시하지 않고, 일정한 개수씩
    // 나누어 보여 주는 기술

    // 현재 페이지
    private int nowPage = 1 ;
    // 현재 블록
    private int nowBlock = 1 ;
    // 한 페이지당 게시물의 수
    private int numPerPage = 10;
    // 페이지당 블록의 수
    private int pagePerBlock = 3 ;
    // DB 게시물의 수
    private int totalRecord = 0 ;
    // 전체 페이지의 수
    private int totalPage = 0 ;
    // 전체 블록의 수
    private int totalBlock = 0 ;
    // 블록의 시작과 끝
    private int beginBlock = 0 ;
    private int endBlock = 0 ;

    // 한번에 가져올 게시물을 처리하는 변수 (MySQL O, MariaDB O, Oracle X)
    private int offset = 0;

    public Paging(int totalRecord, int nowPage, int numPerPage, int pagePerBlock) {
        // 입력값 방어
        if (nowPage < 1) nowPage = 1;
        if (numPerPage <= 0) numPerPage = 10;
        if (pagePerBlock <= 0) pagePerBlock = 3;

        this.totalRecord  = totalRecord;
        this.nowPage      = nowPage;
        this.numPerPage   = numPerPage;
        this.pagePerBlock = pagePerBlock;

        // 1. 전체 페이지
        this.totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
        if (this.totalPage == 0) this.totalPage = 1;

        // 2. 전체 블록
        this.totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);

        // 3. 현재 블록
        this.nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);

        // 4. 블록 시작/끝
        this.beginBlock = (nowBlock - 1) * pagePerBlock + 1;
        this.endBlock   = beginBlock + pagePerBlock - 1;

        if (endBlock > totalPage) {
            endBlock = totalPage;
        }

        // 5. offset (MySQL용)
        this.offset = (nowPage - 1) * numPerPage;
    }
}
