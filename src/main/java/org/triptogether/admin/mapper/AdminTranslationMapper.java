package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdminTranslationRevisionVO;
import org.triptogether.admin.vo.AdminTranslationSourceSnapshotVO;
import org.triptogether.admin.vo.AdminTranslationVO;

import java.util.List;

@Mapper
public interface AdminTranslationMapper {

    AdminTranslationSourceSnapshotVO selectLatestSourceSnapshot(@Param("sourceType") String sourceType,
                                                               @Param("sourceIdx") Long sourceIdx,
                                                               @Param("fieldName") String fieldName);

    void insertSourceSnapshot(AdminTranslationSourceSnapshotVO snapshot);

    List<AdminTranslationVO> selectTranslations(@Param("sourceType") String sourceType,
                                                @Param("sourceIdx") Long sourceIdx,
                                                @Param("fieldName") String fieldName);

    AdminTranslationVO selectTranslation(@Param("translationIdx") Long translationIdx);

    int countTranslationsByLangPair(@Param("sourceType") String sourceType,
                                    @Param("sourceIdx") Long sourceIdx,
                                    @Param("fieldName") String fieldName,
                                    @Param("sourceLang") String sourceLang,
                                    @Param("targetLang") String targetLang);

    int countPrimaryTranslationsByLangPair(@Param("sourceType") String sourceType,
                                           @Param("sourceIdx") Long sourceIdx,
                                           @Param("fieldName") String fieldName,
                                           @Param("sourceLang") String sourceLang,
                                           @Param("targetLang") String targetLang);

    void clearPrimaryByLangPair(@Param("sourceType") String sourceType,
                                @Param("sourceIdx") Long sourceIdx,
                                @Param("fieldName") String fieldName,
                                @Param("sourceLang") String sourceLang,
                                @Param("targetLang") String targetLang,
                                @Param("excludeTranslationIdx") Long excludeTranslationIdx,
                                @Param("updatedBy") Long updatedBy);

    void insertTranslation(AdminTranslationVO translation);

    void updateTranslationCurrentRevision(@Param("translationIdx") Long translationIdx,
                                          @Param("currentRevisionIdx") Long currentRevisionIdx,
                                          @Param("updatedBy") Long updatedBy);

    void updateTranslationMeta(@Param("translationIdx") Long translationIdx,
                               @Param("title") String title,
                               @Param("status") String status,
                               @Param("visibilityScope") String visibilityScope,
                               @Param("isPrimary") Boolean isPrimary,
                               @Param("updatedBy") Long updatedBy);

    int selectMaxVersionNo(@Param("translationIdx") Long translationIdx);

    void insertTranslationRevision(AdminTranslationRevisionVO revision);

    List<AdminTranslationRevisionVO> selectTranslationRevisions(@Param("translationIdx") Long translationIdx);

    AdminTranslationRevisionVO selectTranslationRevision(@Param("translationRevisionIdx") Long translationRevisionIdx);
}
