<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="inquiries"/>
<c:set var="pageTitle" value="문의 상세"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="javascript:goBackToList()" style="color:#64748b;text-decoration:none;font-size:13px;">← 목록으로</a>
    </div>

    <div style="display:grid;grid-template-columns:2fr 1fr;gap:20px;align-items:start;">

        <%-- ── 왼쪽 ── --%>
        <div>

            <%-- 문의 내용 카드 --%>
            <div class="adm-card" style="margin-bottom:20px;">
                <div class="adm-card-head">
                    <div class="adm-card-title">문의 #${inquiry.inquiryId}</div>
                    <div style="display:flex;gap:8px;align-items:center;">
                        <span class="status-badge ${inquiry.status}">
                            <c:choose>
                                <c:when test="${inquiry.status eq 'PENDING'}">대기중</c:when>
                                <c:when test="${inquiry.status eq 'IN_PROGRESS'}">처리중</c:when>
                                <c:when test="${inquiry.status eq 'COMPLETED'}">답변완료</c:when>
                                <c:when test="${inquiry.status eq 'USER_COMPLETED'}">해결됨</c:when>
                                <c:when test="${inquiry.status eq 'CANCELLED'}">취소됨</c:when>
                                <c:otherwise>${inquiry.status}</c:otherwise>
                            </c:choose>
                        </span>
                        <a href="${pageContext.request.contextPath}/inquiry/${inquiry.inquiryId}"
                           target="_blank"
                           class="adm-btn adm-btn-ghost"
                           style="font-size:12px;text-decoration:none;">원글 보기</a>
                    </div>
                </div>
                <div class="adm-card-body">
                    <div style="margin-bottom:10px;">
                        <span style="font-size:11px;background:#1e3a5f;color:#7dd3fc;padding:2px 8px;border-radius:4px;margin-right:6px;">
                            <c:choose>
                                <c:when test="${inquiry.category eq 'service'}">서비스</c:when>
                                <c:when test="${inquiry.category eq 'payment'}">결제</c:when>
                                <c:when test="${inquiry.category eq 'account'}">계정</c:when>
                                <c:when test="${inquiry.category eq 'bug'}">오류신고</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </span>
                        <c:if test="${inquiry.privateFlag}">
                            <span style="font-size:11px;color:#94a3b8;">🔒 비공개</span>
                        </c:if>
                    </div>
                    <h3 style="font-size:18px;font-weight:600;margin:0 0 12px;color:#f1f5f9;">${inquiry.title}</h3>
                    <div style="font-size:13px;color:#94a3b8;line-height:1.7;white-space:pre-wrap;">${inquiry.content}</div>
                    <div style="margin-top:16px;padding-top:12px;border-top:1px solid #1e2736;
                                display:flex;gap:20px;font-size:12px;color:#64748b;">
                        <span>👁 ${inquiry.viewCount}</span>
                        <span><fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                    </div>
                </div>
            </div>

            <%-- 답변 카드 --%>
            <div class="adm-card">
                <div class="adm-card-head">
                    <div class="adm-card-title">관리자 답변</div>
                    <c:if test="${not empty inquiry.answerId}">
                        <div style="font-size:12px;color:#64748b;">
                            ${inquiry.answerAdminNickname} ·
                            <fmt:formatDate value="${inquiry.answeredAt}" pattern="yyyy.MM.dd HH:mm"/>
                        </div>
                    </c:if>
                </div>
                <div class="adm-card-body">

                    <%-- 기존 답변 표시 --%>
                    <c:if test="${not empty inquiry.answerId}">
                        <div id="answerView">
                            <div style="font-size:13px;color:#cbd5e1;line-height:1.7;white-space:pre-wrap;
                                        background:#0f172a;padding:14px;border-radius:6px;margin-bottom:12px;"
                                 id="answerText">${inquiry.answerContent}</div>
                            <div style="display:flex;gap:8px;">
                                <button class="adm-btn adm-btn-ghost" style="font-size:12px;"
                                        onclick="showEditForm()">수정</button>
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:12px;color:#f87171;border-color:#f87171;"
                                        onclick="deleteAnswer()">답변 삭제</button>
                            </div>
                        </div>
                        <div id="answerEditForm" style="display:none;">
                            <textarea id="answerEditContent" class="adm-input"
                                      style="width:100%;height:150px;resize:vertical;padding:10px;font-size:13px;"
                                      >${inquiry.answerContent}</textarea>
                            <div style="display:flex;gap:8px;margin-top:8px;">
                                <button class="adm-btn adm-btn-primary" style="font-size:12px;"
                                        onclick="saveAnswer(true)">저장</button>
                                <button class="adm-btn adm-btn-ghost" style="font-size:12px;"
                                        onclick="hideEditForm()">취소</button>
                            </div>
                        </div>
                    </c:if>

                    <%-- 답변 없을 때 작성 폼 --%>
                    <c:if test="${empty inquiry.answerId}">
                        <div id="answerWriteForm">
                            <textarea id="answerNewContent" class="adm-input"
                                      style="width:100%;height:150px;resize:vertical;padding:10px;font-size:13px;"
                                      placeholder="답변 내용을 입력하세요."></textarea>
                            <div style="display:flex;gap:8px;margin-top:8px;">
                                <button class="adm-btn adm-btn-primary" style="font-size:12px;"
                                        onclick="saveAnswer(false)">답변 등록</button>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>

        </div>

        <%-- ── 오른쪽: 작성자 정보 + 액션 ── --%>
        <div>
            <div class="adm-card" style="position:sticky;top:80px;">
                <div class="adm-card-head">
                    <div class="adm-card-title">작성자 정보</div>
                </div>
                <div class="adm-card-body">
                    <div style="display:flex;flex-direction:column;gap:12px;">

                        <div>
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;">아이디</div>
                            <div style="font-size:14px;font-weight:600;">${inquiry.userId}</div>
                        </div>
                        <div>
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;">닉네임</div>
                            <div style="font-size:14px;font-weight:600;">${inquiry.nickname}</div>
                        </div>

                        <div style="border-top:1px solid #1e2736;padding-top:12px;">
                            <a href="${pageContext.request.contextPath}/admin/members?searchType=userId&keyword=${inquiry.userId}"
                               class="adm-btn adm-btn-ghost"
                               style="text-align:center;font-size:12px;text-decoration:none;display:block;">
                                회원 정보 보기
                            </a>
                        </div>

                        <%-- 상태 변경 --%>
                        <div style="border-top:1px solid #1e2736;padding-top:12px;">
                            <div style="font-size:11px;color:#64748b;margin-bottom:8px;">상태 변경</div>
                            <div style="display:flex;gap:6px;flex-wrap:wrap;">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:11px;padding:4px 10px;color:#fbbf24;border-color:#fbbf24;"
                                        data-status="PENDING"
                                        onclick="changeStatus(this.getAttribute('data-status'))">대기중</button>
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:11px;padding:4px 10px;color:#fb923c;border-color:#fb923c;"
                                        data-status="IN_PROGRESS"
                                        onclick="changeStatus(this.getAttribute('data-status'))">처리중</button>
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:11px;padding:4px 10px;color:#34d399;border-color:#34d399;"
                                        data-status="COMPLETED"
                                        onclick="changeStatus(this.getAttribute('data-status'))">답변완료</button>
                            </div>
                        </div>

                        <%-- 삭제 --%>
                        <div style="border-top:1px solid #1e2736;padding-top:12px;">
                            <button class="adm-btn adm-btn-ghost"
                                    style="font-size:12px;color:#f87171;border-color:#f87171;width:100%;"
                                    onclick="deleteInquiry()">문의 삭제</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
var ctx       = '${pageContext.request.contextPath}';
var inquiryId = ${inquiry.inquiryId};

function goBackToList() {
    var params = new URLSearchParams(window.location.search);
    var page       = params.get('page')       || '1';
    var status     = params.get('status')     || '';
    var category   = params.get('category')   || '';
    var answered   = params.get('answered')   || '';
    var searchType = params.get('searchType') || '';
    var keyword    = params.get('keyword')    || '';
    var url = ctx + '/admin/inquiries?page=' + page;
    if (status)     url += '&status='     + encodeURIComponent(status);
    if (category)   url += '&category='   + encodeURIComponent(category);
    if (answered)   url += '&answered='   + encodeURIComponent(answered);
    if (searchType) url += '&searchType=' + encodeURIComponent(searchType);
    if (keyword)    url += '&keyword='    + encodeURIComponent(keyword);
    location.href = url;
}

function saveAnswer(isEdit) {
    var contentId = isEdit ? 'answerEditContent' : 'answerNewContent';
    var content = document.getElementById(contentId).value.trim();
    if (!content) { alert('답변 내용을 입력해주세요.'); return; }
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/answer', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: 'content=' + encodeURIComponent(content)
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
    });
}

function deleteAnswer() {
    if (!confirm('답변을 삭제하시겠습니까? 상태가 대기중으로 변경됩니다.')) return;
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/answer/delete', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
    });
}

function changeStatus(status) {
    var labels = { PENDING: '대기중', IN_PROGRESS: '처리중', COMPLETED: '답변완료' };
    if (!confirm('상태를 [' + (labels[status] || status) + ']으로 변경하시겠습니까?')) return;
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/status', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: 'status=' + encodeURIComponent(status)
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || '처리 실패'); }
    });
}

function deleteInquiry() {
    if (!confirm('문의를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) return;
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/delete', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.href = ctx + '/admin/inquiries'; }
        else { alert(d.message || '처리 실패'); }
    });
}

function showEditForm() {
    document.getElementById('answerView').style.display = 'none';
    document.getElementById('answerEditForm').style.display = 'block';
}

function hideEditForm() {
    document.getElementById('answerEditForm').style.display = 'none';
    document.getElementById('answerView').style.display = 'block';
}
</script>

<%@ include file="../layout-close.jsp" %>
