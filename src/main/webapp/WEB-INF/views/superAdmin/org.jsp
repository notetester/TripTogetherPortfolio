<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="org"/>
<c:set var="pageTitle"  value="조직도"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">관리자 계층 구조</div>
            <div style="font-size:13px;color:#94a3b8;">상급자가 지정되지 않은 관리자는 최상위로 표시됩니다.</div>
        </div>
        <div class="adm-card-body">
            <div id="org-chart"></div>
            <div id="org-empty" style="display:none;text-align:center;padding:60px;color:#94a3b8;">등록된 관리자가 없습니다.</div>
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

function renderNode(node) {
    var permBadge = node.permCode
        ? '<span class="sa-org-badge">' + node.permCode + '</span>' : '';
    var dept = node.department
        ? '<div class="sa-org-dept">' + node.department + '</div>' : '';
    var title = node.title
        ? '<div class="sa-org-title">' + node.title + '</div>' : '';

    var childrenHtml = node.children.length > 0
        ? '<div class="sa-org-children">' + node.children.map(renderNode).join('') + '</div>'
        : '';

    return '<div class="sa-org-node-wrap">'
        + '<div class="sa-org-node">'
        + '<div class="sa-org-avatar">' + (node.nickname ? node.nickname.charAt(0) : '?') + '</div>'
        + '<div class="sa-org-info">'
        + '<div class="sa-org-name">' + node.nickname + '</div>'
        + title + dept + permBadge
        + '</div>'
        + '<a href="' + CTX + '/superAdmin/members/' + node.userIdx + '/edit" class="sa-org-edit">편집</a>'
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
