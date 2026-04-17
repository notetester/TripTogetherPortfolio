<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activeMenu" value="members"/>
<c:set var="pageTitle"  value="${member.nickname} 정보 편집"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="${pageContext.request.contextPath}/superAdmin/members" class="adm-btn adm-btn-ghost">← 목록으로</a>
    </div>

    <form id="editForm">

        <%-- ══════════════════ 조직 정보 ══════════════════ --%>
        <div class="adm-card" style="margin-bottom:20px;">
            <div class="adm-card-head"><div class="adm-card-title">조직 정보</div></div>
            <div class="adm-card-body">
                <div class="sa-form-grid">
                    <div class="sa-form-group">
                        <label class="sa-form-label">소속 조직</label>
                        <input class="adm-input" type="text" name="adminOrganization" value="${member.adminOrganization}" placeholder="예: TripTogether Corp.">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">본부</label>
                        <input class="adm-input" type="text" name="adminDivision" value="${member.adminDivision}" placeholder="예: 서비스본부">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">부서</label>
                        <input class="adm-input" type="text" name="adminDepartment" value="${member.adminDepartment}" placeholder="예: 커뮤니티운영팀">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">유닛</label>
                        <input class="adm-input" type="text" name="adminUnit" value="${member.adminUnit}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">팀</label>
                        <input class="adm-input" type="text" name="adminTeam" value="${member.adminTeam}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">지사</label>
                        <input class="adm-input" type="text" name="adminLocation" value="${member.adminLocation}">
                    </div>
                </div>
            </div>
        </div>

        <%-- ══════════════════ 직무 정보 ══════════════════ --%>
        <div class="adm-card" style="margin-bottom:20px;">
            <div class="adm-card-head"><div class="adm-card-title">직무 정보</div></div>
            <div class="adm-card-body">
                <div class="sa-form-grid">
                    <div class="sa-form-group">
                        <label class="sa-form-label">직무 경로 (Track)</label>
                        <input class="adm-input" type="text" name="adminTrack" value="${member.adminTrack}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">직무 계열 (Family)</label>
                        <input class="adm-input" type="text" name="adminFamily" value="${member.adminFamily}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">직무 기능군 (Function)</label>
                        <input class="adm-input" type="text" name="adminFunction" value="${member.adminFunction}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">세부 분야 (Discipline)</label>
                        <input class="adm-input" type="text" name="adminDiscipline" value="${member.adminDiscipline}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">직무 역할 (Role)</label>
                        <input class="adm-input" type="text" name="adminRole" value="${member.adminRole}">
                    </div>
                </div>
            </div>
        </div>

        <%-- ══════════════════ 직급/직책 ══════════════════ --%>
        <div class="adm-card" style="margin-bottom:20px;">
            <div class="adm-card-head"><div class="adm-card-title">직급 / 직책</div></div>
            <div class="adm-card-body">
                <div class="sa-form-grid">
                    <div class="sa-form-group">
                        <label class="sa-form-label">직책 코드</label>
                        <select class="adm-select" name="adminPositionCode" style="width:100%;">
                            <option value="">-- 선택 --</option>
                            <c:forEach var="p" items="${positionPolicies}">
                                <option value="${p.adminPositionCode}"
                                    ${member.adminPositionCode == p.adminPositionCode ? 'selected' : ''}>
                                    ${p.displayName} (${p.adminPositionCode})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">직책명 (Position)</label>
                        <input class="adm-input" type="text" name="adminPosition" value="${member.adminPosition}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">대외 공식 직함 (Title)</label>
                        <input class="adm-input" type="text" name="adminTitle" value="${member.adminTitle}" placeholder="예: Senior Community Manager">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">조직 내 서열 (Rank)</label>
                        <input class="adm-input" type="text" name="adminRank" value="${member.adminRank}">
                    </div>
                </div>
            </div>
        </div>

        <%-- ══════════════════ 역량/평가 ══════════════════ --%>
        <div class="adm-card" style="margin-bottom:20px;">
            <div class="adm-card-head"><div class="adm-card-title">역량 / 평가</div></div>
            <div class="adm-card-body">
                <div class="sa-form-grid">
                    <div class="sa-form-group">
                        <label class="sa-form-label">숙련도 (Seniority)</label>
                        <input class="adm-input" type="text" name="adminSeniority" value="${member.adminSeniority}" placeholder="예: Junior / Senior">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">직무 티어 (Tier)</label>
                        <input class="adm-input" type="text" name="adminTier" value="${member.adminTier}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">직무 단계 (Level)</label>
                        <input class="adm-input" type="text" name="adminLevel" value="${member.adminLevel}">
                    </div>
                </div>
            </div>
        </div>

        <%-- ══════════════════ 급여 ══════════════════ --%>
        <div class="adm-card" style="margin-bottom:20px;">
            <div class="adm-card-head"><div class="adm-card-title">급여</div></div>
            <div class="adm-card-body">
                <div class="sa-form-grid">
                    <div class="sa-form-group">
                        <label class="sa-form-label">급여 구간 (Band)</label>
                        <input class="adm-input" type="text" name="adminBand" value="${member.adminBand}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">급여 등급 (Grade)</label>
                        <input class="adm-input" type="text" name="adminGrade" value="${member.adminGrade}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">급여 호봉 (Step)</label>
                        <input class="adm-input" type="text" name="adminStep" value="${member.adminStep}">
                    </div>
                </div>
            </div>
        </div>

        <%-- ══════════════════ 권한/책임 ══════════════════ --%>
        <div class="adm-card" style="margin-bottom:20px;">
            <div class="adm-card-head"><div class="adm-card-title">권한 / 책임</div></div>
            <div class="adm-card-body">
                <div class="sa-form-grid">
                    <div class="sa-form-group" style="grid-column: 1 / -1;">
                        <label class="sa-form-label">책임 업무 범위</label>
                        <input class="adm-input" type="text" name="adminResponsibility" value="${member.adminResponsibility}">
                    </div>
                    <div class="sa-form-group" style="grid-column: 1 / -1;">
                        <label class="sa-form-label">적용 권한 설명</label>
                        <input class="adm-input" type="text" name="adminPermission" value="${member.adminPermission}">
                    </div>
                    <div class="sa-form-group">
                        <label class="sa-form-label">실효 권한 코드</label>
                        <select class="adm-select" name="adminPermissionCode" style="width:100%;">
                            <option value="">-- 선택 --</option>
                            <c:forEach var="pc" items="${permissionCodePolicies}">
                                <option value="${pc.adminPermissionCode}"
                                    ${member.adminPermissionCode == pc.adminPermissionCode ? 'selected' : ''}>
                                    ${pc.displayName} (${pc.adminPermissionCode})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <%-- ══════════════════ 상급자 ══════════════════ --%>
        <div class="adm-card" style="margin-bottom:20px;">
            <div class="adm-card-head"><div class="adm-card-title">상급자</div></div>
            <div class="adm-card-body">
                <div class="sa-form-group" style="max-width:400px;">
                    <label class="sa-form-label">상급자 선택</label>
                    <select class="adm-select" name="adminManager" style="width:100%;">
                        <option value="">-- 없음 --</option>
                        <c:forEach var="a" items="${adminList}">
                            <c:if test="${a.userIdx != member.userIdx}">
                                <option value="${a.userIdx}"
                                    ${member.adminManager == a.userIdx ? 'selected' : ''}>
                                    ${a.nickname}
                                    <c:if test="${not empty a.adminTitle}"> (${a.adminTitle})</c:if>
                                </option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>

        <%-- 저장 버튼 --%>
        <div style="display:flex;justify-content:flex-end;gap:8px;margin-bottom:40px;">
            <a href="${pageContext.request.contextPath}/superAdmin/members" class="adm-btn adm-btn-ghost">취소</a>
            <button type="button" class="adm-btn adm-btn-primary" onclick="saveEdit()">저장</button>
        </div>
    </form>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';

function saveEdit() {
    const form = document.getElementById('editForm');
    const params = new URLSearchParams(new FormData(form));

    fetch(CTX + '/superAdmin/members/${member.userIdx}/edit', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast('저장되었습니다.');
            setTimeout(() => location.href = CTX + '/superAdmin/members', 1000);
        } else {
            adm_toast(data.message || '저장 실패', 'error');
        }
    });
}
</script>

<%@ include file="../layout-close.jsp" %>
