package org.triptogether.myPage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;

import java.util.List;

@Mapper
public interface MyPageMapper {

    List<MyPageCommunityDto> selectMyCommunityList(@Param("userIdx") Long userIdx);
    int selectMyCommunityCount(@Param("userIdx") Long userIdx);

    List<MyPageInquiryDto> selectMyInquiryList(@Param("userIdx") Long userIdx);
    int selectMyInquiryCount(@Param("userIdx") Long userIdx);
}