package org.triptogether.admin.service;

import org.triptogether.admin.vo.*;

import java.util.List;

public interface AdminTranslationService {

    List<AdminTranslationVO> getTranslations(String sourceType,
                                             Long sourceIdx,
                                             String fieldName,
                                             String sourceText);

    AdminTranslationVO createTranslation(AdminTranslationCreateRequest request, Long actorUserIdx);

    AdminTranslationVO createRevision(Long translationIdx,
                                      AdminTranslationRevisionCreateRequest request,
                                      Long actorUserIdx);

    AdminTranslationVO restoreRevision(Long translationIdx,
                                       Long revisionIdx,
                                       Long actorUserIdx);
}
