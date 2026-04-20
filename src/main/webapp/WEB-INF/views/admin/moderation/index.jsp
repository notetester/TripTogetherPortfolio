<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="moderation"/>
<c:set var="pageTitle" value="콘텐츠 검열 정책"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="max-width:680px;">
        <div class="adm-card-head">
            <div class="adm-card-title">콘텐츠 검열 정책</div>
            <div style="font-size:12px;color:#64748b;">
                <c:if test="${not empty policy.updatedAt}">
                    최종 수정 <fmt:formatDate value="${policy.updatedAt}" pattern="yyyy.MM.dd HH:mm"/>
                </c:if>
            </div>
        </div>

        <div class="adm-card-body">
            <form id="moderationForm" style="display:flex;flex-direction:column;gap:24px;">

                <%-- ▸ 악성 콘텐츠 감지 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">
                        악성 콘텐츠 감지 (Perspective API)
                    </div>
                    <div style="font-size:12px;color:#64748b;margin-bottom:10px;">
                        독성 점수 임계값. 낮을수록 더 많이 차단됩니다.
                    </div>
                    <select name="toxicityLevel" class="adm-input" style="max-width:220px;">
                        <option value="STRICT" ${policy.toxicityLevel eq 'STRICT' ? 'selected' : ''}>엄격 (0.6)</option>
                        <option value="NORMAL" ${policy.toxicityLevel eq 'NORMAL' ? 'selected' : ''}>보통 (0.8)</option>
                        <option value="LOOSE"  ${policy.toxicityLevel eq 'LOOSE'  ? 'selected' : ''}>느슨 (0.9)</option>
                    </select>
                </div>

                <%-- ▸ 게시글 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">게시글 도배 차단</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="postWindowMinutes" min="1" max="1440"
                               value="${policy.postWindowMinutes}" class="adm-input" style="width:80px;"/>
                        분 내
                        <input type="number" name="postMaxCount" min="1" max="100"
                               value="${policy.postMaxCount}" class="adm-input" style="width:80px;"/>
                        개 이상 작성 시 차단
                    </div>
                </div>

                <%-- ▸ 댓글 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">댓글 도배 차단</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="commentWindowMinutes" min="1" max="1440"
                               value="${policy.commentWindowMinutes}" class="adm-input" style="width:80px;"/>
                        분 내
                        <input type="number" name="commentMaxCount" min="1" max="100"
                               value="${policy.commentMaxCount}" class="adm-input" style="width:80px;"/>
                        개 이상 작성 시 차단
                    </div>
                </div>

                <%-- ▸ 문의 도배 --%>
                <div>
                    <div style="font-size:13px;font-weight:600;margin-bottom:6px;">문의 도배 차단</div>
                    <div style="display:flex;gap:8px;align-items:center;font-size:13px;">
                        <input type="number" name="inquiryWindowMinutes" min="1" max="1440"
                               value="${policy.inquiryWindowMinutes}" class="adm-input" style="width:80px;"/>
                        분 내
                        <input type="number" name="inquiryMaxCount" min="1" max="100"
                               value="${policy.inquiryMaxCount}" class="adm-input" style="width:80px;"/>
                        개 이상 작성 시 차단
                    </div>
                </div>

                <div style="display:flex;gap:8px;border-top:1px solid #1e2736;padding-top:16px;">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="saveModeration()">저장</button>
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="resetDefaults()">기본값 복원</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';

function saveModeration() {
    var form = document.getElementById('moderationForm');
    var fd   = new FormData(form);
    var body = new URLSearchParams();
    fd.forEach(function(v, k) { body.append(k, v); });

    fetch(ctx + '/admin/moderation/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body.toString()
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) {
            alert('저장되었습니다.');
            location.reload();
        } else {
            alert(d.message || '저장 실패');
        }
    }).catch(function() { alert('저장 요청 실패'); });
}

function resetDefaults() {
    if (!confirm('기본값(보통 / 5분 3개 / 1분 5개 / 10분 3개)으로 복원하시겠습니까?')) return;
    var form = document.getElementById('moderationForm');
    form.toxicityLevel.value        = 'NORMAL';
    form.postWindowMinutes.value    = 5;
    form.postMaxCount.value         = 3;
    form.commentWindowMinutes.value = 1;
    form.commentMaxCount.value      = 5;
    form.inquiryWindowMinutes.value = 10;
    form.inquiryMaxCount.value      = 3;
}
</script>

<%@ include file="../layout-close.jsp" %>
