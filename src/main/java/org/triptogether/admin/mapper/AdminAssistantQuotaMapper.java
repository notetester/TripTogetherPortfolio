package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdminAssistantQuotaVO;

import java.util.List;

/**
 * ADMIN_ASSISTANT_GRADE_QUOTA 매퍼 - 등급별 한도 CRUD.
 */
@Mapper
public interface AdminAssistantQuotaMapper {

    /** 등급별 전체 목록 (마지막 수정자 닉네임 JOIN 포함). */
    List<AdminAssistantQuotaVO> selectAllQuotas();

    /** 특정 등급 조회. */
    AdminAssistantQuotaVO selectQuotaByGrade(@Param("grade") String grade);

    /** 한도 수정. */
    int updateQuota(AdminAssistantQuotaVO quota);
}
