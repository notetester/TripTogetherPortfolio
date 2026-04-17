<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="salary"/>
<c:set var="pageTitle"  value="급여/역량 현황"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">급여·역량 현황 일람표</div>
            <div style="font-size:13px;color:#94a3b8;">전체 관리자의 직급·역량·급여 정보를 한눈에 확인합니다.</div>
        </div>
        <div class="adm-card-body" style="padding:0;">

            <%-- 검색/필터 바 --%>
            <div class="sa-salary-toolbar">
                <input type="text" id="salarySearch" placeholder="닉네임·부서·직책 검색…" class="adm-input" style="width:240px;">
                <span id="salaryCount" style="font-size:13px;color:#94a3b8;"></span>
            </div>

            <div style="overflow-x:auto;">
                <table class="sa-salary-table" id="salaryTable">
                    <thead>
                        <tr>
                            <th data-col="0">닉네임 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="1">부서 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="2">팀 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="3">직책코드 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="4">직함 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="5">직급(Rank) <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="6">연차 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="7">티어 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="8">레벨 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="9">밴드 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="10">그레이드 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="11">스텝 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="12">실효권한 <span class="sa-sort-icon">⇅</span></th>
                            <th data-col="13">상급자 <span class="sa-sort-icon">⇅</span></th>
                        </tr>
                    </thead>
                    <tbody id="salaryTbody">
                        <c:forEach var="m" items="${salaryList}">
                        <tr>
                            <td>
                                <a href="${pageContext.request.contextPath}/superAdmin/members/${m.userIdx}/edit" class="sa-salary-name">${fn:escapeXml(m.nickname)}</a>
                            </td>
                            <td>${fn:escapeXml(m.adminDepartment)}</td>
                            <td>${fn:escapeXml(m.adminTeam)}</td>
                            <td>
                                <c:if test="${not empty m.adminPositionCode}">
                                    <span class="sa-salary-badge sa-badge-pos">${fn:escapeXml(m.adminPositionCode)}</span>
                                </c:if>
                                <c:if test="${empty m.adminPositionCode}">—</c:if>
                            </td>
                            <td>${fn:escapeXml(m.adminTitle)}</td>
                            <td>${fn:escapeXml(m.adminRank)}</td>
                            <td>${fn:escapeXml(m.adminSeniority)}</td>
                            <td>
                                <c:if test="${not empty m.adminTier}">
                                    <span class="sa-salary-badge sa-badge-tier">${fn:escapeXml(m.adminTier)}</span>
                                </c:if>
                                <c:if test="${empty m.adminTier}">—</c:if>
                            </td>
                            <td>${fn:escapeXml(m.adminLevel)}</td>
                            <td>${fn:escapeXml(m.adminBand)}</td>
                            <td>${fn:escapeXml(m.adminGrade)}</td>
                            <td>${fn:escapeXml(m.adminStep)}</td>
                            <td>
                                <c:if test="${not empty m.adminPermissionCode}">
                                    <span class="sa-salary-badge sa-badge-perm">${fn:escapeXml(m.adminPermissionCode)}</span>
                                </c:if>
                                <c:if test="${empty m.adminPermissionCode}">—</c:if>
                            </td>
                            <td>${fn:escapeXml(m.adminManagerNickname)}</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty salaryList}">
                <div style="text-align:center;padding:60px;color:#94a3b8;">등록된 관리자가 없습니다.</div>
            </c:if>
        </div>
    </div>
</div>

<script>
(function () {
    const tbody  = document.getElementById('salaryTbody');
    const search = document.getElementById('salarySearch');
    const count  = document.getElementById('salaryCount');
    let sortCol = -1, sortAsc = true;

    function updateCount() {
        const rows = tbody.querySelectorAll('tr:not([style*="none"])');
        count.textContent = rows.length + '명';
    }

    // 검색 필터
    search.addEventListener('input', function () {
        const kw = this.value.trim().toLowerCase();
        tbody.querySelectorAll('tr').forEach(tr => {
            const text = tr.textContent.toLowerCase();
            tr.style.display = (!kw || text.includes(kw)) ? '' : 'none';
        });
        updateCount();
    });

    // 컬럼 정렬
    document.querySelectorAll('#salaryTable thead th').forEach(th => {
        th.style.cursor = 'pointer';
        th.addEventListener('click', function () {
            const col = parseInt(this.dataset.col);
            if (sortCol === col) { sortAsc = !sortAsc; } else { sortCol = col; sortAsc = true; }
            const rows = Array.from(tbody.querySelectorAll('tr'));
            rows.sort((a, b) => {
                const av = a.cells[col] ? a.cells[col].textContent.trim() : '';
                const bv = b.cells[col] ? b.cells[col].textContent.trim() : '';
                return sortAsc ? av.localeCompare(bv, 'ko') : bv.localeCompare(av, 'ko');
            });
            rows.forEach(r => tbody.appendChild(r));
            document.querySelectorAll('#salaryTable thead th .sa-sort-icon').forEach(i => i.textContent = '⇅');
            this.querySelector('.sa-sort-icon').textContent = sortAsc ? '↑' : '↓';
        });
    });

    updateCount();
})();
</script>

<%@ include file="layout-close.jsp" %>
