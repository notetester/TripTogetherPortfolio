<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="policies"/>
<c:set var="pageTitle" value="정책 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">운영 정책 센터</div>
        </div>
        <div class="adm-card-body">
            <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:12px;">
                <c:forEach items="${policies}" var="policy">
                    <div style="background:#111827;border:1px solid rgba(148,163,184,.18);border-radius:8px;padding:16px;">
                        <div style="font-size:12px;color:#94a3b8;">${policy.policyGroup}</div>
                        <div style="font-size:18px;font-weight:700;margin-top:4px;">${policy.policyName}</div>
                        <div style="font-size:12px;color:#94a3b8;margin-top:8px;">
                            상태:
                            <span class="status-badge ${policy.active ? 'ACTIVE' : 'DORMANT'}">${policy.active ? '활성' : '비활성'}</span>
                        </div>
                        <div style="font-size:12px;color:#94a3b8;margin-top:8px;">
                            다음 실행:
                            <c:choose>
                                <c:when test="${not empty policy.nextExecuteAtDate}">
                                    <fmt:formatDate value="${policy.nextExecuteAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                </c:when>
                                <c:otherwise>수동/미정</c:otherwise>
                            </c:choose>
                        </div>
                        <div style="font-size:12px;color:#94a3b8;margin-top:4px;">
                            마지막 실행:
                            <c:choose>
                                <c:when test="${not empty policy.lastExecutedAtDate}">
                                    <fmt:formatDate value="${policy.lastExecutedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                    <c:if test="${not empty policy.lastExecutionStatus}">
                                        / ${policy.lastExecutionStatus}
                                    </c:if>
                                </c:when>
                                <c:otherwise>기록 없음</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:minmax(0,1.1fr) minmax(320px,.9fr);gap:20px;align-items:start;">
        <div style="display:flex;flex-direction:column;gap:20px;">
            <c:forEach items="${policies}" var="policy">
                <div class="adm-card policy-card"
                     data-policy-code="${policy.policyCode}"
                     data-config-json="${fn:escapeXml(policy.configJson)}"
                     data-schedule-type="${policy.scheduleType}"
                     data-schedule-interval="${policy.scheduleIntervalHours}"
                     data-schedule-day="${policy.scheduleDayOfMonth}"
                     data-schedule-time="${policy.scheduleTime}">
                    <div class="adm-card-head">
                        <div>
                            <div class="adm-card-title">${policy.policyName}</div>
                            <div style="margin-top:6px;font-size:12px;color:#94a3b8;">${policy.policyCode}</div>
                        </div>
                        <div style="display:flex;gap:8px;align-items:center;">
                            <span class="status-badge ${policy.active ? 'ACTIVE' : 'DORMANT'}">${policy.active ? '활성' : '비활성'}</span>
                            <button type="button" class="adm-btn adm-btn-ghost" onclick="runPolicyNow('${policy.policyCode}', this)">지금 실행</button>
                        </div>
                    </div>
                    <div class="adm-card-body">
                        <div class="policy-form-grid" style="display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:12px;">
                            <div class="policy-config-dormant" style="display:none;">
                                <div class="adm-filter-label">휴면 기준(일)</div>
                                <input class="adm-input js-policy-inactive-days" type="number" min="30" step="1">
                            </div>
                            <div class="policy-config-level" style="display:none;">
                                <div class="adm-filter-label">정산 대상</div>
                                <label style="display:flex;gap:8px;align-items:center;margin-top:10px;font-size:13px;">
                                    <input class="js-policy-only-active" type="checkbox">
                                    활성 회원만 정산
                                </label>
                            </div>
                            <div>
                                <div class="adm-filter-label">실행 방식</div>
                                <select class="adm-select js-policy-schedule-type" style="width:100%;">
                                    <option value="DAILY_TIME">매일 지정 시각</option>
                                    <option value="INTERVAL_HOURS">n시간 간격</option>
                                    <option value="MONTHLY_DAY_TIME">매월 지정일/시각</option>
                                    <option value="MANUAL">수동</option>
                                </select>
                            </div>
                            <div class="js-policy-interval-wrap">
                                <div class="adm-filter-label">실행 간격(시간)</div>
                                <input class="adm-input js-policy-interval" type="number" min="1" step="1">
                            </div>
                            <div class="js-policy-day-wrap">
                                <div class="adm-filter-label">월간 실행 일자</div>
                                <input class="adm-input js-policy-day" type="number" min="1" max="28" step="1">
                            </div>
                            <div class="js-policy-time-wrap">
                                <div class="adm-filter-label">실행 시각</div>
                                <input class="adm-input js-policy-time" type="time">
                            </div>
                            <div>
                                <div class="adm-filter-label">정책 활성화</div>
                                <label style="display:flex;gap:8px;align-items:center;margin-top:10px;font-size:13px;">
                                    <input class="js-policy-active" type="checkbox" ${policy.active ? 'checked' : ''}>
                                    자동 실행에 포함
                                </label>
                            </div>
                        </div>
                        <div style="margin-top:16px;display:flex;justify-content:space-between;gap:12px;flex-wrap:wrap;align-items:center;">
                            <div style="font-size:12px;color:#94a3b8;">
                                마지막 메시지:
                                <span style="color:#cbd5e1;">${empty policy.lastExecutionMessage ? '기록 없음' : policy.lastExecutionMessage}</span>
                            </div>
                            <div style="display:flex;gap:8px;">
                                <button type="button" class="adm-btn adm-btn-primary" onclick="savePolicy('${policy.policyCode}', this)">정책 저장</button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">최근 정책 이력</div>
            </div>
            <div class="adm-card-body" style="display:flex;flex-direction:column;gap:16px;">
                <c:forEach items="${policies}" var="policy">
                    <div style="border:1px solid rgba(148,163,184,.18);border-radius:8px;padding:14px;">
                        <div style="font-weight:700;">${policy.policyName}</div>
                        <div style="font-size:12px;color:#94a3b8;margin-top:2px;">${policy.policyCode}</div>
                        <div style="margin-top:10px;display:flex;flex-direction:column;gap:8px;">
                            <c:forEach items="${policyHistories[policy.policyCode]}" var="history">
                                <div style="padding:10px 12px;border-radius:8px;background:#111827;">
                                    <div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">
                                        <div style="font-size:13px;font-weight:600;">${history.changeType}</div>
                                        <div style="font-size:11px;color:#94a3b8;">
                                            <fmt:formatDate value="${history.changedAtDate}" pattern="MM.dd HH:mm"/>
                                        </div>
                                    </div>
                                    <div style="margin-top:6px;font-size:12px;color:#94a3b8;">
                                        담당:
                                        <span style="color:#cbd5e1;">${empty history.changedByNickname ? '시스템' : history.changedByNickname}</span>
                                    </div>
                                    <c:if test="${not empty history.executionStatus or not empty history.executionMessage}">
                                        <div style="margin-top:6px;font-size:12px;color:#94a3b8;">
                                            결과:
                                            <span style="color:#cbd5e1;">${empty history.executionStatus ? '-' : history.executionStatus}</span>
                                            <c:if test="${not empty history.executionMessage}">
                                                / ${history.executionMessage}
                                            </c:if>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                            <c:if test="${empty policyHistories[policy.policyCode]}">
                                <div style="font-size:12px;color:#64748b;">이력이 없습니다.</div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
const POLICY_CTX = '${pageContext.request.contextPath}';

function parsePolicyConfig(text) {
    if (!text) return {};
    try {
        return JSON.parse(text);
    } catch (e) {
        console.warn('정책 JSON 파싱 실패', e);
        return {};
    }
}

function togglePolicyScheduleFields(card) {
    const scheduleType = card.querySelector('.js-policy-schedule-type').value;
    card.querySelector('.js-policy-interval-wrap').style.display = scheduleType === 'INTERVAL_HOURS' ? '' : 'none';
    card.querySelector('.js-policy-day-wrap').style.display = scheduleType === 'MONTHLY_DAY_TIME' ? '' : 'none';
    card.querySelector('.js-policy-time-wrap').style.display = scheduleType === 'MANUAL' ? 'none' : '';
}

function hydratePolicyCard(card) {
    const policyCode = card.dataset.policyCode;
    const config = parsePolicyConfig(card.dataset.configJson);
    const scheduleTypeInput = card.querySelector('.js-policy-schedule-type');
    const intervalInput = card.querySelector('.js-policy-interval');
    const dayInput = card.querySelector('.js-policy-day');
    const timeInput = card.querySelector('.js-policy-time');

    scheduleTypeInput.value = card.dataset.scheduleType || 'DAILY_TIME';
    intervalInput.value = card.dataset.scheduleInterval || '';
    dayInput.value = card.dataset.scheduleDay || '';
    timeInput.value = card.dataset.scheduleTime || '03:00';

    if (policyCode === 'DORMANT_ACCOUNT_POLICY') {
        card.querySelector('.policy-config-dormant').style.display = '';
        card.querySelector('.js-policy-inactive-days').value = config.inactiveDays || 365;
    }
    if (policyCode === 'MEMBER_LEVEL_SETTLEMENT_POLICY') {
        card.querySelector('.policy-config-level').style.display = '';
        card.querySelector('.js-policy-only-active').checked = config.onlyActiveMembers !== false;
    }

    scheduleTypeInput.addEventListener('change', function() {
        togglePolicyScheduleFields(card);
    });
    togglePolicyScheduleFields(card);
}

document.querySelectorAll('.policy-card').forEach(hydratePolicyCard);

async function savePolicy(policyCode, button) {
    const card = button.closest('.policy-card');
    const scheduleType = card.querySelector('.js-policy-schedule-type').value;
    const scheduleIntervalHours = card.querySelector('.js-policy-interval').value;
    const scheduleDayOfMonth = card.querySelector('.js-policy-day').value;
    const scheduleTime = card.querySelector('.js-policy-time').value;
    const active = card.querySelector('.js-policy-active').checked;
    let config = {};

    if (policyCode === 'DORMANT_ACCOUNT_POLICY') {
        config.inactiveDays = Number(card.querySelector('.js-policy-inactive-days').value || 365);
    } else if (policyCode === 'MEMBER_LEVEL_SETTLEMENT_POLICY') {
        config.onlyActiveMembers = card.querySelector('.js-policy-only-active').checked;
    }

    const payload = new URLSearchParams({
        configJson: JSON.stringify(config),
        scheduleType: scheduleType,
        scheduleIntervalHours: scheduleIntervalHours || '',
        scheduleDayOfMonth: scheduleDayOfMonth || '',
        scheduleTime: scheduleTime || '',
        active: active
    });

    button.disabled = true;
    const originalText = button.textContent;
    button.textContent = '저장 중...';
    try {
        const response = await fetch(POLICY_CTX + '/admin/policies/' + encodeURIComponent(policyCode), {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: payload
        });
        const data = await response.json();
        if (response.ok && data.success) {
            adm_toast(data.message || '정책을 저장했습니다.');
            setTimeout(function() { location.reload(); }, 600);
        } else {
            adm_toast(data.message || '정책 저장에 실패했습니다.', 'error');
        }
    } catch (error) {
        console.error(error);
        adm_toast('정책 저장 중 오류가 발생했습니다.', 'error');
    } finally {
        button.disabled = false;
        button.textContent = originalText;
    }
}

async function runPolicyNow(policyCode, button) {
    if (!confirm('이 정책을 지금 즉시 실행할까요?')) {
        return;
    }
    button.disabled = true;
    const originalText = button.textContent;
    button.textContent = '실행 중...';
    try {
        const response = await fetch(POLICY_CTX + '/admin/policies/' + encodeURIComponent(policyCode) + '/run', {
            method: 'POST'
        });
        const data = await response.json();
        if (response.ok && data.success) {
            adm_toast(data.message || '정책을 실행했습니다.');
            setTimeout(function() { location.reload(); }, 600);
        } else {
            adm_toast(data.message || '정책 실행에 실패했습니다.', 'error');
        }
    } catch (error) {
        console.error(error);
        adm_toast('정책 실행 중 오류가 발생했습니다.', 'error');
    } finally {
        button.disabled = false;
        button.textContent = originalText;
    }
}
</script>

<%@ include file="../layout-close.jsp" %>
