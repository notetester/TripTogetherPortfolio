package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.myPage.mapper.MyPageMapper;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MyPageService {

    private final MyPageMapper myPageMapper;

    public List<MyPageCommunityDto> getMyCommunityList(Long userIdx) {
        return myPageMapper.selectMyCommunityList(userIdx);
    }

    public int getMyCommunityCount(Long userIdx) {
        return myPageMapper.selectMyCommunityCount(userIdx);
    }

    public List<MyPageInquiryDto> getMyInquiryList(Long userIdx) {
        return myPageMapper.selectMyInquiryList(userIdx);
    }

    public int getMyInquiryCount(Long userIdx) {
        return myPageMapper.selectMyInquiryCount(userIdx);
    }
}