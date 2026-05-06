<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_policy_pageTitle" code="admin.policy.pageTitle"/>
<spring:message var="msg_admin_policy_centerTitle" code="admin.policy.centerTitle"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_common_active" code="admin.common.active"/>
<spring:message var="msg_admin_common_inactive" code="admin.common.inactive"/>
<spring:message var="msg_admin_policy_nextExecute" code="admin.policy.nextExecute"/>
<spring:message var="msg_admin_policy_unscheduled" code="admin.policy.unscheduled"/>
<spring:message var="msg_admin_policy_lastExecute" code="admin.policy.lastExecute"/>
<spring:message var="msg_admin_policy_noExecution" code="admin.policy.noExecution"/>
<spring:message var="msg_admin_policy_runNow" code="admin.policy.runNow"/>
<spring:message var="msg_admin_policy_inactiveDays" code="admin.policy.inactiveDays"/>
<spring:message var="msg_admin_policy_levelScope" code="admin.policy.levelScope"/>
<spring:message var="msg_admin_policy_onlyActiveMembers" code="admin.policy.onlyActiveMembers"/>
<spring:message var="msg_admin_policy_scheduleType" code="admin.policy.scheduleType"/>
<spring:message var="msg_admin_policy_schedule_daily" code="admin.policy.schedule.daily"/>
<spring:message var="msg_admin_policy_schedule_interval" code="admin.policy.schedule.interval"/>
<spring:message var="msg_admin_policy_schedule_monthly" code="admin.policy.schedule.monthly"/>
<spring:message var="msg_admin_policy_schedule_manual" code="admin.policy.schedule.manual"/>
<spring:message var="msg_admin_policy_intervalHours" code="admin.policy.intervalHours"/>
<spring:message var="msg_admin_policy_dayOfMonth" code="admin.policy.dayOfMonth"/>
<spring:message var="msg_admin_policy_scheduleTime" code="admin.policy.scheduleTime"/>
<spring:message var="msg_admin_policy_policyEnabled" code="admin.policy.policyEnabled"/>
<spring:message var="msg_admin_policy_autoExecution" code="admin.policy.autoExecution"/>
<spring:message var="msg_admin_policy_lastMessage" code="admin.policy.lastMessage"/>
<spring:message var="msg_admin_policy_save" code="admin.policy.save"/>
<spring:message var="msg_admin_policy_historyTitle" code="admin.policy.historyTitle"/>
<spring:message var="msg_admin_policy_operator" code="admin.policy.operator"/>
<spring:message var="msg_admin_common_system" code="admin.common.system"/>
<spring:message var="msg_admin_common_result" code="admin.common.result"/>
<spring:message var="msg_admin_policy_noHistory" code="admin.policy.noHistory"/>
<spring:message var="msg_admin_policy_saving" code="admin.policy.saving"/>
<spring:message var="msg_admin_policy_saveSuccess" code="admin.policy.saveSuccess"/>
<spring:message var="msg_admin_policy_saveFailure" code="admin.policy.saveFailure"/>
<spring:message var="msg_admin_policy_saveError" code="admin.policy.saveError"/>
<spring:message var="msg_admin_policy_runConfirm" code="admin.policy.runConfirm"/>
<spring:message var="msg_admin_policy_running" code="admin.policy.running"/>
<spring:message var="msg_admin_policy_runSuccess" code="admin.policy.runSuccess"/>
<spring:message var="msg_admin_policy_runFailure" code="admin.policy.runFailure"/>
<spring:message var="msg_admin_policy_runError" code="admin.policy.runError"/>
<spring:message var="msg_admin_policy_jsonParseError" code="admin.policy.jsonParseError"/>
<c:set var="activeMenu" value="policies"/>

<c:set var="pageTitle" value="${msg_admin_policy_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_policy_centerTitle}</div>
        </div>
        <div class="adm-card-body">
            <div class="policy-overview-grid">
                <c:forEach items="${policies}" var="policy">
                    <div class="policy-overview-card">
                        <div class="policy-overview-eyebrow">${policy.policyGroup}</div>
                        <div class="policy-overview-title">${policy.policyName}</div>
                        <div class="policy-overview-meta">
                            ${msg_admin_common_status}:
                            <span class="status-badge ${policy.active ? 'ACTIVE' : 'DORMANT'}">
                                <c:choose>
                                    <c:when test="${policy.active}">${msg_admin_common_active}</c:when>
                                    <c:otherwise>${msg_admin_common_inactive}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="policy-overview-meta">
                            ${msg_admin_policy_nextExecute}:
                            <c:choose>
                                <c:when test="${not empty policy.nextExecuteAtDate}">
                                    <fmt:formatDate value="${policy.nextExecuteAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                </c:when>
                                <c:otherwise>${msg_admin_policy_unscheduled}</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="policy-overview-meta">
                            ${msg_admin_policy_lastExecute}:
                            <c:choose>
                                <c:when test="${not empty policy.lastExecutedAtDate}">
                                    <fmt:formatDate value="${policy.lastExecutedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                    <c:if test="${not empty policy.lastExecutionStatus}">
                                        / ${policy.lastExecutionStatus}
                                    </c:if>
                                </c:when>
                                <c:otherwise>${msg_admin_policy_noExecution}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="policy-layout">
        <div class="policy-main-column">
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
                            <div class="adm-card-subtitle">${policy.policyCode}</div>
                        </div>
                        <div class="policy-card-head-actions">
                            <span class="status-badge ${policy.active ? 'ACTIVE' : 'DORMANT'}">
                                <c:choose>
                                    <c:when test="${policy.active}">${msg_admin_common_active}</c:when>
                                    <c:otherwise>${msg_admin_common_inactive}</c:otherwise>
                                </c:choose>
                            </span>
                            <button type="button" class="adm-btn adm-btn-ghost" onclick="runPolicyNow('${policy.policyCode}', this)">${msg_admin_policy_runNow}</button>
                        </div>
                    </div>
                    <div class="adm-card-body">
                        <div class="policy-form-grid">
                            <div class="policy-config-dormant" style="display:none;">
                                <div class="adm-filter-label">${msg_admin_policy_inactiveDays}</div>
                                <input class="adm-input js-policy-inactive-days" type="number" min="30" step="1">
                            </div>
                            <div class="policy-config-level" style="display:none;">
                                <div class="adm-filter-label">${msg_admin_policy_levelScope}</div>
                                <label class="policy-inline-check">
                                    <input class="js-policy-only-active" type="checkbox">
                                    ${msg_admin_policy_onlyActiveMembers}
                                </label>
                            </div>
                            <div>
                                <div class="adm-filter-label">${msg_admin_policy_scheduleType}</div>
                                <select class="adm-select js-policy-schedule-type" style="width:100%;">
                                    <option value="DAILY_TIME">${msg_admin_policy_schedule_daily}</option>
                                    <option value="INTERVAL_HOURS">${msg_admin_policy_schedule_interval}</option>
                                    <option value="MONTHLY_DAY_TIME">${msg_admin_policy_schedule_monthly}</option>
                                    <option value="MANUAL">${msg_admin_policy_schedule_manual}</option>
                                </select>
                            </div>
                            <div class="js-policy-interval-wrap">
                                <div class="adm-filter-label">${msg_admin_policy_intervalHours}</div>
                                <input class="adm-input js-policy-interval" type="number" min="1" step="1">
                            </div>
                            <div class="js-policy-day-wrap">
                                <div class="adm-filter-label">${msg_admin_policy_dayOfMonth}</div>
                                <input class="adm-input js-policy-day" type="number" min="1" max="28" step="1">
                            </div>
                            <div class="js-policy-time-wrap">
                                <div class="adm-filter-label">${msg_admin_policy_scheduleTime}</div>
                                <input class="adm-input js-policy-time" type="time">
                            </div>
                            <div>
                                <div class="adm-filter-label">${msg_admin_policy_policyEnabled}</div>
                                <label class="policy-inline-check">
                                    <input class="js-policy-active" type="checkbox" ${policy.active ? 'checked' : ''}>
                                    ${msg_admin_policy_autoExecution}
                                </label>
                            </div>
                        </div>
                        <div class="policy-card-foot">
                            <div class="policy-card-foot-note">
                                ${msg_admin_policy_lastMessage}:
                                <span class="policy-card-foot-value">
                                    <c:choose>
                                        <c:when test="${empty policy.lastExecutionMessage}">
                                            ${msg_admin_policy_noExecution}
                                        </c:when>
                                        <c:otherwise>${policy.lastExecutionMessage}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div style="display:flex;gap:8px;">
                                <button type="button" class="adm-btn adm-btn-primary" onclick="savePolicy('${policy.policyCode}', this)">${msg_admin_policy_save}</button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_admin_policy_historyTitle}</div>
            </div>
            <div class="adm-card-body policy-history-column">
                <c:forEach items="${policies}" var="policy">
                    <div class="policy-history-card">
                        <div class="policy-history-card-title">${policy.policyName}</div>
                        <div class="adm-card-subtitle">${policy.policyCode}</div>
                        <div class="policy-history-stack">
                            <c:forEach items="${policyHistories[policy.policyCode]}" var="history">
                                <div class="policy-history-item">
                                    <div class="policy-history-item-head">
                                        <div class="policy-history-item-title">${history.changeType}</div>
                                        <div class="policy-history-item-time">
                                            <fmt:formatDate value="${history.changedAtDate}" pattern="MM.dd HH:mm"/>
                                        </div>
                                    </div>
                                    <div class="policy-history-item-meta">
                                        ${msg_admin_policy_operator}:
                                        <span class="policy-history-item-value">
                                            <c:choose>
                                                <c:when test="${empty history.changedByNickname}">${msg_admin_common_system}</c:when>
                                                <c:otherwise>${history.changedByNickname}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <c:if test="${not empty history.executionStatus or not empty history.executionMessage}">
                                        <div class="policy-history-item-meta">
                                            ${msg_admin_common_result}:
                                            <span class="policy-history-item-value">${empty history.executionStatus ? '-' : history.executionStatus}</span>
                                            <c:if test="${not empty history.executionMessage}">
                                                / ${history.executionMessage}
                                            </c:if>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                            <c:if test="${empty policyHistories[policy.policyCode]}">
                                <div class="policy-history-empty">${msg_admin_policy_noHistory}</div>
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
const POLICY_TEXT = {
    noExecution: '${fn:escapeXml(msg_admin_policy_noExecution)}',
    saving: '${fn:escapeXml(msg_admin_policy_saving)}',
    saveSuccess: '${fn:escapeXml(msg_admin_policy_saveSuccess)}',
    saveFailure: '${fn:escapeXml(msg_admin_policy_saveFailure)}',
    saveError: '${fn:escapeXml(msg_admin_policy_saveError)}',
    runConfirm: '${fn:escapeXml(msg_admin_policy_runConfirm)}',
    running: '${fn:escapeXml(msg_admin_policy_running)}',
    runSuccess: '${fn:escapeXml(msg_admin_policy_runSuccess)}',
    runFailure: '${fn:escapeXml(msg_admin_policy_runFailure)}',
    runError: '${fn:escapeXml(msg_admin_policy_runError)}',
    jsonParseError: '${fn:escapeXml(msg_admin_policy_jsonParseError)}'
};

function parsePolicyConfig(text) {
    if (!text) return {};
    try {
        return JSON.parse(text);
    } catch (e) {
        console.warn(POLICY_TEXT.jsonParseError, e);
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
    button.textContent = POLICY_TEXT.saving;
    try {
        const response = await fetch(POLICY_CTX + '/admin/policies/' + encodeURIComponent(policyCode), {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: payload
        });
        const data = await response.json();
        if (response.ok && data.success) {
            adm_toast(POLICY_TEXT.saveSuccess);
            setTimeout(function() { location.reload(); }, 600);
        } else {
            adm_toast(POLICY_TEXT.saveFailure, 'error');
        }
    } catch (error) {
        console.error(error);
        adm_toast(POLICY_TEXT.saveError, 'error');
    } finally {
        button.disabled = false;
        button.textContent = originalText;
    }
}

async function runPolicyNow(policyCode, button) {
    if (!confirm(POLICY_TEXT.runConfirm)) {
        return;
    }
    button.disabled = true;
    const originalText = button.textContent;
    button.textContent = POLICY_TEXT.running;
    try {
        const response = await fetch(POLICY_CTX + '/admin/policies/' + encodeURIComponent(policyCode) + '/run', {
            method: 'POST'
        });
        const data = await response.json();
        if (response.ok && data.success) {
            adm_toast(POLICY_TEXT.runSuccess);
            setTimeout(function() { location.reload(); }, 600);
        } else {
            adm_toast(POLICY_TEXT.runFailure, 'error');
        }
    } catch (error) {
        console.error(error);
        adm_toast(POLICY_TEXT.runError, 'error');
    } finally {
        button.disabled = false;
        button.textContent = originalText;
    }
}
</script>

<%@ include file="../layout-close.jsp" %>
