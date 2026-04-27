<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="org"/>
<spring:message code="superAdmin.org.pageTitle" var="pageTitle"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="superAdmin.org.cardTitle"/></div>
            <div style="font-size:13px;color:#94a3b8;"><spring:message code="superAdmin.org.cardDescription"/></div>
        </div>
        <div class="adm-card-body">
            <div id="org-chart"></div>
            <div id="org-empty" style="display:none;text-align:center;padding:60px;color:#94a3b8;"><spring:message code="superAdmin.org.empty"/></div>
        </div>
    </div>
</div>

<%-- 관리자 데이터를 JS로 전달 --%>
<script>
const CTX = '${pageContext.request.contextPath}';
const admins = [
    <c:forEach var="a" items="${adminList}" varStatus="s">
    {
        userIdx:    ${a.userIdx},
        nickname:   '${fn:escapeXml(a.nickname)}',
        title:      '${fn:escapeXml(a.adminTitle)}',
        department: '${fn:escapeXml(a.adminDepartment)}',
        permCode:   '${fn:escapeXml(a.adminPermissionCode)}',
        posCode:    '${fn:escapeXml(a.adminPositionCode)}',
        manager:    ${a.adminManager != null ? a.adminManager : 'null'}
    }<c:if test="${!s.last}">,</c:if>
    </c:forEach>
];
// 권한 코드 → 사람이 읽는 라벨 (ADMIN_PERMISSION_CODE_POLICY.display_name)
const permCodeMap = {
    <c:forEach var="p" items="${permCodePolicies}" varStatus="s">
    '${fn:escapeXml(p.adminPermissionCode)}': '${fn:escapeXml(p.displayName)}'<c:if test="${!s.last}">,</c:if>
    </c:forEach>
};

function buildTree(nodes) {
    const map = {};
    const roots = [];
    nodes.forEach(n => { map[n.userIdx] = { ...n, children: [] }; });
    nodes.forEach(n => {
        if (n.manager && map[n.manager]) {
            map[n.manager].children.push(map[n.userIdx]);
        } else {
            roots.push(map[n.userIdx]);
        }
    });
    return roots;
}

// 모든 깊이 들여쓰기 트리 (├─ └─). connecting line 일관성 + 가로 폭 안정.
function renderNode(node) {
    var permLabel = (node.permCode && permCodeMap[node.permCode]) || node.permCode;
    var permBadge = node.permCode
        ? '<span class="sa-org-badge" title="' + node.permCode + '">' + permLabel + '</span>' : '';
    var dept = node.department
        ? '<div class="sa-org-dept">' + node.department + '</div>' : '';
    var title = node.title
        ? '<div class="sa-org-title">' + node.title + '</div>' : '';

    var childrenHtml = node.children.length > 0
        ? '<div class="sa-org-children sa-org-children-indent">'
            + node.children.map(renderNode).join('')
            + '</div>'
        : '';

    return '<div class="sa-org-node-wrap">'
        + '<div class="sa-org-node">'
        + '<div class="sa-org-avatar">' + (node.nickname ? node.nickname.charAt(0) : '?') + '</div>'
        + '<div class="sa-org-info">'
        + '<div class="sa-org-name">' + node.nickname + '</div>'
        + title + dept + permBadge
        + '</div>'
        + '<a href="' + CTX + '/superAdmin/members/' + node.userIdx + '/edit" class="sa-org-edit"><spring:message code="admin.common.edit" javaScriptEscape="true"/></a>'
        + '</div>'
        + childrenHtml
        + '</div>';
}

window.addEventListener('DOMContentLoaded', () => {
    if (admins.length === 0) {
        document.getElementById('org-empty').style.display = 'block';
        return;
    }
    var tree = buildTree(admins);
    document.getElementById('org-chart').innerHTML =
        '<div class="sa-org-tree">' + tree.map(renderNode).join('') + '</div>';
});
</script>

<%@ include file="layout-close.jsp" %>
