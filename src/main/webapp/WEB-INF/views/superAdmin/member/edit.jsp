<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="members"/>
<c:set var="pageTitle"  value="관리자 편집"/>
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
                        <c:otherwise>직함 미설정</c:otherwise>
                    </c:choose>
                </div>
                <div class="sa-profile-sub" style="margin-top:2px;">
                    <c:choose>
                        <c:when test="${not empty member.adminDepartment}">${fn:escapeXml(member.adminDepartment)}</c:when>
                        <c:otherwise>부서 미설정</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <%-- 섹션 메뉴 --%>
            <nav class="sa-profile-menu">
                <a class="sa-profile-menu-item active" data-section="org"     onclick="showSection('org',this)">조직 정보</a>
                <a class="sa-profile-menu-item"        data-section="job"     onclick="showSection('job',this)">직무 정보</a>
                <a class="sa-profile-menu-item"        data-section="rank"    onclick="showSection('rank',this)">직급 / 직책</a>
                <a class="sa-profile-menu-item"        data-section="skill"   onclick="showSection('skill',this)">역량 / 평가</a>
                <a class="sa-profile-menu-item"        data-section="salary"  onclick="showSection('salary',this)">급여</a>
                <a class="sa-profile-menu-item"        data-section="perm"    onclick="showSection('perm',this)">권한 / 책임</a>
                <a class="sa-profile-menu-item"        data-section="manager" onclick="showSection('manager',this)">상급자</a>
            </nav>

            <div style="padding:16px;">
                <a href="${pageContext.request.contextPath}/superAdmin/members"
                   class="adm-btn adm-btn-ghost" style="width:100%;text-align:center;">← 목록으로</a>
            </div>
        </aside>

        <%-- ── 오른쪽 콘텐츠 ── --%>
        <div class="sa-profile-content">

            <%-- 조직 정보 --%>
            <section class="sa-profile-section active" id="sec-org">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">조직 정보</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group">
                            <label class="sa-form-label">소속 조직</label>
                            <select class="adm-select sa-full-select" name="adminOrganization" form="editForm">
                                <option value="">-- 선택 --</option>
                                <option value="TripTogether Corp." ${member.adminOrganization == 'TripTogether Corp.' ? 'selected' : ''}>TripTogether Corp.</option>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">본부</label>
                            <select class="adm-select sa-full-select" name="adminDivision" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['서비스본부','플랫폼본부','데이터본부','경영지원본부','연구개발본부','보안본부']}">
                                    <option value="${o}" ${member.adminDivision == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">부서</label>
                            <select class="adm-select sa-full-select" name="adminDepartment" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['커뮤니티운영팀','여행서비스팀','고객지원팀','플랫폼개발팀','인프라팀','AI팀','마케팅팀','재무팀','인사팀','법무팀','사업개발팀','보안팀','개인정보보호팀']}">
                                    <option value="${o}" ${member.adminDepartment == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">유닛</label>
                            <select class="adm-select sa-full-select" name="adminUnit" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['콘텐츠유닛','신뢰안전유닛','결제유닛','검색유닛']}">
                                    <option value="${o}" ${member.adminUnit == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">팀</label>
                            <select class="adm-select sa-full-select" name="adminTeam" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['프론트팀','백엔드팀','QA팀','데이터팀','디자인팀','기획팀']}">
                                    <option value="${o}" ${member.adminTeam == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">근무지</label>
                            <select class="adm-select sa-full-select" name="adminLocation" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['서울 본사','부산 지사','제주 지사','원격근무']}">
                                    <option value="${o}" ${member.adminLocation == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">저장</button>
                </div>
            </section>

            <%-- 직무 정보 --%>
            <section class="sa-profile-section" id="sec-job">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">직무 정보</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group">
                            <label class="sa-form-label">직무경로 (Track)</label>
                            <select class="adm-select sa-full-select" name="adminTrack" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['기술직','운영직','경영직','디자인직','기획직']}">
                                    <option value="${o}" ${member.adminTrack == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">직무계열 (Family)</label>
                            <select class="adm-select sa-full-select" name="adminFamily" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['백엔드','프론트엔드','모바일','데브옵스','데이터','인공지능','보안','품질보증','커뮤니티','고객지원','마케팅','재무','인사','법무','제품기획','사업개발','영업']}">
                                    <option value="${o}" ${member.adminFamily == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">직무기능군 (Function)</label>
                            <select class="adm-select sa-full-select" name="adminFunction" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['개발','운영','기획','분석','디자인','관리','영업','연구']}">
                                    <option value="${o}" ${member.adminFunction == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">세부분야 (Discipline)</label>
                            <select class="adm-select sa-full-select" name="adminDiscipline" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['웹개발','앱개발','서버관리','데이터분석','UX디자인','콘텐츠','회계','보안관리','네트워크','제품기획']}">
                                    <option value="${o}" ${member.adminDiscipline == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">직무역할 (Role)</label>
                            <select class="adm-select sa-full-select" name="adminRole" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['엔지니어','매니저','분석가','디자이너','전문가','코디네이터','디렉터','기획자','사업개발자']}">
                                    <option value="${o}" ${member.adminRole == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">저장</button>
                </div>
            </section>

            <%-- 직급/직책 --%>
            <section class="sa-profile-section" id="sec-rank">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">직급 / 직책</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group">
                            <label class="sa-form-label">직책 코드</label>
                            <select class="adm-select sa-full-select" name="adminPositionCode" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="p" items="${positionPolicies}">
                                    <option value="${fn:escapeXml(p.adminPositionCode)}" ${member.adminPositionCode == p.adminPositionCode ? 'selected':''}>
                                        ${fn:escapeXml(p.displayName)} (${fn:escapeXml(p.adminPositionCode)})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">직위 (Position)</label>
                            <select class="adm-select sa-full-select" name="adminPosition" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['사원','선임','책임','수석','주임','대리','과장','차장','부장','이사','상무','전무','부사장','사장','회장']}">
                                    <option value="${o}" ${member.adminPosition == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">직함 (Title)</label>
                            <select class="adm-select sa-full-select" name="adminTitle" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['주니어 엔지니어','엔지니어','시니어 엔지니어','리드 엔지니어','수석 엔지니어','스태프 엔지니어','펠로우 엔지니어','매니저','시니어 매니저','디렉터','시니어 디렉터','부문장','그룹장','사업부장','대표이사','최고기술책임자(CTO)','최고제품책임자(CPO)','최고운영책임자(COO)','최고재무책임자(CFO)']}">
                                    <option value="${o}" ${member.adminTitle == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">조직내서열 (Rank)</label>
                            <select class="adm-select sa-full-select" name="adminRank" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['IC1','IC2','IC3','IC4','IC5','IC6','IC7','M1','M2','M3','M4','M5']}">
                                    <option value="${o}" ${member.adminRank == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">저장</button>
                </div>
            </section>

            <%-- 역량/평가 --%>
            <section class="sa-profile-section" id="sec-skill">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">역량 / 평가</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group">
                            <label class="sa-form-label">숙련도 (Seniority)</label>
                            <select class="adm-select sa-full-select" name="adminSeniority" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['어소시에이트','주니어','미드레벨','시니어','리드','프린시펄','스태프','펠로우']}">
                                    <option value="${o}" ${member.adminSeniority == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">직무티어 (Tier)</label>
                            <select class="adm-select sa-full-select" name="adminTier" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['T1','T2','T3','T4','T5']}">
                                    <option value="${o}" ${member.adminTier == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">직무단계 (Level)</label>
                            <select class="adm-select sa-full-select" name="adminLevel" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['L1','L2','L3','L4','L5','L6','L7']}">
                                    <option value="${o}" ${member.adminLevel == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">저장</button>
                </div>
            </section>

            <%-- 급여 --%>
            <section class="sa-profile-section" id="sec-salary">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">급여</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group">
                            <label class="sa-form-label">급여구간 (Band)</label>
                            <select class="adm-select sa-full-select" name="adminBand" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['B1','B2','B3','B4','B5','B6','B7','B8','B9','B10']}">
                                    <option value="${o}" ${member.adminBand == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">급여등급 (Grade)</label>
                            <select class="adm-select sa-full-select" name="adminGrade" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['G1','G2','G3','G4','G5','G6','G7','G8','G9','G10']}">
                                    <option value="${o}" ${member.adminGrade == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">호봉 (Step)</label>
                            <select class="adm-select sa-full-select" name="adminStep" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="o" items="${['1호봉','2호봉','3호봉','4호봉','5호봉','6호봉','7호봉','8호봉','9호봉','10호봉','11호봉','12호봉','13호봉','14호봉','15호봉']}">
                                    <option value="${o}" ${member.adminStep == o ? 'selected':''}>${o}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">저장</button>
                </div>
            </section>

            <%-- 권한/책임 --%>
            <section class="sa-profile-section" id="sec-perm">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">권한 / 책임</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid">
                        <div class="sa-form-group" style="grid-column:1/-1;">
                            <label class="sa-form-label">책임 업무 범위</label>
                            <input class="adm-input" type="text" name="adminResponsibility" form="editForm"
                                   value="${fn:escapeXml(member.adminResponsibility)}"
                                   placeholder="예: 커뮤니티 게시물 운영 전반">
                        </div>
                        <div class="sa-form-group" style="grid-column:1/-1;">
                            <label class="sa-form-label">적용 권한 설명</label>
                            <input class="adm-input" type="text" name="adminPermission" form="editForm"
                                   value="${fn:escapeXml(member.adminPermission)}"
                                   placeholder="예: 게시물 삭제·복구, 회원 제재">
                        </div>
                        <div class="sa-form-group">
                            <label class="sa-form-label">실효 권한 코드</label>
                            <select class="adm-select sa-full-select" name="adminPermissionCode" form="editForm">
                                <option value="">-- 선택 --</option>
                                <c:forEach var="pc" items="${permissionCodePolicies}">
                                    <option value="${fn:escapeXml(pc.adminPermissionCode)}"
                                        ${member.adminPermissionCode == pc.adminPermissionCode ? 'selected':''}>
                                        ${fn:escapeXml(pc.displayName)} (${fn:escapeXml(pc.adminPermissionCode)})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="sa-profile-section-foot">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">저장</button>
                </div>
            </section>

            <%-- 상급자 --%>
            <section class="sa-profile-section" id="sec-manager">
                <div class="sa-profile-section-head">
                    <div class="sa-profile-section-title">상급자</div>
                </div>
                <div class="sa-profile-section-body">
                    <div class="sa-form-grid" style="max-width:400px;">
                        <div class="sa-form-group" style="grid-column:1/-1;">
                            <label class="sa-form-label">상급자 선택</label>
                            <select class="adm-select sa-full-select" name="adminManager" form="editForm">
                                <option value="">-- 없음 --</option>
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
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveSection()">저장</button>
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
        if (data.success) { adm_toast('저장되었습니다.'); }
        else              { adm_toast(data.message || '저장 실패', 'error'); }
    })
    .catch(function() { adm_toast('저장 중 오류가 발생했습니다.', 'error'); });
}
</script>

<%@ include file="../layout-close.jsp" %>
