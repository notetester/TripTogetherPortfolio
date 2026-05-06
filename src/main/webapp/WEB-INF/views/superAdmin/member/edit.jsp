<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_ba28ca6ba7" code="superAdmin.member.edit.sub.titleUnset"/>
<spring:message var="autoMsg_4b25850d43" code="superAdmin.member.edit.sub.departmentUnset"/>
<spring:message var="autoMsg_b1df1f49ef" code="superAdmin.member.edit.menu.org"/>
<spring:message var="autoMsg_f20a531edb" code="superAdmin.member.edit.menu.job"/>
<spring:message var="autoMsg_0c2221c7ae" code="superAdmin.member.edit.menu.rank"/>
<spring:message var="autoMsg_b746dec9f7" code="superAdmin.member.edit.menu.skill"/>
<spring:message var="autoMsg_1fab5a24c3" code="superAdmin.member.edit.menu.salary"/>
<spring:message var="autoMsg_66c9da0dae" code="superAdmin.member.edit.menu.perm"/>
<spring:message var="autoMsg_3d3a23883c" code="superAdmin.member.edit.menu.manager"/>
<spring:message var="autoMsg_3d35e296b9" code="superAdmin.member.edit.button.basic"/>
<spring:message var="autoMsg_fd07777292" code="superAdmin.member.edit.button.advanced"/>
<spring:message var="autoMsg_f964fe71b0" code="superAdmin.member.edit.backToList"/>
<spring:message var="autoMsg_a922f7fc37" code="superAdmin.member.edit.section.org"/>
<spring:message var="autoMsg_8f12e2337c" code="superAdmin.member.edit.field.organization"/>
<spring:message var="autoMsg_8c22b4252d" code="superAdmin.member.edit.option.select"/>
<spring:message var="autoMsg_6c669189ac" code="superAdmin.member.edit.field.division"/>
<spring:message var="autoMsg_9b645e4d09" code="superAdmin.member.edit.field.department"/>
<spring:message var="autoMsg_af3c2eedfb" code="superAdmin.member.edit.field.unit"/>
<spring:message var="autoMsg_ed86538573" code="superAdmin.member.edit.field.team"/>
<spring:message var="autoMsg_7ffddcce4c" code="superAdmin.member.edit.field.location"/>
<spring:message var="autoMsg_48396974b6" code="superAdmin.member.edit.button.save"/>
<spring:message var="autoMsg_d170308fef" code="superAdmin.member.edit.section.job"/>
<spring:message var="autoMsg_0302f8dd25" code="superAdmin.member.edit.field.track"/>
<spring:message var="autoMsg_60b98a5cd9" code="superAdmin.member.edit.field.family"/>
<spring:message var="autoMsg_7ae3287968" code="superAdmin.member.edit.field.function"/>
<spring:message var="autoMsg_66d2a9124e" code="superAdmin.member.edit.field.detailDiscipline"/>
<spring:message var="autoMsg_dba46ce81b" code="superAdmin.member.edit.field.role"/>
<spring:message var="autoMsg_b53714584b" code="superAdmin.member.edit.section.rank"/>
<spring:message var="autoMsg_2f93d14c15" code="superAdmin.member.edit.field.positionCode"/>
<spring:message var="autoMsg_4f11c2ec1c" code="superAdmin.member.edit.field.position"/>
<spring:message var="autoMsg_991ade4e40" code="superAdmin.member.edit.field.title"/>
<spring:message var="autoMsg_46117b392f" code="superAdmin.member.edit.field.rank"/>
<spring:message var="autoMsg_130fe5c4d1" code="superAdmin.member.edit.section.skill"/>
<spring:message var="autoMsg_c96b38c472" code="superAdmin.member.edit.field.seniority"/>
<spring:message var="autoMsg_4853beb3a6" code="superAdmin.member.edit.field.tier"/>
<spring:message var="autoMsg_2bcf705ca7" code="superAdmin.member.edit.field.level"/>
<spring:message var="autoMsg_f620f17cfa" code="superAdmin.member.edit.section.salary"/>
<spring:message var="autoMsg_311fd3e8df" code="superAdmin.member.edit.field.band"/>
<spring:message var="autoMsg_923489fd7c" code="superAdmin.member.edit.field.grade"/>
<spring:message var="autoMsg_9747e91f67" code="superAdmin.member.edit.field.step"/>
<spring:message var="autoMsg_5e08f5a019" code="superAdmin.member.edit.section.perm"/>
<spring:message var="autoMsg_b58e945288" code="superAdmin.member.edit.field.responsibility"/>
<spring:message var="autoMsg_53ad829ba4" code="superAdmin.member.edit.placeholder.responsibility"/>
<spring:message var="autoMsg_7bc3823c03" code="superAdmin.member.edit.field.permissionDescription"/>
<spring:message var="autoMsg_f04da62376" code="superAdmin.member.edit.placeholder.permissionDescription"/>
<spring:message var="autoMsg_fb36b78b2e" code="superAdmin.member.edit.field.effectivePermissionCode"/>
<spring:message var="autoMsg_ae6171f77a" code="superAdmin.member.edit.field.groupApply"/>
<spring:message var="autoMsg_86e04a2a13" code="superAdmin.member.edit.option.selectGroup"/>
<spring:message var="autoMsg_749890b579" code="superAdmin.member.edit.button.apply"/>
<spring:message var="autoMsg_abded50050" code="superAdmin.member.edit.hint.groupApply"/>
<spring:message var="autoMsg_522df1794c" code="superAdmin.member.edit.section.manager"/>
<spring:message var="autoMsg_7da300eb43" code="superAdmin.member.edit.field.manager"/>
<spring:message var="autoMsg_84aa19ebb2" code="superAdmin.member.edit.option.none"/>
<spring:message var="autoMsg_7dc52c697f" code="superAdmin.member.edit.toast.saved" javaScriptEscape="true"/>
<spring:message var="autoMsg_890b28cd03" code="superAdmin.member.edit.toast.saveFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_e003e8fe0b" code="superAdmin.member.edit.toast.saveError" javaScriptEscape="true"/>
<spring:message var="autoMsg_17dc9ed9de" code="superAdmin.member.edit.toast.groupRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_55eed53829" code="superAdmin.member.edit.confirm.applyGroup" javaScriptEscape="true"/>
<spring:message var="autoMsg_d81d6e5df1" code="superAdmin.member.edit.toast.groupEmpty" javaScriptEscape="true"/>
<spring:message var="autoMsg_990596287e" code="superAdmin.member.edit.toast.groupApplied" javaScriptEscape="true"/>
<spring:message var="autoMsg_48ce2abc62" code="superAdmin.member.edit.toast.applyFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_ba4bba5dd4" code="superAdmin.member.edit.toast.error" javaScriptEscape="true"/>
<c:set var="activeMenu" value="members"/>
<spring:message code="superAdmin.member.edit.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content" style="padding:0;">
    <div class="sa-profile-wrap">

        <%-- ── 왼쪽 네비게이션 ── --%>
        <aside class="sa-profile-nav">

            <%-- 프로필 헤더 --%>
            <div class="sa-profile-avatar-wrap">
                <div class="sa-profile-avatar">
                    <c:choose>
                        <c:when test="${not empty member.nickname}">${fn:substring(member.nickname, 0, 1)}</c:when>
                        <c:otherwise>?</c:otherwise>
                    </c:choose>
                </div>
                <div class="sa-profile-name">${fn:escapeXml(member.nickname)}</div>
                <div class="sa-profile-sub">
                    <c:choose>
                        <c:when test="${not empty member.adminTitle}">${fn:escapeXml(member.adminTitle)}</c:when>
                        <c:otherwise>${autoMsg_ba28ca6ba7}</c:otherwise>
                    </c:choose>
                </div>
                <div class="sa-profile-sub" style="margin-top:2px;">
                    <c:choose>
                        <c:when test="${not empty member.adminDepartment}">${fn:escapeXml(member.adminDepartment)}</c:when>
                        <c:otherwise>${autoMsg_4b25850d43}</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <%-- 섹션 메뉴 --%>
            <nav class="sa-profile-menu">
                <a class="sa-profile-menu-item active" data-section="org"     onclick="showSection('org',this)">${autoMsg_b1df1f49ef}</a>
                <a class="sa-profile-menu-item"        data-section="job"     onclick="showSection('job',this)">${autoMsg_f20a531edb}</a>
                <a class="sa-profile-menu-item"        data-section="rank"    onclick="showSection('rank',this)">${autoMsg_0c2221c7ae}</a>
                <a class="sa-profile-menu-item"        data-section="skill"   onclick="showSection('skill',this)">${autoMsg_b746dec9f7}</a>
                <a class="sa-profile-menu-item"        data-section="salary"  onclick="showSection('salary',this)">${autoMsg_1fab5a24c3}</a>
                <a class="sa-profile-menu-item"        data-section="perm"    onclick="showSection('perm',this)">${autoMsg_66c9da0dae}</a>
                <a class="sa-profile-menu-item"        data-section="manager" onclick="showSection('manager',this)">${autoMsg_3d3a23883c}</a>
            </nav>

            <div class="sa-mode-toggle-wrap">
                <div class="sa-mode-toggle">
                    <button id="btn-basic"    class="active" onclick="setMode('basic')">${autoMsg_3d35e296b9}</button>
                    <button id="btn-advanced"             onclick="setMode('advanced')">${autoMsg_fd07777292}</button>
                </div>
            </div>

            <div style="padding:16px;">
                <a href="${pageContext.request.contextPath}/superAdmin/members"
                   class="adm-btn adm-btn-ghost" style="width:100%;text-align:center;">${autoMsg_f964fe71b0}</a>
            </div>
        </aside>

        <%-- ── 오른쪽 콘텐츠 ── --%>
        <div class="sa-profile-content" id="sa-profile-content">

            <%-- 조직 정보 --%>
            <section class="sa-profile-section active" id="sec-org">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">${autoMsg_a922f7fc37}</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_8f12e2337c}</label>
                            <select class="adm-select sa-full-select" name="adminOrganization" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <option value="TripTogether Corp." ${member.adminOrganization == 'TripTogether Corp.' ? 'selected' : ''}>
                                    <spring:message code="superAdmin.member.edit.option.organization.0" text="TripTogether Corp."/>
                                </option>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_6c669189ac}</label>
                            <select class="adm-select sa-full-select" name="adminDivision" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['서비스본부','플랫폼본부','데이터본부','경영지원본부','연구개발본부','보안본부']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.division.${s.index}"/>
                                    <option value="${o}" ${member.adminDivision == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">${autoMsg_9b645e4d09}</label>
                            <select class="adm-select sa-full-select" name="adminDepartment" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['커뮤니티운영팀','여행서비스팀','고객지원팀','플랫폼개발팀','인프라팀','AI팀','마케팅팀','재무팀','인사팀','법무팀','사업개발팀','보안팀','개인정보보호팀']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.department.${s.index}"/>
                                    <option value="${o}" ${member.adminDepartment == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_af3c2eedfb}</label>
                            <select class="adm-select sa-full-select" name="adminUnit" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['콘텐츠유닛','신뢰안전유닛','결제유닛','검색유닛']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.unit.${s.index}"/>
                                    <option value="${o}" ${member.adminUnit == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">${autoMsg_ed86538573}</label>
                            <select class="adm-select sa-full-select" name="adminTeam" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['프론트팀','백엔드팀','QA팀','데이터팀','디자인팀','기획팀']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.team.${s.index}"/>
                                    <option value="${o}" ${member.adminTeam == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_7ffddcce4c}</label>
                            <select class="adm-select sa-full-select" name="adminLocation" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['서울 본사','부산 지사','제주 지사','원격근무']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.location.${s.index}"/>
                                    <option value="${o}" ${member.adminLocation == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">${autoMsg_48396974b6}</button>
                </div>
            </section>

            <%-- 직무 정보 --%>
            <section class="sa-profile-section" id="sec-job">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">${autoMsg_d170308fef}</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_0302f8dd25}</label>
                            <select class="adm-select sa-full-select" name="adminTrack" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['기술직','운영직','경영직','디자인직','기획직']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.track.${s.index}"/>
                                    <option value="${o}" ${member.adminTrack == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_60b98a5cd9}</label>
                            <select class="adm-select sa-full-select" name="adminFamily" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['백엔드','프론트엔드','모바일','데브옵스','데이터','인공지능','보안','품질보증','커뮤니티','고객지원','마케팅','재무','인사','법무','제품기획','사업개발','영업']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.family.${s.index}"/>
                                    <option value="${o}" ${member.adminFamily == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_7ae3287968}</label>
                            <select class="adm-select sa-full-select" name="adminFunction" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['개발','운영','기획','분석','디자인','관리','영업','연구']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.function.${s.index}"/>
                                    <option value="${o}" ${member.adminFunction == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_66d2a9124e}</label>
                            <select class="adm-select sa-full-select" name="adminDiscipline" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['웹개발','앱개발','서버관리','데이터분석','UX디자인','콘텐츠','회계','보안관리','네트워크','제품기획']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.discipline.${s.index}"/>
                                    <option value="${o}" ${member.adminDiscipline == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">${autoMsg_dba46ce81b}</label>
                            <select class="adm-select sa-full-select" name="adminRole" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['엔지니어','매니저','분석가','디자이너','전문가','코디네이터','디렉터','기획자','사업개발자']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.role.${s.index}"/>
                                    <option value="${o}" ${member.adminRole == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">${autoMsg_48396974b6}</button>
                </div>
            </section>

            <%-- 직급/직책 --%>
            <section class="sa-profile-section" id="sec-rank">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">${autoMsg_b53714584b}</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_2f93d14c15}</label>
                            <select class="adm-select sa-full-select" name="adminPositionCode" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="p" items="${positionPolicies}">
                                    <option value="${fn:escapeXml(p.adminPositionCode)}" ${member.adminPositionCode == p.adminPositionCode ? 'selected':''}>
                                        ${fn:escapeXml(p.displayName)} (${fn:escapeXml(p.adminPositionCode)})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">${autoMsg_4f11c2ec1c}</label>
                            <select class="adm-select sa-full-select" name="adminPosition" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['사원','선임','책임','수석','주임','대리','과장','차장','부장','이사','상무','전무','부사장','사장','회장']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.position.${s.index}"/>
                                    <option value="${o}" ${member.adminPosition == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">${autoMsg_991ade4e40}</label>
                            <select class="adm-select sa-full-select" name="adminTitle" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['주니어 엔지니어','엔지니어','시니어 엔지니어','리드 엔지니어','수석 엔지니어','스태프 엔지니어','펠로우 엔지니어','매니저','시니어 매니저','디렉터','시니어 디렉터','부문장','그룹장','사업부장','대표이사','최고기술책임자(CTO)','최고제품책임자(CPO)','최고운영책임자(COO)','최고재무책임자(CFO)']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.title.${s.index}"/>
                                    <option value="${o}" ${member.adminTitle == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_46117b392f}</label>
                            <select class="adm-select sa-full-select" name="adminRank" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['IC1','IC2','IC3','IC4','IC5','IC6','IC7','M1','M2','M3','M4','M5']}">
                                    <option value="${o}" ${member.adminRank == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">${autoMsg_48396974b6}</button>
                </div>
            </section>

            <%-- 역량/평가 --%>
            <section class="sa-profile-section" id="sec-skill">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">${autoMsg_130fe5c4d1}</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group">
                            <label class="sa-form-label">${autoMsg_c96b38c472}</label>
                            <select class="adm-select sa-full-select" name="adminSeniority" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['어소시에이트','주니어','미드레벨','시니어','리드','프린시펄','스태프','펠로우']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.seniority.${s.index}"/>
                                    <option value="${o}" ${member.adminSeniority == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_4853beb3a6}</label>
                            <select class="adm-select sa-full-select" name="adminTier" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['T1','T2','T3','T4','T5']}">
                                    <option value="${o}" ${member.adminTier == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_2bcf705ca7}</label>
                            <select class="adm-select sa-full-select" name="adminLevel" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['L1','L2','L3','L4','L5','L6','L7']}">
                                    <option value="${o}" ${member.adminLevel == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">${autoMsg_48396974b6}</button>
                </div>
            </section>

            <%-- 급여 --%>
            <section class="sa-profile-section" id="sec-salary">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">${autoMsg_f620f17cfa}</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group">
                            <label class="sa-form-label">${autoMsg_311fd3e8df}</label>
                            <select class="adm-select sa-full-select" name="adminBand" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['B1','B2','B3','B4','B5','B6','B7','B8','B9','B10']}">
                                    <option value="${o}" ${member.adminBand == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">${autoMsg_923489fd7c}</label>
                            <select class="adm-select sa-full-select" name="adminGrade" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['G1','G2','G3','G4','G5','G6','G7','G8','G9','G10']}">
                                    <option value="${o}" ${member.adminGrade == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group sa-adv">
                            <label class="sa-form-label">${autoMsg_9747e91f67}</label>
                            <select class="adm-select sa-full-select" name="adminStep" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="o" items="${['1호봉','2호봉','3호봉','4호봉','5호봉','6호봉','7호봉','8호봉','9호봉','10호봉','11호봉','12호봉','13호봉','14호봉','15호봉']}" varStatus="s">
                                    <c:set var="labelCode" value="superAdmin.member.edit.option.step.${s.index}"/>
                                    <option value="${o}" ${member.adminStep == o ? 'selected':''}>
                                        <spring:message code="${labelCode}" text="${o}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">${autoMsg_48396974b6}</button>
                </div>
            </section>

            <%-- 권한/책임 --%>
            <section class="sa-profile-section" id="sec-perm">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">${autoMsg_5e08f5a019}</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group" style="grid-column:1/-1;">
                            <label class="sa-form-label">${autoMsg_b58e945288}</label>
                            <input class="adm-input" type="text" name="adminResponsibility" form="editForm"
                                   value="${fn:escapeXml(member.adminResponsibility)}"
                                   placeholder="${autoMsg_53ad829ba4}">
                        </div>
                        <div class="sa-form-group" style="grid-column:1/-1;">
                            <label class="sa-form-label">${autoMsg_7bc3823c03}</label>
                            <input class="adm-input" type="text" name="adminPermission" form="editForm"
                                   value="${fn:escapeXml(member.adminPermission)}"
                                   placeholder="${autoMsg_f04da62376}">
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">${autoMsg_fb36b78b2e}</label>
                            <select class="adm-select sa-full-select" name="adminPermissionCode" form="editForm">
                                <option value="">${autoMsg_8c22b4252d}</option>
                                <c:forEach var="pc" items="${permissionCodePolicies}">
                                    <option value="${fn:escapeXml(pc.adminPermissionCode)}"
                                        ${member.adminPermissionCode == pc.adminPermissionCode ? 'selected':''}>
                                        ${fn:escapeXml(pc.displayName)} (${fn:escapeXml(pc.adminPermissionCode)})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <c:if test="${not empty groupList}">
                        <div class="sa-form-group" style="grid-column:1/-1;">
                            <label class="sa-form-label">${autoMsg_ae6171f77a}</label>
                            <div style="display:flex;gap:8px;">
                                <select class="adm-select" id="editGroupApplySelect" style="flex:1;">
                                    <option value="">${autoMsg_86e04a2a13}</option>
                                    <c:forEach var="g" items="${groupList}">
                                        <c:if test="${g.active}">
                                            <option value="${fn:escapeXml(g.groupCode)}">${fn:escapeXml(g.displayName)}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                                <button class="adm-btn adm-btn-ghost" type="button" onclick="applyGroupPerms()">${autoMsg_749890b579}</button>
                            </div>
                            <div style="font-size:12px;color:#94a3b8;margin-top:4px;">${autoMsg_abded50050}</div>
                        </div>
                        </c:if>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">${autoMsg_48396974b6}</button>
                </div>
            </section>

            <%-- 상급자 --%>
            <section class="sa-profile-section" id="sec-manager">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">${autoMsg_522df1794c}</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid" style="max-width:400px;">
                        <div class="sa-form-group" style="grid-column:1/-1;">
                            <label class="sa-form-label">${autoMsg_7da300eb43}</label>
                            <select class="adm-select sa-full-select" name="adminManager" form="editForm">
                                <option value="">${autoMsg_84aa19ebb2}</option>
                                <c:forEach var="a" items="${allAdmins}">
                                    <c:if test="${a.userIdx != member.userIdx}">
                                        <option value="${a.userIdx}" ${member.adminManager == a.userIdx ? 'selected':''}>
                                            ${fn:escapeXml(a.nickname)}<c:if test="${not empty a.adminTitle}"> (${fn:escapeXml(a.adminTitle)})</c:if>
                                        </option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">${autoMsg_48396974b6}</button>
                </div>
            </section>

        </div><%-- /.sa-profile-content --%>
    </div><%-- /.sa-profile-wrap --%>
</div>

<%-- 숨겨진 폼 (전체 필드 포함 - 저장 시 모든 값 전달) --%>
<form id="editForm" style="display:none;"></form>

<script>
var CTX_EDIT = '${pageContext.request.contextPath}';
var MEMBER_IDX = '${member.userIdx}';
var MEMBER_EDIT_MESSAGES = {
    saved: '${autoMsg_7dc52c697f}',
    saveFailed: '${autoMsg_890b28cd03}',
    saveError: '${autoMsg_e003e8fe0b}',
    groupRequired: '${autoMsg_17dc9ed9de}',
    confirmApplyGroup: '${autoMsg_55eed53829}',
    groupEmpty: '${autoMsg_d81d6e5df1}',
    groupApplied: '${autoMsg_990596287e}',
    applyFailed: '${autoMsg_48ce2abc62}',
    error: '${autoMsg_ba4bba5dd4}'
};

function formatMemberEditMessage(template) {
    var args = Array.prototype.slice.call(arguments, 1);
    return template.replace(/\u007B(\d+)\u007D/g, function(_, idx) {
        return args[idx] !== undefined ? args[idx] : '';
    });
}

function setMode(mode) {
    var content = document.getElementById('sa-profile-content');
    if (mode === 'advanced') {
        content.classList.add('sa-mode-advanced');
    } else {
        content.classList.remove('sa-mode-advanced');
    }
    document.getElementById('btn-basic').classList.toggle('active', mode === 'basic');
    document.getElementById('btn-advanced').classList.toggle('active', mode === 'advanced');
}


function showSection(key, el) {
    document.querySelectorAll('.sa-profile-section').forEach(function(s) { s.classList.remove('active'); });
    document.querySelectorAll('.sa-profile-menu-item').forEach(function(a) { a.classList.remove('active'); });
    document.getElementById('sec-' + key).classList.add('active');
    el.classList.add('active');
}

function saveSection() {
    var form   = document.getElementById('editForm');
    var params = new URLSearchParams(new FormData(form));
    fetch(CTX_EDIT + '/superAdmin/members/' + MEMBER_IDX + '/edit', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(function(r) { return r.json(); })
    .then(function(data) {
        if (data.success) { adm_toast(MEMBER_EDIT_MESSAGES.saved); }
        else              { adm_toast(data.message || MEMBER_EDIT_MESSAGES.saveFailed, 'error'); }
    })
    .catch(function() { adm_toast(MEMBER_EDIT_MESSAGES.saveError, 'error'); });
}

function applyGroupPerms() {
    var sel = document.getElementById('editGroupApplySelect');
    if (!sel || !sel.value) { adm_toast(MEMBER_EDIT_MESSAGES.groupRequired, 'error'); return; }
    var groupName = sel.options[sel.selectedIndex].text;
    if (!confirm(formatMemberEditMessage(MEMBER_EDIT_MESSAGES.confirmApplyGroup, groupName))) return;

    fetch(CTX_EDIT + '/superAdmin/groups/' + encodeURIComponent(sel.value))
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (!data.items || data.items.length === 0) { adm_toast(MEMBER_EDIT_MESSAGES.groupEmpty, 'error'); return; }
            var params = new URLSearchParams();
            data.items.forEach(function(i) { params.append('permissionCodes', i.permissionCode); });
            return fetch(CTX_EDIT + '/superAdmin/members/' + MEMBER_IDX + '/permissions', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
                body: params.toString()
            });
        })
        .then(function(r) { return r ? r.json() : null; })
        .then(function(data) {
            if (data && data.success) adm_toast(MEMBER_EDIT_MESSAGES.groupApplied);
            else if (data) adm_toast(data.message || MEMBER_EDIT_MESSAGES.applyFailed, 'error');
        })
        .catch(function() { adm_toast(MEMBER_EDIT_MESSAGES.error, 'error'); });
}
</script>

<%@ include file="../layout-close.jsp" %>
