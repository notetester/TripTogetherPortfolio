<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_b044513d01" code="admin.aiHelper.chatbot.kpi.totalConversations"/>
<spring:message var="autoMsg_c5ed12cd73" code="admin.aiHelper.chatbot.kpi.todayConversations"/>
<spring:message var="autoMsg_38fc999f60" code="admin.aiHelper.chatbot.kpi.inappropriate"/>
<spring:message var="autoMsg_a2c9244ccd" code="admin.aiHelper.chatbot.kpi.activeBlocks"/>
<spring:message var="autoMsg_e65b057767" code="admin.aiHelper.assistant.section.sessions"/>
<spring:message var="autoMsg_88ad3487c3" code="admin.aiHelper.chatbot.searchPlaceholder"/>
<spring:message var="autoMsg_a92d9b539d" code="admin.common.search"/>
<spring:message var="autoMsg_1b193ad4dc" code="admin.common.reset"/>
<spring:message var="autoMsg_ddcd0ecda1" code="admin.common.totalCountFormat"/>
<spring:message var="autoMsg_2f75dca1b5" code="admin.aiHelper.chatbot.table.id"/>
<spring:message var="autoMsg_27a7f3036c" code="admin.aiHelper.chatbot.table.title"/>
<spring:message var="autoMsg_a45db7c223" code="admin.aiHelper.chatbot.table.user"/>
<spring:message var="autoMsg_cfd18e97f4" code="admin.aiHelper.chatbot.table.ip"/>
<spring:message var="autoMsg_96ba24dba9" code="admin.aiHelper.chatbot.table.messageCount"/>
<spring:message var="autoMsg_91e2e03333" code="admin.aiHelper.chatbot.table.lastActive"/>
<spring:message var="autoMsg_de2c9c4fa1" code="admin.aiHelper.chatbot.table.status"/>
<spring:message var="autoMsg_41bbb6a01d" code="admin.aiHelper.chatbot.table.actions"/>
<spring:message var="autoMsg_3e959557b8" code="admin.aiHelper.chatbot.action.blockUser"/>
<spring:message var="autoMsg_06cab51800" code="admin.aiHelper.chatbot.action.blockIp"/>
<spring:message var="autoMsg_048e7770e2" code="admin.aiHelper.chatbot.empty.conversations"/>
<spring:message var="autoMsg_2545d16e5e" code="admin.aiHelper.assistant.userPrefix"/>
<spring:message var="autoMsg_f5a85deeca" code="admin.aiHelper.chatbot.guest"/>
<spring:message var="autoMsg_d0a646007a" code="admin.aiHelper.chatbot.status.deleted"/>
<spring:message var="autoMsg_a0911576a4" code="admin.aiHelper.chatbot.status.active"/>
<spring:message var="autoMsg_efe9a9c736" code="admin.aiHelper.chatbot.action.view"/>
<spring:message var="autoMsg_4cf560b97d" code="admin.aiHelper.chatbot.table.content"/>
<spring:message var="autoMsg_8ec7cce7ae" code="admin.common.time"/>
<spring:message var="autoMsg_3d169ad991" code="admin.aiHelper.chatbot.empty.inappropriate"/>
<spring:message var="autoMsg_fc6d23c55c" code="admin.aiHelper.chatbot.action.viewConversation"/>
<spring:message var="autoMsg_ce1899fbd6" code="admin.aiHelper.chatbot.table.type"/>
<spring:message var="autoMsg_e1ac1bc532" code="admin.aiHelper.chatbot.type.ip"/>
<spring:message var="autoMsg_bb65e972fc" code="admin.aiHelper.chatbot.type.user"/>
<spring:message var="autoMsg_97c89b9bce" code="admin.aiHelper.chatbot.table.value"/>
<spring:message var="autoMsg_268d704cb2" code="admin.aiHelper.chatbot.valuePlaceholder"/>
<spring:message var="autoMsg_77dec33b00" code="admin.aiHelper.chatbot.table.reason"/>
<spring:message var="autoMsg_f5f3920815" code="admin.aiHelper.chatbot.reasonPlaceholder"/>
<spring:message var="autoMsg_e54e759a71" code="admin.aiHelper.chatbot.action.createBlock"/>
<spring:message var="autoMsg_b6fd656a80" code="admin.aiHelper.chatbot.table.blockedBy"/>
<spring:message var="autoMsg_bde0c1c278" code="admin.aiHelper.chatbot.table.blockedAt"/>
<spring:message var="autoMsg_1522384987" code="admin.aiHelper.chatbot.table.expiresAt"/>
<spring:message var="autoMsg_a2e4e48369" code="admin.aiHelper.chatbot.empty.blocks"/>
<spring:message var="autoMsg_c03aa9eb82" code="admin.aiHelper.chatbot.value.permanent"/>
<spring:message var="autoMsg_a151681abe" code="admin.aiHelper.chatbot.status.released"/>
<spring:message var="autoMsg_8287c856a5" code="admin.aiHelper.chatbot.action.release"/>
<spring:message var="autoMsg_046c3e678c" code="admin.aiHelper.chatbot.description.quota"/>
<spring:message var="autoMsg_831e51c6fe" code="admin.aiHelper.chatbot.modal.title"/>
<spring:message var="autoMsg_50d441663e" code="admin.common.close"/>
<spring:message var="autoMsg_04764e4869" code="admin.aiHelper.chatbot.modal.title" javaScriptEscape="true"/>
<spring:message var="autoMsg_f536dc3c59" code="admin.aiHelper.assistant.role.user" javaScriptEscape="true"/>
<spring:message var="autoMsg_961118a74b" code="admin.aiHelper.assistant.role.ai" javaScriptEscape="true"/>
<spring:message var="autoMsg_3228f27f7a" code="admin.aiHelper.chatbot.empty.messages" javaScriptEscape="true"/>
<spring:message var="autoMsg_9aa8803fb0" code="admin.aiHelper.chatbot.message.viewFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_365ca60365" code="admin.aiHelper.chatbot.message.viewError" javaScriptEscape="true"/>
<spring:message var="autoMsg_7c06265311" code="admin.aiHelper.chatbot.message.valueRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_edfbe8928b" code="admin.aiHelper.chatbot.message.createBlockSuccess" javaScriptEscape="true"/>
<spring:message var="autoMsg_9464caeb8a" code="admin.aiHelper.chatbot.message.createBlockFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_d83196636c" code="admin.aiHelper.chatbot.message.deactivateConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_46b714f717" code="admin.aiHelper.chatbot.message.deactivateFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_2327f380b3" code="admin.aiHelper.chatbot.message.blockUserConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_2c79dc3b8a" code="admin.aiHelper.chatbot.message.blockIpConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_a3e8d92b76" code="admin.aiHelper.chatbot.message.quickBlockReason" javaScriptEscape="true"/>
<spring:message var="autoMsg_8586d711f7" code="admin.aiHelper.chatbot.message.quotaSaved" javaScriptEscape="true"/>
<spring:message var="autoMsg_a004debca5" code="admin.aiHelper.chatbot.message.quotaSaveFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_c7ce1590d8" code="admin.aiHelper.chatbot.table.conversationId" javaScriptEscape="true"/>
<spring:message var="autoMsg_a0fa54dfff" code="admin.context.memberTitle"/>
<spring:message var="autoMsg_09faf2e48e" code="admin.common.loading"/>
<spring:message var="autoMsg_5c5d79cf47" code="admin.members.blockModalTitle"/>
<spring:message var="autoMsg_27cc41fba0" code="admin.context.action.blockType"/>
<spring:message var="autoMsg_c5d8fd6f42" code="admin.context.blockType.userOnly"/>
<spring:message var="autoMsg_8c64fa27a2" code="admin.context.blockType.ipOnly"/>
<spring:message var="autoMsg_15769734ac" code="admin.context.blockType.userIp"/>
<spring:message var="autoMsg_4a078a00e9" code="admin.members.blockedIpLabel"/>
<spring:message var="autoMsg_8538ef80a7" code="admin.context.action.blockIpPlaceholder"/>
<spring:message var="autoMsg_7ea641a2a0" code="admin.members.blockExpiresLabel"/>
<spring:message var="autoMsg_c2b02781fd" code="admin.members.blockReasonLabel"/>
<spring:message var="autoMsg_36a6ef4ecb" code="admin.context.action.reasonPlaceholder"/>
<spring:message var="autoMsg_2c0d0b5043" code="admin.context.action.applyBlock"/>
<spring:message var="autoMsg_d9a8845f7d" code="admin.common.loading" javaScriptEscape="true"/>
<spring:message var="autoMsg_ec7c0f9d97" code="admin.common.close" javaScriptEscape="true"/>
<spring:message var="autoMsg_d9f3d85eb5" code="admin.common.error" javaScriptEscape="true"/>
<spring:message var="autoMsg_1c3acc66fa" code="admin.common.yes" javaScriptEscape="true"/>
<spring:message var="autoMsg_0bb250d188" code="admin.common.no" javaScriptEscape="true"/>
<spring:message var="autoMsg_532f36149c" code="admin.members.none" javaScriptEscape="true"/>
<spring:message var="autoMsg_1d08ca9bfd" code="admin.members.noLinkedProvider" javaScriptEscape="true"/>
<spring:message var="autoMsg_d160f6da3f" code="admin.members.verifiedMember" javaScriptEscape="true"/>
<spring:message var="autoMsg_cc023e58ed" code="admin.members.unverifiedMember" javaScriptEscape="true"/>
<spring:message var="autoMsg_7d951366ce" code="admin.status.ACTIVE" javaScriptEscape="true"/>
<spring:message var="autoMsg_bf1d1a6d55" code="admin.status.DORMANT" javaScriptEscape="true"/>
<spring:message var="autoMsg_e407db387a" code="admin.status.BLOCKED" javaScriptEscape="true"/>
<spring:message var="autoMsg_cdb6a62812" code="admin.status.DELETED" javaScriptEscape="true"/>
<spring:message var="autoMsg_6a7f4ef6b7" code="admin.members.blockModalTitleSuffix" javaScriptEscape="true"/>
<spring:message var="autoMsg_44d04f3037" code="admin.members.blockResponseParseError" javaScriptEscape="true"/>
<spring:message var="autoMsg_c3401fc82b" code="admin.members.statusResponseParseError" javaScriptEscape="true"/>
<spring:message var="autoMsg_8d6d415aab" code="admin.members.roleResponseParseError" javaScriptEscape="true"/>
<spring:message var="autoMsg_2e105310c8" code="admin.members.blockTargetMissing" javaScriptEscape="true"/>
<spring:message var="autoMsg_71a3efcf07" code="admin.common.applying" javaScriptEscape="true"/>
<spring:message var="autoMsg_35eb4519fe" code="admin.context.toast.saveBlockSuccess" javaScriptEscape="true"/>
<spring:message var="autoMsg_9803cc470d" code="admin.context.memberTitle" javaScriptEscape="true"/>
<spring:message var="autoMsg_aedb01b12d" code="admin.members.detailTitleSuffix" javaScriptEscape="true"/>
<spring:message var="autoMsg_2bc04885f9" code="admin.context.tab.info" javaScriptEscape="true"/>
<spring:message var="autoMsg_6799adb9a7" code="admin.context.tab.logins" javaScriptEscape="true"/>
<spring:message var="autoMsg_65987a83f0" code="admin.context.tab.security" javaScriptEscape="true"/>
<spring:message var="autoMsg_a950657a16" code="admin.members.emailHistoryTab" javaScriptEscape="true"/>
<spring:message var="autoMsg_36cd735886" code="admin.context.tab.activity" javaScriptEscape="true"/>
<spring:message var="autoMsg_8f31c1b947" code="admin.context.tab.blocks" javaScriptEscape="true"/>
<spring:message var="autoMsg_7a816126e9" code="admin.context.tab.actions" javaScriptEscape="true"/>
<spring:message var="autoMsg_0a2f46973a" code="admin.role.USER" javaScriptEscape="true"/>
<spring:message var="autoMsg_f34987690b" code="admin.role.BUSINESS" javaScriptEscape="true"/>
<spring:message var="autoMsg_7cef6bcd99" code="admin.role.PARTNER" javaScriptEscape="true"/>
<spring:message var="autoMsg_0023796b3f" code="admin.role.BOT" javaScriptEscape="true"/>
<spring:message var="autoMsg_1fd3c9991d" code="admin.role.ADMIN" javaScriptEscape="true"/>
<spring:message var="autoMsg_f6d02ce1b2" code="admin.role.SUPERADMIN" javaScriptEscape="true"/>
<spring:message var="autoMsg_51197b6b62" code="admin.role.SYSTEM" javaScriptEscape="true"/>
<spring:message var="autoMsg_d519188fd7" code="admin.social.kakao" javaScriptEscape="true"/>
<spring:message var="autoMsg_039f2a034c" code="admin.social.naver" javaScriptEscape="true"/>
<spring:message var="autoMsg_329f00473b" code="admin.social.google" javaScriptEscape="true"/>
<spring:message var="autoMsg_c1757340af" code="admin.context.requireBlockedIp" javaScriptEscape="true"/>
<spring:message var="autoMsg_93595248e5" code="admin.context.toast.saveBlockFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_82e1a33bf4" code="admin.context.toast.saveBlockError" javaScriptEscape="true"/>
<spring:message var="autoMsg_28f618a732" code="admin.members.confirmStatusChangePrefix" javaScriptEscape="true"/>
<spring:message var="autoMsg_582b10f8bb" code="admin.members.confirmStatusChangeSuffix" javaScriptEscape="true"/>
<spring:message var="autoMsg_19cf8eca7c" code="admin.context.toast.saveStatusSuccess" javaScriptEscape="true"/>
<spring:message var="autoMsg_623997efab" code="admin.context.toast.saveStatusFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_22215b2645" code="admin.members.roleContextMissing" javaScriptEscape="true"/>
<spring:message var="autoMsg_4e2604dfa0" code="admin.members.roleAlreadySelected" javaScriptEscape="true"/>
<spring:message var="autoMsg_9b4937693e" code="admin.context.requireRoleReason" javaScriptEscape="true"/>
<spring:message var="autoMsg_fb4f5cdfe4" code="admin.members.confirmRoleChangeSuffix" javaScriptEscape="true"/>
<spring:message var="autoMsg_0205181e85" code="admin.context.toast.saveRoleSuccess" javaScriptEscape="true"/>
<spring:message var="autoMsg_81f079f9b9" code="admin.context.toast.saveRoleFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_09a531507e" code="admin.context.inputValue" javaScriptEscape="true"/>
<spring:message var="autoMsg_df50ec273f" code="admin.context.targetEmail" javaScriptEscape="true"/>
<spring:message var="autoMsg_655a03dee1" code="admin.context.empty.security" javaScriptEscape="true"/>
<spring:message var="autoMsg_9986173463" code="admin.context.requestEmail" javaScriptEscape="true"/>
<spring:message var="autoMsg_df8ae7b5a1" code="admin.context.empty.emailRequests" javaScriptEscape="true"/>
<spring:message var="autoMsg_9f0d4a80ab" code="admin.context.used" javaScriptEscape="true"/>
<spring:message var="autoMsg_ed5dbcfe96" code="admin.context.unused" javaScriptEscape="true"/>
<spring:message var="autoMsg_b67170d46b" code="admin.context.empty.emailTokens" javaScriptEscape="true"/>
<spring:message var="autoMsg_90d8ab0701" code="admin.context.uri" javaScriptEscape="true"/>
<spring:message var="autoMsg_4074aa5a05" code="admin.context.empty.activity" javaScriptEscape="true"/>
<spring:message var="autoMsg_5b658ed241" code="admin.common.reason" javaScriptEscape="true"/>
<spring:message var="autoMsg_53d8c44942" code="admin.context.empty.blocks" javaScriptEscape="true"/>
<spring:message var="autoMsg_3bea6f4cea" code="admin.context.action.profileTitle" javaScriptEscape="true"/>
<spring:message var="autoMsg_49d89a08e9" code="admin.context.nickname" javaScriptEscape="true"/>
<spring:message var="autoMsg_e1ee8c64a7" code="admin.context.nationality" javaScriptEscape="true"/>
<spring:message var="autoMsg_2da7e47509" code="admin.context.preferredLanguage" javaScriptEscape="true"/>
<spring:message var="autoMsg_2fa1ea1062" code="admin.context.action.saveProfile" javaScriptEscape="true"/>
<spring:message var="autoMsg_dfd54827df" code="admin.context.action.statusRoleTitle" javaScriptEscape="true"/>
<spring:message var="autoMsg_7f77d7a7de" code="admin.members.accountStatus" javaScriptEscape="true"/>
<spring:message var="autoMsg_84f506fa9a" code="admin.common.apply" javaScriptEscape="true"/>
<spring:message var="autoMsg_59e66372dd" code="admin.common.role" javaScriptEscape="true"/>
<spring:message var="autoMsg_cfa3e4044d" code="admin.context.action.roleReason" javaScriptEscape="true"/>
<spring:message var="autoMsg_2c82f9503e" code="admin.context.action.roleReasonPlaceholder" javaScriptEscape="true"/>
<spring:message var="autoMsg_7a77afbd32" code="admin.context.action.changeRole" javaScriptEscape="true"/>
<spring:message var="autoMsg_569502d33a" code="admin.context.action.quickBlockTitle" javaScriptEscape="true"/>
<spring:message var="autoMsg_657bacf516" code="admin.context.action.blockType" javaScriptEscape="true"/>
<spring:message var="autoMsg_b165aefc9e" code="admin.context.blockType.userOnly" javaScriptEscape="true"/>
<spring:message var="autoMsg_297ccdc718" code="admin.context.blockType.ipOnly" javaScriptEscape="true"/>
<spring:message var="autoMsg_e67eb06ea0" code="admin.context.blockType.userIp" javaScriptEscape="true"/>
<spring:message var="autoMsg_66a711eccb" code="admin.context.blockedIp" javaScriptEscape="true"/>
<spring:message var="autoMsg_777c217ebc" code="admin.context.action.blockIpPlaceholder" javaScriptEscape="true"/>
<spring:message var="autoMsg_de9550f28e" code="admin.context.action.blockExpires" javaScriptEscape="true"/>
<spring:message var="autoMsg_2be055d6af" code="admin.context.action.applyBlock" javaScriptEscape="true"/>
<spring:message var="autoMsg_8fd5232912" code="admin.context.tab.emailRequests" javaScriptEscape="true"/>
<spring:message var="autoMsg_8b8f445762" code="admin.context.tab.emailTokens" javaScriptEscape="true"/>
<spring:message var="autoMsg_2ff6f831e8" code="admin.context.memberNo" javaScriptEscape="true"/>
<spring:message var="autoMsg_901942cda3" code="admin.context.userId" javaScriptEscape="true"/>
<spring:message var="autoMsg_413c58e514" code="admin.context.email" javaScriptEscape="true"/>
<spring:message var="autoMsg_b7eb2dfc5d" code="admin.members.emailVerified" javaScriptEscape="true"/>
<spring:message var="autoMsg_f1ff1384e2" code="admin.members.emailLoginEnabled" javaScriptEscape="true"/>
<spring:message var="autoMsg_e7d9e4c5c4" code="admin.members.passwordLoginEnabled" javaScriptEscape="true"/>
<spring:message var="autoMsg_4ecfd939f8" code="admin.context.createdAt" javaScriptEscape="true"/>
<spring:message var="autoMsg_836ad37ce3" code="admin.members.socialLinked" javaScriptEscape="true"/>
<spring:message var="autoMsg_d8bf5f56e9" code="admin.members.loginSuccess" javaScriptEscape="true"/>
<spring:message var="autoMsg_1ce445ab81" code="admin.members.loginFailure" javaScriptEscape="true"/>
<spring:message var="autoMsg_21e9a18ffb" code="admin.context.lastLogin" javaScriptEscape="true"/>
<spring:message var="autoMsg_fe788d3d39" code="admin.context.empty.logins" javaScriptEscape="true"/>
<spring:message var="autoMsg_b9b4f87535" code="admin.logs.success" javaScriptEscape="true"/>
<spring:message var="autoMsg_005440f954" code="admin.logs.failure" javaScriptEscape="true"/>
<spring:message var="autoMsg_10c248e065" code="admin.common.time" javaScriptEscape="true"/>
<spring:message var="autoMsg_e5becd39c3" code="admin.logs.provider" javaScriptEscape="true"/>
<spring:message var="autoMsg_ef83b25be6" code="admin.logs.failReason" javaScriptEscape="true"/>
<spring:message var="autoMsg_761b84a10b" code="admin.common.ip" javaScriptEscape="true"/>
<spring:message var="autoMsg_7cb96542d5" code="admin.context.toast.saveProfileSuccess" javaScriptEscape="true"/>
<spring:message var="autoMsg_69eae2cf3d" code="admin.context.toast.saveProfileFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_d969ca6ccb" code="admin.context.toast.saveProfileError" javaScriptEscape="true"/>
<c:set var="activeMenu" value="aiHelper"/>
<spring:message code="admin.aiHelper.chatbot.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 챗봇 내부 sub-tab ── --%>
    <div class="aih-tabs" style="display:flex;gap:4px;border-bottom:1px solid #e5e7eb;margin:20px 0;">
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=dashboard"
           class="aih-tab ${tab == 'dashboard' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'dashboard' ? '700' : '500'};color:${tab == 'dashboard' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'dashboard' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.chatbot.tab.dashboard"/>
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=links"
           class="aih-tab ${tab == 'links' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'links' ? '700' : '500'};color:${tab == 'links' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'links' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            링크 클릭
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=inappropriate"
           class="aih-tab ${tab == 'inappropriate' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'inappropriate' ? '700' : '500'};color:${tab == 'inappropriate' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'inappropriate' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.chatbot.tab.inappropriate"/>
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=blocks"
           class="aih-tab ${tab == 'blocks' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'blocks' ? '700' : '500'};color:${tab == 'blocks' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'blocks' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.chatbot.tab.blocks"/>
        </a>
        <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=quotas"
           class="aih-tab ${tab == 'quotas' ? 'active' : ''}"
           style="padding:10px 16px;text-decoration:none;font-size:13px;font-weight:${tab == 'quotas' ? '700' : '500'};color:${tab == 'quotas' ? '#1d4ed8' : '#64748b'};border-bottom:2px solid ${tab == 'quotas' ? '#1d4ed8' : 'transparent'};margin-bottom:-1px;">
            <spring:message code="admin.aiHelper.chatbot.tab.quotas"/>
        </a>
    </div>

    <%-- ══════════════════════════════════════════
         대시보드 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'dashboard'}">
        <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;">
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">💬 ${autoMsg_b044513d01}</div>
                <div style="font-size:24px;font-weight:700;color:#38bdf8;">${totalConversations}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">📅 ${autoMsg_c5ed12cd73}</div>
                <div style="font-size:24px;font-weight:700;color:#10b981;">${todayConversations}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">⚠️ ${autoMsg_38fc999f60}</div>
                <div style="font-size:24px;font-weight:700;color:#fb923c;">${inappropriateCount}</div>
            </div>
            <div class="adm-card" style="padding:20px;">
                <div style="font-size:12px;color:#64748b;margin-bottom:6px;">⛔ ${autoMsg_a2c9244ccd}</div>
                <div style="font-size:24px;font-weight:700;color:#ef4444;">${activeBlockCount}</div>
            </div>
        </div>

        <%-- ── 대화 세션 목록 (대시보드 내 통합) ── --%>
        <div style="font-size:14px;font-weight:700;margin:8px 0 12px;">${autoMsg_e65b057767}</div>

        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <form method="get" action="${pageContext.request.contextPath}/admin/ai-helper/chatbot" style="display:flex;gap:8px;">
                <input type="hidden" name="tab" value="dashboard"/>
                <input type="text" name="keyword" value="${keyword}" placeholder="${autoMsg_88ad3487c3}" class="adm-input" style="flex:1;"/>
                <button type="submit" class="adm-btn">${autoMsg_a92d9b539d}</button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot" class="adm-btn adm-btn-ghost">${autoMsg_1b193ad4dc}</a>
                </c:if>
            </form>
            <div style="font-size:12px;color:#64748b;margin-top:8px;">${autoMsg_ddcd0ecda1}</div>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>${autoMsg_2f75dca1b5}</th>
                        <th>${autoMsg_27a7f3036c}</th>
                        <th>${autoMsg_a45db7c223}</th>
                        <th>${autoMsg_cfd18e97f4}</th>
                        <th>${autoMsg_96ba24dba9}</th>
                        <th>${autoMsg_91e2e03333}</th>
                        <th>${autoMsg_de2c9c4fa1}</th>
                        <th style="width:200px;">
                            <div style="display:flex;gap:4px;justify-content:flex-end;">
                                <span style="font-size:11px;padding:3px 8px;">${autoMsg_41bbb6a01d}</span>
                                <span style="font-size:11px;padding:3px 8px;visibility:hidden;">${autoMsg_3e959557b8}</span>
                                <span style="font-size:11px;padding:3px 8px;visibility:hidden;">${autoMsg_06cab51800}</span>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty conversations}">
                            <tr><td colspan="8" style="text-align:center;padding:40px;color:#94a3b8;">${autoMsg_048e7770e2}</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="c" items="${conversations}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">#${c.conversationId}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${c.title}</button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.userIdx != null}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${c.userIdx}">
                                                    ${autoMsg_2545d16e5e} #${c.userIdx}
                                                </button>
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;">${autoMsg_f5a85deeca}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-inline-link js-open-ip-context"
                                                data-ip-address="${c.ipAddress}"
                                                data-default-tab="blocks">${c.ipAddress}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${c.messageCount}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-conv-id="${c.conversationId}"
                                                onclick="viewMessages(this.dataset.convId)">${fn:replace(fn:substring(c.lastActive, 0, 16), 'T', ' ')}</button>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.isDeleted}">
                                                <button type="button"
                                                        class="adm-cell-link adm-cell-link--inline"
                                                        data-conv-id="${c.conversationId}"
                                                        onclick="viewMessages(this.dataset.convId)"
                                                        style="color:#ef4444;">${autoMsg_d0a646007a}</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button"
                                                        class="adm-cell-link adm-cell-link--inline"
                                                        data-conv-id="${c.conversationId}"
                                                        onclick="viewMessages(this.dataset.convId)"
                                                        style="color:#10b981;">${autoMsg_a0911576a4}</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align:right;">
                                        <div class="adm-row-actions">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-conv-id="${c.conversationId}"
                                                    onclick="viewMessages(this.dataset.convId)">${autoMsg_efe9a9c736}</button>
                                            <div class="action-menu-wrap">
                                                <button type="button"
                                                        class="adm-row-btn detail adm-row-btn-more"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu">
                                                    <c:if test="${c.userIdx != null}">
                                                        <button type="button"
                                                                class="action-menu-item"
                                                                data-block-value="${c.userIdx}"
                                                                onclick="blockUser(this.dataset.blockValue)">${autoMsg_3e959557b8}</button>
                                                    </c:if>
                                                    <button type="button"
                                                            class="action-menu-item"
                                                            data-block-value="${c.ipAddress}"
                                                            onclick="blockIp(this.dataset.blockValue)">${autoMsg_06cab51800}</button>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <%-- 페이징 --%>
        <c:if test="${totalPages > 1}">
            <div style="display:flex;justify-content:center;gap:4px;margin-top:16px;">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=dashboard&page=${p}&keyword=${keyword}" class="adm-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}" style="min-width:32px;">${p}</a>
                </c:forEach>
            </div>
        </c:if>

    </c:if>

    <%-- ══════════════════════════════════════════
         링크 클릭 분석 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'links'}">
        <%-- 기간 필터 --%>
        <div class="adm-card" style="padding:14px 16px;margin-bottom:16px;display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
            <div style="font-size:13px;color:#475569;font-weight:600;">기간</div>
            <c:forEach var="d" items="7,30,90,365">
                <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=links&days=${d}"
                   class="adm-btn ${rangeDays == d ? 'adm-btn-primary' : 'adm-btn-ghost'}"
                   style="font-size:12px;padding:4px 12px;">
                    최근 ${d}일
                </a>
            </c:forEach>
            <div style="margin-left:auto;font-size:12px;color:#64748b;">
                총 <strong style="color:#1d4ed8;">${totalClicks}</strong> 건
            </div>
        </div>

        <%-- 일별 추이 (CSS 막대) --%>
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <div style="font-size:13px;font-weight:700;color:#1e293b;margin-bottom:12px;">📈 일별 클릭 추이</div>
            <c:choose>
                <c:when test="${empty dailyTrend}">
                    <div style="padding:24px;text-align:center;color:#94a3b8;font-size:13px;">데이터가 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <c:set var="maxCount" value="0"/>
                    <c:forEach var="row" items="${dailyTrend}">
                        <c:if test="${row.clickCount > maxCount}">
                            <c:set var="maxCount" value="${row.clickCount}"/>
                        </c:if>
                    </c:forEach>
                    <div style="display:flex;align-items:flex-end;gap:3px;height:140px;overflow-x:auto;padding-bottom:4px;">
                        <c:forEach var="row" items="${dailyTrend}">
                            <c:set var="pct" value="${maxCount > 0 ? (row.clickCount * 100 / maxCount) : 0}"/>
                            <div style="flex:0 0 32px;display:flex;flex-direction:column;align-items:center;gap:4px;" title="${row.clickDate}: ${row.clickCount}">
                                <div style="font-size:10px;color:#64748b;">${row.clickCount}</div>
                                <div style="width:22px;height:${pct}%;min-height:2px;background:linear-gradient(180deg,#60a5fa,#2563eb);border-radius:3px 3px 0 0;"></div>
                                <div style="font-size:9px;color:#94a3b8;font-family:monospace;transform:rotate(-45deg);transform-origin:center;white-space:nowrap;margin-top:6px;">
                                    ${fn:substring(row.clickDate, 5, 10)}
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- 상위 URL 랭킹 --%>
        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <div style="padding:14px 16px;border-bottom:1px solid #e5e7eb;font-size:13px;font-weight:700;color:#1e293b;">
                🔝 상위 클릭 URL (최대 20개)
            </div>
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th style="width:48px;">순위</th>
                        <th>URL</th>
                        <th style="width:120px;text-align:right;">클릭 수</th>
                        <th style="width:240px;">분포</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty topUrls}">
                            <tr><td colspan="4" style="text-align:center;padding:40px;color:#94a3b8;">데이터가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:set var="rankTopCount" value="${topUrls[0].clickCount}"/>
                            <c:forEach var="row" items="${topUrls}" varStatus="st">
                                <c:set var="pct" value="${rankTopCount > 0 ? (row.clickCount * 100 / rankTopCount) : 0}"/>
                                <tr>
                                    <td><strong>${st.index + 1}</strong></td>
                                    <td style="font-family:monospace;font-size:12px;word-break:break-all;">
                                        <a href="${pageContext.request.contextPath}${row.url}" target="_blank" style="color:#1d4ed8;text-decoration:none;">${row.url}</a>
                                    </td>
                                    <td style="text-align:right;font-weight:600;">
                                        <button type="button" class="adm-btn adm-btn-ghost" style="font-size:12px;padding:3px 10px;"
                                                data-url="${row.url}" onclick="viewClickersByUrl(this.dataset.url)">
                                            ${row.clickCount}
                                        </button>
                                    </td>
                                    <td>
                                        <div style="width:100%;height:8px;background:#e5e7eb;border-radius:4px;overflow:hidden;">
                                            <div style="width:${pct}%;height:100%;background:linear-gradient(90deg,#60a5fa,#2563eb);"></div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </c:if>

    <%-- ══════════════════════════════════════════
         부적절 메시지 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'inappropriate'}">
        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>${autoMsg_2f75dca1b5}</th>
                        <th>작성자</th>
                        <th>${autoMsg_4cf560b97d}</th>
                        <th>${autoMsg_8ec7cce7ae}</th>
                        <th>${autoMsg_41bbb6a01d}</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty messages}">
                            <tr><td colspan="5" style="text-align:center;padding:40px;color:#94a3b8;">${autoMsg_3d169ad991}</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${messages}">
                                <tr>
                                    <td>${m.messageId}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty m.authorUserIdx}">
                                                <a href="javascript:void(0);"
                                                   onclick="openDetail('${m.authorUserIdx}'); return false;"
                                                   style="color:#1d4ed8;text-decoration:none;font-weight:500;cursor:pointer;"
                                                   title="회원 상세 보기">
                                                    <c:choose>
                                                        <c:when test="${not empty m.authorNickname}">${m.authorNickname}</c:when>
                                                        <c:otherwise>#${m.authorUserIdx}</c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </c:when>
                                            <c:otherwise><span style="color:#94a3b8;">게스트</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="max-width:600px;word-break:break-all;">${m.content}</td>
                                    <td>${fn:replace(fn:substring(m.createdAt, 0, 16), 'T', ' ')}</td>
                                    <td>
                                        <div class="adm-row-actions is-single">
                                            <button type="button"
                                                    class="adm-row-btn detail"
                                                    data-conv-id="${m.conversationId}"
                                                    onclick="viewMessages(this.dataset.convId)">${autoMsg_fc6d23c55c}</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        <c:if test="${totalPages > 1}">
            <div style="display:flex;justify-content:center;gap:4px;margin-top:16px;">
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <a href="${pageContext.request.contextPath}/admin/ai-helper/chatbot?tab=inappropriate&page=${p}" class="adm-btn ${p == page ? 'adm-btn-primary' : 'adm-btn-ghost'}" style="min-width:32px;">${p}</a>
                </c:forEach>
            </div>
        </c:if>
    </c:if>

    <%-- ══════════════════════════════════════════
         차단 관리 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'blocks'}">
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <div style="display:flex;gap:8px;align-items:end;">
                <div style="flex:1;">
                    <label style="font-size:12px;font-weight:600;display:block;margin-bottom:4px;">${autoMsg_ce1899fbd6}</label>
                    <select id="newBlockType" class="adm-input">
                        <option value="IP">${autoMsg_e1ac1bc532}</option>
                        <option value="USER">${autoMsg_bb65e972fc}</option>
                    </select>
                </div>
                <div style="flex:2;">
                    <label style="font-size:12px;font-weight:600;display:block;margin-bottom:4px;">${autoMsg_97c89b9bce}</label>
                    <input type="text" id="newBlockValue" class="adm-input" placeholder="${autoMsg_268d704cb2}"/>
                </div>
                <div style="flex:2;">
                    <label style="font-size:12px;font-weight:600;display:block;margin-bottom:4px;">${autoMsg_77dec33b00}</label>
                    <input type="text" id="newBlockReason" class="adm-input" placeholder="${autoMsg_f5f3920815}"/>
                </div>
                <button type="button" class="adm-btn adm-btn-primary" onclick="createBlock()">${autoMsg_e54e759a71}</button>
            </div>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>${autoMsg_2f75dca1b5}</th>
                        <th>${autoMsg_ce1899fbd6}</th>
                        <th>${autoMsg_97c89b9bce}</th>
                        <th>${autoMsg_77dec33b00}</th>
                        <th>${autoMsg_b6fd656a80}</th>
                        <th>${autoMsg_bde0c1c278}</th>
                        <th>${autoMsg_1522384987}</th>
                        <th>${autoMsg_de2c9c4fa1}</th>
                        <th>${autoMsg_41bbb6a01d}</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty blocks}">
                            <tr><td colspan="9" style="text-align:center;padding:40px;color:#94a3b8;">${autoMsg_a2e4e48369}</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="b" items="${blocks}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">#${b.blockId}</button>
                                    </td>
                                    <td>${b.blockType}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.blockType eq 'IP'}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-ip-context"
                                                        data-ip-address="${b.blockValue}"
                                                        data-default-tab="blocks">${b.blockValue}</button>
                                            </c:when>
                                            <c:when test="${b.blockType eq 'USER'}">
                                                <button type="button"
                                                        class="adm-inline-link js-open-member-context"
                                                        data-user-idx="${b.blockValue}">${b.blockValue}</button>
                                            </c:when>
                                            <c:otherwise>${b.blockValue}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">${b.reason}</button>
                                    </td>
                                    <td>${b.blockedBy}</td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">${fn:replace(fn:substring(b.blockedAt, 0, 16), 'T', ' ')}</button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">
                                        <c:choose>
                                            <c:when test="${b.expiresAt != null}">${fn:replace(fn:substring(b.expiresAt, 0, 16), 'T', ' ')}</c:when>
                                            <c:otherwise>${autoMsg_c03aa9eb82}</c:otherwise>
                                        </c:choose>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                data-block-id="${b.blockId}"
                                                onclick="deactivateBlock(this.dataset.blockId)">
                                        <c:choose>
                                            <c:when test="${b.isActive}"><span style="color:#ef4444;">${autoMsg_a0911576a4}</span></c:when>
                                            <c:otherwise><span style="color:#94a3b8;">${autoMsg_a151681abe}</span></c:otherwise>
                                        </c:choose>
                                        </button>
                                    </td>
                                    <td>
                                        <c:if test="${b.isActive}">
                                            <div class="adm-row-actions is-single">
                                                <button type="button"
                                                        class="adm-row-btn danger"
                                                        data-block-id="${b.blockId}"
                                                        onclick="deactivateBlock(this.dataset.blockId)">${autoMsg_8287c856a5}</button>
                                            </div>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </c:if>

    <%-- ══════════════════════════════════════════
         정책 (등급별 한도) 탭
    ══════════════════════════════════════════ --%>
    <c:if test="${tab == 'quotas'}">
        <style>
            tr[data-quota-id].is-dirty td:first-child { box-shadow: inset 3px 0 0 0 #2563eb; }
            tr[data-quota-id].is-dirty td { background: rgba(37, 99, 235, .04); }
        </style>
        <div class="adm-card" style="padding:16px;margin-bottom:16px;">
            <div style="font-size:13px;color:#475569;line-height:1.6;">
                ${autoMsg_046c3e678c}<br>
                <spring:message code="admin.aiHelper.chatbot.description.quotaSub"/>
            </div>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                    <tr>
                        <th>등급</th>
                        <th>동시 대화 수</th>
                        <th>주기당 메시지 한도</th>
                        <th>AI 컨텍스트 길이</th>
                        <th title="리셋 주기">주기(일)</th>
                        <th title="주기 시작(리셋) 시각 HH:MM">리셋 시각</th>
                        <th title="대화 삭제 시 그 대화에서 쓴 현재 주기 내 메시지 수만큼 한도 환급">환급 허용</th>
                        <th>마지막 수정자</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="q" items="${quotas}">
                        <tr data-quota-id="${q.quotaId}">
                            <td><strong>${q.grade}</strong></td>
                            <td><input type="number" class="adm-input q-conv" value="${q.maxConversations}" data-original="${q.maxConversations}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td><input type="number" class="adm-input q-msg" value="${q.maxMessagesPerPeriod}" data-original="${q.maxMessagesPerPeriod}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td><input type="number" class="adm-input q-ctx" value="${q.maxContextMessages}" data-original="${q.maxContextMessages}" style="width:80px;padding:6px 10px;font-size:13px;"/></td>
                            <td>
                                <select class="adm-input q-period" data-original="${q.periodDays}" style="width:72px;padding:6px 10px;font-size:13px;">
                                    <c:forEach var="d" items="1,2,3,4,5,7,14,30">
                                        <option value="${d}" ${q.periodDays == d ? 'selected' : ''}>${d}일</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td>
                                <select class="adm-input q-reset-h" data-original="${q.resetHour}" style="width:64px;padding:6px 8px;font-size:13px;">
                                    <c:forEach var="h" begin="0" end="23">
                                        <option value="${h}" ${q.resetHour == h ? 'selected' : ''}>
                                            <fmt:formatNumber value="${h}" minIntegerDigits="2"/>
                                        </option>
                                    </c:forEach>
                                </select>
                                <span style="padding:0 2px;">:</span>
                                <select class="adm-input q-reset-m" data-original="${q.resetMinute}" style="width:64px;padding:6px 8px;font-size:13px;">
                                    <c:forEach var="m" begin="0" end="59">
                                        <option value="${m}" ${q.resetMinute == m ? 'selected' : ''}>
                                            <fmt:formatNumber value="${m}" minIntegerDigits="2"/>
                                        </option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td style="text-align:center;">
                                <input type="checkbox" class="q-refund" ${q.quotaRefundEnabled ? 'checked' : ''} data-original="${q.quotaRefundEnabled ? 'true' : 'false'}" style="width:18px;height:18px;cursor:pointer;"/>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty q.updatedBy}">
                                        <a class="quota-updater"
                                           href="javascript:void(0);"
                                           onclick="openDetail('${q.updatedBy}'); return false;"
                                           style="color:#1d4ed8;text-decoration:none;font-weight:500;cursor:pointer;"
                                           title="회원 상세 보기">
                                            <c:choose>
                                                <c:when test="${not empty q.updaterNickname}">${q.updaterNickname}</c:when>
                                                <c:otherwise>#${q.updatedBy}</c:otherwise>
                                            </c:choose>
                                        </a>
                                    </c:when>
                                    <c:otherwise><span style="color:#94a3b8;">-</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <%-- 전체 저장 / 기본값 복원 (원본으로 되돌리기) --%>
        <div style="margin-top:16px;display:flex;justify-content:flex-end;gap:8px;align-items:center;">
            <span id="quotaDirtyHint" style="font-size:12px;color:#64748b;"></span>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="resetQuotasToOriginal()"
                    title="불러온 DB 값으로 모두 되돌립니다">기본값 복원</button>
            <button type="button" class="adm-btn adm-btn-primary" onclick="saveAllQuotas()">전체 저장</button>
        </div>
    </c:if>

</div>

<%-- URL 별 클릭자 목록 모달 --%>
<div id="clickersModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:9999;align-items:center;justify-content:center;">
    <div style="background:#fff;width:780px;max-width:92vw;max-height:82vh;border-radius:12px;overflow:hidden;display:flex;flex-direction:column;">
        <div style="padding:16px;border-bottom:1px solid #e5e7eb;display:flex;justify-content:space-between;align-items:center;gap:12px;">
            <h3 id="clickersModalTitle" style="margin:0;font-size:15px;flex:1;word-break:break-all;">URL 클릭자 목록</h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('clickersModal').style.display='none'">닫기</button>
        </div>
        <div id="clickersModalBody" style="padding:16px;overflow-y:auto;flex:1;"></div>
    </div>
</div>

<%-- 대화 메시지 조회 모달 --%>
<div id="msgModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:9999;align-items:center;justify-content:center;">
    <div style="background:#fff;width:700px;max-width:90vw;max-height:80vh;border-radius:12px;overflow:hidden;display:flex;flex-direction:column;">
        <div style="padding:16px;border-bottom:1px solid #e5e7eb;display:flex;justify-content:space-between;align-items:center;">
            <h3 id="msgModalTitle" style="margin:0;font-size:16px;">${autoMsg_831e51c6fe}</h3>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="document.getElementById('msgModal').style.display='none'">${autoMsg_50d441663e}</button>
        </div>
        <div id="msgModalBody" style="padding:16px;overflow-y:auto;flex:1;"></div>
    </div>
</div>

<script>
(function () {
    const ctx = '${pageContext.request.contextPath}';
    const chatbotMessages = {
        modalTitle: '${autoMsg_04764e4869}',
        roleUser: '${autoMsg_f536dc3c59}',
        roleAi: '${autoMsg_961118a74b}',
        emptyMessages: '${autoMsg_3228f27f7a}',
        viewFailed: '${autoMsg_9aa8803fb0}',
        viewError: '${autoMsg_365ca60365}',
        valueRequired: '${autoMsg_7c06265311}',
        createBlockSuccess: '${autoMsg_edfbe8928b}',
        createBlockFailed: '${autoMsg_9464caeb8a}',
        deactivateConfirm: '${autoMsg_d83196636c}',
        deactivateFailed: '${autoMsg_46b714f717}',
        blockUserConfirm: '${autoMsg_2327f380b3}',
        blockIpConfirm: '${autoMsg_2c79dc3b8a}',
        quickBlockReason: '${autoMsg_a3e8d92b76}',
        quotaSaved: '${autoMsg_8586d711f7}',
        quotaSaveFailed: '${autoMsg_a004debca5}',
        conversationLabel: '${autoMsg_c7ce1590d8}'
    };

    window.viewMessages = async function (convId) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/conversations/' + convId + '/messages');
            const data = await res.json();
            if (!data.success) { alert(chatbotMessages.viewFailed); return; }
            document.getElementById('msgModalTitle').textContent =
                chatbotMessages.conversationLabel + ' #' + convId + ' — ' + (data.conversation.title || '');

            // messageId → [click, ...] 매핑
            const clicksByMsg = {};
            (data.linkClicks || []).forEach(function (c) {
                const key = String(c.messageId);
                if (!clicksByMsg[key]) clicksByMsg[key] = [];
                clicksByMsg[key].push(c);
            });
            const totalClicks = (data.linkClicks || []).length;

            const msgHtml = (data.messages || []).map(function (m) {
                const role = m.role === 'user' ? chatbotMessages.roleUser : chatbotMessages.roleAi;
                const color = m.role === 'user' ? '#1d4ed8' : '#0f766e';
                const flag = m.isInappropriate ? ' ⚠️' : '';
                const body = m.role === 'assistant'
                    ? renderAssistantContent(m.content)
                    : '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + escHtml(m.content || '') + '</div>';
                const clicks = m.role === 'assistant' ? (clicksByMsg[String(m.messageId)] || []) : [];
                const badge = clicks.length > 0
                    ? '<span style="margin-left:6px;display:inline-block;font-size:10px;font-weight:700;color:#1d4ed8;background:#dbeafe;padding:1px 7px;border-radius:10px;">👆 ' + clicks.length + '</span>'
                    : '';
                let perMsgDetail = '';
                if (clicks.length > 0) {
                    perMsgDetail = '<div style="margin-top:8px;padding:6px 8px;background:#eff6ff;border-radius:6px;">' +
                                   '<div style="font-size:10px;color:#1d4ed8;font-weight:700;margin-bottom:4px;">이 메시지의 클릭 이력</div>';
                    clicks.forEach(function (c) {
                        perMsgDetail += '<div style="font-size:11px;color:#334155;">• ' +
                                        escHtml(c.label || '-') +
                                        ' <span style="color:#64748b;font-family:monospace;">' + escHtml(c.url || '') + '</span>' +
                                        ' <span style="color:#94a3b8;">(' + escHtml(formatClickTime(c.clickedAt)) + ')</span>' +
                                        '</div>';
                    });
                    perMsgDetail += '</div>';
                }
                return '<div style="margin-bottom:12px;padding:10px;border-left:3px solid ' + color + ';background:#f8fafc;">' +
                       '<div style="font-size:11px;color:' + color + ';font-weight:600;">' + role + flag + badge + '</div>' +
                       body +
                       perMsgDetail +
                       '</div>';
            }).join('');

            const summary = '<div style="margin-bottom:12px;font-size:12px;color:#64748b;">' +
                            '총 메시지 <strong style="color:#1e293b;">' + (data.messages || []).length + '</strong>건 · ' +
                            '링크 클릭 <strong style="color:#1d4ed8;">' + totalClicks + '</strong>건' +
                            '</div>';

            document.getElementById('msgModalBody').innerHTML = summary + (msgHtml || '<div>' + chatbotMessages.emptyMessages + '</div>');
            document.getElementById('msgModal').style.display = 'flex';
        } catch (e) { alert(chatbotMessages.viewError); }
    };

    function formatClickTime(s) {
        if (!s) return '';
        const str = String(s);
        return str.length >= 16 ? str.substring(0, 16).replace('T', ' ') : str;
    }

    // URL 별 클릭자 목록 모달
    window.viewClickersByUrl = async function (url) {
        try {
            const res = await fetch(ctx + '/admin/ai-helper/chatbot/clicks/by-url?url=' + encodeURIComponent(url));
            const data = await res.json();
            if (!data.success) { alert('조회 실패'); return; }
            document.getElementById('clickersModalTitle').textContent = 'URL 클릭자 — ' + url;
            const rows = (data.clickers || []);
            if (rows.length === 0) {
                document.getElementById('clickersModalBody').innerHTML =
                    '<div style="padding:40px;text-align:center;color:#94a3b8;">클릭 이력이 없습니다.</div>';
            } else {
                let html = '<table class="adm-table" style="width:100%;font-size:12px;">' +
                           '<thead><tr>' +
                           '<th>시각</th><th>유저</th><th>세션</th><th>IP</th><th>대화</th><th>메시지</th>' +
                           '</tr></thead><tbody>';
                rows.forEach(function (r) {
                    const userText = r.userIdx
                        ? (escHtml(r.nickname || '') + ' <span style="color:#94a3b8;font-size:10px;">#' + r.userIdx + '</span>')
                        : '<span style="color:#94a3b8;">게스트</span>';
                    const anon = r.anonSessionId ? ('<span style="color:#64748b;font-family:monospace;font-size:10px;">' + escHtml(String(r.anonSessionId).substring(0, 12)) + '…</span>') : '-';
                    html += '<tr>' +
                            '<td style="white-space:nowrap;">' + escHtml(formatClickTime(r.clickedAt)) + '</td>' +
                            '<td>' + userText + '</td>' +
                            '<td>' + anon + '</td>' +
                            '<td style="font-family:monospace;">' + escHtml(r.ipAddress || '-') + '</td>' +
                            '<td>#' + escHtml(r.conversationId) + '</td>' +
                            '<td>#' + escHtml(r.messageId) + '</td>' +
                            '</tr>';
                });
                html += '</tbody></table>';
                html = '<div style="font-size:12px;color:#64748b;margin-bottom:10px;">총 <strong style="color:#1d4ed8;">' + rows.length + '</strong>건 (최대 100)</div>' + html;
                document.getElementById('clickersModalBody').innerHTML = html;
            }
            document.getElementById('clickersModal').style.display = 'flex';
        } catch (e) { alert('조회 중 오류'); }
    };

    // assistant 메시지 content 렌더링
    //   - JSON 파싱 성공: message 텍스트 + links + quickReplies + inappropriate 를 블록으로 분리 표시
    //   - 파싱 실패 (구버전 단순 텍스트): 원문 그대로
    function renderAssistantContent(raw) {
        if (raw == null) return '';
        let parsed = null;
        try {
            const maybe = JSON.parse(raw);
            if (maybe && typeof maybe === 'object' && typeof maybe.message === 'string') parsed = maybe;
        } catch (e) {}

        if (!parsed) {
            return '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + escHtml(raw) + '</div>';
        }

        let out = '<div style="font-size:13px;margin-top:4px;white-space:pre-wrap;">' + escHtml(parsed.message) + '</div>';

        if (parsed.inappropriate === true) {
            out += '<div style="margin-top:6px;display:inline-block;font-size:11px;font-weight:700;color:#b91c1c;background:#fee2e2;border:1px solid #fecaca;padding:2px 8px;border-radius:10px;">⚠️ inappropriate</div>';
        }

        if (Array.isArray(parsed.links) && parsed.links.length > 0) {
            out += '<div style="margin-top:8px;font-size:11px;color:#64748b;font-weight:600;">🔗 제시된 링크</div>';
            out += '<div style="margin-top:4px;display:flex;flex-direction:column;gap:3px;">';
            parsed.links.forEach(function (l) {
                const label = escHtml(l.label || '');
                const url = escHtml(l.url || '');
                const icon = escHtml(l.icon || '→');
                out += '<div style="font-size:12px;">' +
                       '<span style="margin-right:4px;">' + icon + '</span>' +
                       '<span style="color:#1e293b;font-weight:500;">' + label + '</span>' +
                       '<span style="margin-left:6px;color:#94a3b8;font-family:monospace;font-size:11px;">' + url + '</span>' +
                       '</div>';
            });
            out += '</div>';
        }

        if (Array.isArray(parsed.quickReplies) && parsed.quickReplies.length > 0) {
            out += '<div style="margin-top:8px;font-size:11px;color:#64748b;font-weight:600;">💬 빠른 답변</div>';
            out += '<div style="margin-top:4px;display:flex;flex-wrap:wrap;gap:4px;">';
            parsed.quickReplies.forEach(function (q) {
                out += '<span style="font-size:11px;background:#eff6ff;color:#1d4ed8;border:1px solid #dbeafe;padding:2px 8px;border-radius:10px;">' +
                       escHtml(q) + '</span>';
            });
            out += '</div>';
        }

        return out;
    }

    function escHtml(s) {
        return String(s == null ? '' : s)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;');
    }

    window.createBlock = async function () {
        const type   = document.getElementById('newBlockType').value;
        const value  = document.getElementById('newBlockValue').value.trim();
        const reason = document.getElementById('newBlockReason').value.trim();
        if (!value) { alert(chatbotMessages.valueRequired); return; }
        const res = await fetch(ctx + '/admin/ai-helper/blocks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ blockType: type, blockValue: value, reason: reason })
        });
        const data = await res.json();
        if (data.success) { alert(chatbotMessages.createBlockSuccess); location.reload(); }
        else alert(chatbotMessages.createBlockFailed + ': ' + (data.message || ''));
    };

    window.deactivateBlock = async function (blockId) {
        if (!confirm(chatbotMessages.deactivateConfirm)) return;
        const res = await fetch(ctx + '/admin/ai-helper/blocks/' + blockId + '/deactivate', { method: 'POST' });
        const data = await res.json();
        if (data.success) location.reload();
        else alert(chatbotMessages.deactivateFailed);
    };

    window.blockUser = function (userIdx) {
        if (!confirm(chatbotMessages.blockUserConfirm)) return;
        doQuickBlock('USER', String(userIdx));
    };
    window.blockIp = function (ip) {
        if (!confirm(chatbotMessages.blockIpConfirm.replace('{0}', ip))) return;
        doQuickBlock('IP', ip);
    };
    async function doQuickBlock(type, value) {
        const res = await fetch(ctx + '/admin/ai-helper/blocks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ blockType: type, blockValue: value, reason: chatbotMessages.quickBlockReason })
        });
        const data = await res.json();
        alert(data.success ? chatbotMessages.createBlockSuccess : chatbotMessages.createBlockFailed);
    }

    // 행별 dirty 여부 계산 (input + select 모두)
    function isRowDirty(row) {
        const els = row.querySelectorAll('input[data-original], select[data-original]');
        for (const el of els) {
            if (el.type === 'checkbox') {
                const original = el.dataset.original === 'true';
                if (el.checked !== original) return true;
            } else {
                if (String(el.value) !== String(el.dataset.original)) return true;
            }
        }
        return false;
    }

    function updateDirtyHint() {
        const hint = document.getElementById('quotaDirtyHint');
        if (!hint) return;
        const dirtyRows = document.querySelectorAll('tr[data-quota-id]');
        let count = 0;
        dirtyRows.forEach(function (row) {
            if (isRowDirty(row)) {
                row.classList.add('is-dirty');
                count++;
            } else {
                row.classList.remove('is-dirty');
            }
        });
        hint.textContent = count > 0 ? ('변경된 행 ' + count + '개') : '';
    }

    // 입력 변경 감지 바인딩 (input + select)
    document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
        el.addEventListener('input', updateDirtyHint);
        el.addEventListener('change', updateDirtyHint);
    });

    // 기본값 복원 — 모든 필드를 최초 로드 값으로 되돌림
    window.resetQuotasToOriginal = function () {
        let reverted = 0;
        document.querySelectorAll('tr[data-quota-id] input[data-original], tr[data-quota-id] select[data-original]').forEach(function (el) {
            if (el.type === 'checkbox') {
                const target = el.dataset.original === 'true';
                if (el.checked !== target) { el.checked = target; reverted++; }
            } else {
                if (String(el.value) !== String(el.dataset.original)) { el.value = el.dataset.original; reverted++; }
            }
        });
        updateDirtyHint();
        if (reverted === 0) alert('되돌릴 변경 사항이 없습니다.');
    };

    // 전체 저장 — 변경된 행만 순차 저장
    window.saveAllQuotas = async function () {
        const rows = Array.from(document.querySelectorAll('tr[data-quota-id]'));
        const dirtyRows = rows.filter(isRowDirty);
        if (dirtyRows.length === 0) {
            alert('변경 사항이 없습니다.');
            return;
        }
        const tasks = dirtyRows.map(function (row) {
            const quotaId = row.dataset.quotaId;
            const payload = {
                maxConversations:     parseInt(row.querySelector('.q-conv').value, 10),
                maxMessagesPerPeriod: parseInt(row.querySelector('.q-msg').value, 10),
                maxContextMessages:   parseInt(row.querySelector('.q-ctx').value, 10),
                periodDays:           parseInt(row.querySelector('.q-period').value, 10),
                resetHour:            parseInt(row.querySelector('.q-reset-h').value, 10),
                resetMinute:          parseInt(row.querySelector('.q-reset-m').value, 10),
                quotaRefundEnabled:   row.querySelector('.q-refund').checked
            };
            return fetch(ctx + '/admin/ai-helper/quotas/' + quotaId, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            }).then(function (res) { return res.json(); });
        });

        try {
            const results = await Promise.all(tasks);
            const failed = results.filter(function (r) { return !r.success; }).length;
            if (failed === 0) {
                alert('전체 ' + results.length + '건 저장 완료');
                location.reload();
            } else {
                alert('일부 저장 실패 (' + failed + '/' + results.length + '). 새로고침 후 재시도해 주세요.');
            }
        } catch (e) {
            alert('저장 중 오류가 발생했습니다.');
        }
    };
})();
</script>

<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="modalTitle">${autoMsg_a0fa54dfff}</div>
            <button class="adm-modal-close" onclick="closeDetail()">✕</button>
        </div>
        <div class="adm-modal-body" id="modalBody">
            <div style="text-align:center;padding:40px;color:#475569;">${autoMsg_09faf2e48e}</div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeDetail()">${autoMsg_50d441663e}</button>
        </div>
    </div>
</div>


<div class="adm-modal-overlay" id="blockModal">
    <div class="adm-modal" style="max-width:520px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockModalTitle">${autoMsg_5c5d79cf47}</div>
            <button class="adm-modal-close" onclick="closeBlockModal()">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="blockUserIdx">
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label">${autoMsg_27cc41fba0}</label>
                <select id="blockType" class="adm-select" style="width:100%;" onchange="handleBlockTypeChange()">
                    <option value="USER_ONLY">${autoMsg_c5d8fd6f42}</option>
                    <option value="IP_ONLY">${autoMsg_8c64fa27a2}</option>
                    <option value="USER_IP">${autoMsg_15769734ac}</option>
                </select>
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label">${autoMsg_4a078a00e9}</label>
                <input id="blockedIp" class="adm-input" type="text" placeholder="${autoMsg_8538ef80a7}">
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label">${autoMsg_7ea641a2a0}</label>
                <input id="blockedUntil" class="adm-input" type="datetime-local">
            </div>
            <div class="form-group">
                <label class="form-label">${autoMsg_c2b02781fd}</label>
                <textarea id="blockedReason" class="adm-input" style="min-height:90px;resize:vertical;" placeholder="${autoMsg_36a6ef4ecb}"></textarea>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeBlockModal()">${autoMsg_50d441663e}</button>
            <button id="blockSubmitBtn" class="adm-btn adm-btn-primary" type="button" onclick="submitBlock()">${autoMsg_2c0d0b5043}</button>
        </div>
    </div>
</div>

<script>
const ctx = '${pageContext.request.contextPath}';
const ADMIN_MEMBER_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const ADMIN_MEMBER_MSG = {
    loading: '${autoMsg_d9a8845f7d}',
    close: '${autoMsg_ec7c0f9d97}',
    error: '${autoMsg_d9f3d85eb5}',
    yes: '${autoMsg_1c3acc66fa}',
    no: '${autoMsg_0bb250d188}',
    none: '${autoMsg_532f36149c}',
    noLinkedProvider: '${autoMsg_1d08ca9bfd}',
    verifiedMember: '${autoMsg_d160f6da3f}',
    unverifiedMember: '${autoMsg_cc023e58ed}',
    statusActive: '${autoMsg_7d951366ce}',
    statusDormant: '${autoMsg_bf1d1a6d55}',
    statusBlocked: '${autoMsg_e407db387a}',
    statusDeleted: '${autoMsg_cdb6a62812}',
    blockModalTitleSuffix: '${autoMsg_6a7f4ef6b7}',
    parsingBlockResponse: '${autoMsg_44d04f3037}',
    parsingStatusResponse: '${autoMsg_c3401fc82b}',
    parsingRoleResponse: '${autoMsg_8d6d415aab}',
    missingBlockTarget: '${autoMsg_2e105310c8}',
    applying: '${autoMsg_71a3efcf07}',
    blockApplied: '${autoMsg_35eb4519fe}',
    memberDetailsTitle: '${autoMsg_9803cc470d}',
    memberDetailsSuffix: '${autoMsg_aedb01b12d}',
    infoTab: '${autoMsg_2bc04885f9}',
    loginTab: '${autoMsg_6799adb9a7}',
    securityTab: '${autoMsg_65987a83f0}',
    emailHistoryTab: '${autoMsg_a950657a16}',
    activityTab: '${autoMsg_36cd735886}',
    blockTab: '${autoMsg_8f31c1b947}',
    actionsTab: '${autoMsg_7a816126e9}'
};

function escapeHtml(value) {
    if (value == null) return '';
    return String(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

function formatNullable(value) {
    return value ? escapeHtml(value) : '<span style="color:#475569">—</span>';
}

function formatDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString(ADMIN_MEMBER_LOCALE || undefined, {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatHistoryDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString(ADMIN_MEMBER_LOCALE || undefined, {
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatBooleanBadge(value) {
    return value
        ? '<span style="color:#4ade80">✓ ' + escapeHtml(ADMIN_MEMBER_MSG.yes) + '</span>'
        : '<span style="color:#475569">✗ ' + escapeHtml(ADMIN_MEMBER_MSG.no) + '</span>';
}

function buildStatusBadge(status) {
    const safe = escapeHtml(status || '');
    return '<span class="status-badge ' + safe + '">' + (safe || '—') + '</span>';
}

function buildRoleBadge(role) {
    const safe = escapeHtml(role || '');
    return '<span class="role-badge ' + safe + '">' + roleLabel(safe) + '</span>';
}

function roleLabel(role) {
    const labels = {
        USER: '${autoMsg_0a2f46973a}',
        BUSINESS: '${autoMsg_f34987690b}',
        PARTNER: '${autoMsg_7cef6bcd99}',
        BOT: '${autoMsg_0023796b3f}',
        ADMIN: '${autoMsg_1fd3c9991d}',
        SUPERADMIN: '${autoMsg_f6d02ce1b2}',
        SYSTEM: '${autoMsg_51197b6b62}'
    };
    return labels[role] || role || '—';
}

function buildSocialHtml(linkedProviders) {
    if (!linkedProviders) {
        return '<span class="adm-social-empty">' + escapeHtml(ADMIN_MEMBER_MSG.noLinkedProvider) + '</span>';
    }

    const providerMap = {
        KAKAO: {
            label: '${autoMsg_d519188fd7}',
            className: 'kakao',
            icon: '<span class="adm-social-icon kakao-mark">k</span>'
        },
        NAVER: {
            label: '${autoMsg_039f2a034c}',
            className: 'naver',
            icon: '<span class="adm-social-icon naver-mark">N</span>'
        },
        GOOGLE: {
            label: '${autoMsg_329f00473b}',
            className: 'google',
            icon: '<span class="adm-social-icon google-mark"><svg viewBox="0 0 48 48" aria-hidden="true" focusable="false"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/></svg></span>'
        }
    };

    const items = linkedProviders
        .split(',')
        .map(provider => provider.trim())
        .filter(provider => provider.length > 0)
        .map(function(provider) {
            const info = providerMap[provider];
            if (!info) {
                return '<span class="adm-social-pill"><span class="adm-social-label">' + escapeHtml(provider) + '</span></span>';
            }
            return '<span class="adm-social-pill ' + info.className + '">' + info.icon + '<span class="adm-social-label">' + escapeHtml(info.label) + '</span></span>';
        });

    if (!items.length) {
        return '<span class="adm-social-empty">' + escapeHtml(ADMIN_MEMBER_MSG.noLinkedProvider) + '</span>';
    }

    return '<div class="adm-social-list">' + items.join('') + '</div>';
}

/* ── 페이지 이동 ── */
function goPage(p) {
    const form = document.getElementById('searchForm');
    form.querySelector('[name=page]').value = p;
    form.submit();
}

function changeSize(size) {
    const form = document.getElementById('searchForm');
    form.querySelector('[name=size]').value = size;
    form.querySelector('[name=page]').value = 1;
    form.submit();
}

/* ── 액션 메뉴 토글 ── */
function toggleMenu(btn) {
    const menu = btn.nextElementSibling;
    document.querySelectorAll('.action-menu.open').forEach(m => {
        if (m !== menu) m.classList.remove('open');
    });
    menu.classList.toggle('open');
}

function openBlockModal(triggerOrUserIdx, nickname) {
    const trigger = typeof triggerOrUserIdx === 'object' ? triggerOrUserIdx : null;
    const userIdx = trigger ? trigger.dataset.userIdx : triggerOrUserIdx;
    const resolvedNickname = trigger ? (trigger.dataset.nickname || '') : (nickname || '');

    document.getElementById('blockUserIdx').value = userIdx;
    document.getElementById('blockModalTitle').textContent = (resolvedNickname || '') + ' ' + ADMIN_MEMBER_MSG.blockModalTitleSuffix;
    document.getElementById('blockType').value = 'USER_ONLY';
    document.getElementById('blockedIp').value = '';
    document.getElementById('blockedIp').disabled = true;
    document.getElementById('blockedUntil').value = '';
    document.getElementById('blockedReason').value = '';
    document.getElementById('blockSubmitBtn').disabled = false;

    const menu = trigger ? trigger.closest('.action-menu') : null;
    if (menu) menu.classList.remove('open');

    document.getElementById('blockModal').classList.add('open');
}

function closeBlockModal() {
    document.getElementById('blockModal').classList.remove('open');
}

function handleBlockTypeChange() {
    const blockType = document.getElementById('blockType').value;
    const ipInput = document.getElementById('blockedIp');
    const requiresIp = blockType === 'IP_ONLY' || blockType === 'USER_IP';

    ipInput.disabled = !requiresIp;
    if (!requiresIp) ipInput.value = '';
}

async function submitBlock() {
    const submitBtn = document.getElementById('blockSubmitBtn');
    const userIdx = document.getElementById('blockUserIdx').value;
    const blockType = document.getElementById('blockType').value;
    const blockedIp = document.getElementById('blockedIp').value.trim();
    const blockedUntil = document.getElementById('blockedUntil').value;
    const reason = document.getElementById('blockedReason').value.trim();

    if (!userIdx) {
        adm_toast(ADMIN_MEMBER_MSG.missingBlockTarget, 'error');
        return;
    }
    if ((blockType === 'IP_ONLY' || blockType === 'USER_IP') && !blockedIp) {
        adm_toast('${autoMsg_c1757340af}', 'error');
        document.getElementById('blockedIp').focus();
        return;
    }

    submitBtn.disabled = true;
    const originalText = submitBtn.textContent;
    submitBtn.textContent = ADMIN_MEMBER_MSG.applying;

    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/block', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ blockType, blockedIp, expiresAt: blockedUntil, reason })
        });

        let data = null;
        const contentType = res.headers.get('content-type') || '';
        if (contentType.includes('application/json')) {
            data = await res.json();
        } else {
            const text = await res.text();
            throw new Error(text || ADMIN_MEMBER_MSG.parsingBlockResponse);
        }

        if (res.ok && data && data.success) {
            closeBlockModal();
            adm_toast(ADMIN_MEMBER_MSG.blockApplied || '${autoMsg_35eb4519fe}');
            setTimeout(() => location.reload(), 800);
        } else {
            adm_toast((data && data.message) || '${autoMsg_93595248e5}', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast(e.message || '${autoMsg_82e1a33bf4}', 'error');
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = originalText;
    }
}

/* ── 상태 변경 ── */
async function changeStatus(userIdx, status, el) {
    const labels = {
        ACTIVE: ADMIN_MEMBER_MSG.statusActive,
        DORMANT: ADMIN_MEMBER_MSG.statusDormant,
        BLOCKED: ADMIN_MEMBER_MSG.statusBlocked,
        DELETED: ADMIN_MEMBER_MSG.statusDeleted
    };
    if (!confirm('${autoMsg_28f618a732}' + ' "' + (labels[status] || status) + '" ' + '${autoMsg_582b10f8bb}')) return;

    const menu = el.closest('.action-menu');
    if (menu) menu.classList.remove('open');

    const res = await fetch(ctx + '/admin/members/' + userIdx + '/status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ status })
    });

    let data;
    try {
        data = await res.json();
    } catch (e) {
        adm_toast(ADMIN_MEMBER_MSG.parsingStatusResponse, 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '${autoMsg_19cf8eca7c}');
        setTimeout(() => location.reload(), 800);
    } else {
        adm_toast(data.message || '${autoMsg_623997efab}', 'error');
    }
}

/* ── 권한 변경 ── */
function changeRoleFromMenu(button) {
    const box = button.closest('.role-change-box');
    if (!box) return;

    const select = box.querySelector('.role-change-select');
    const reasonInput = box.querySelector('.role-change-reason');
    const userIdx = button.dataset.userIdx;
    const role = select ? select.value : '';
    const currentRole = select ? select.dataset.currentRole : '';
    const reason = reasonInput ? reasonInput.value.trim() : '';

    if (!role || !userIdx) {
        adm_toast('${autoMsg_22215b2645}', 'error');
        return;
    }
    if (role === currentRole) {
        adm_toast('${autoMsg_4e2604dfa0}', 'error');
        return;
    }
    if (!reason) {
        adm_toast('${autoMsg_9b4937693e}', 'error');
        if (reasonInput) reasonInput.focus();
        return;
    }

    changeRole(userIdx, role, reason, button);
}

async function changeRole(userIdx, role, reason, el) {
    if (!confirm('"' + roleLabel(role) + '" ' + '${autoMsg_fb4f5cdfe4}')) return;

    const menu = el.closest('.action-menu');
    if (menu) menu.classList.remove('open');

    const res = await fetch(ctx + '/admin/members/' + userIdx + '/role', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ role, reason })
    });

    let data;
    try {
        data = await res.json();
    } catch (e) {
        adm_toast(ADMIN_MEMBER_MSG.parsingRoleResponse, 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '${autoMsg_0205181e85}');
        setTimeout(() => location.reload(), 800);
    } else {
        adm_toast(data.message || '${autoMsg_81f079f9b9}', 'error');
    }
}

function buildContextRows(items, renderer, emptyMessage) {
    if (!Array.isArray(items) || !items.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">' + emptyMessage + '</div>';
    }
    return '<div style="display:flex;flex-direction:column;gap:10px;">' + items.map(renderer).join('') + '</div>';
}

function buildSecurityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.eventType || '-') + '</strong> / ' + escapeHtml(item.eventStage || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.occurredAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${autoMsg_09a531507e}: ' + escapeHtml(item.inputIdentifier || '-') + '</div>'
            + '<div style="margin-top:4px;font-size:12px;color:#94a3b8;">${autoMsg_df50ec273f}: ' + escapeHtml(item.targetEmail || '-') + '</div>'
            + '</div>';
    }, '${autoMsg_655a03dee1}');
}

function buildEmailRequestRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.status || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.requestedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${autoMsg_9986173463}: ' + escapeHtml(item.pendingEmail || '-') + '</div>'
            + '</div>';
    }, '${autoMsg_df8ae7b5a1}');
}

function buildEmailTokenRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.used ? '${autoMsg_9f0d4a80ab}' : '${autoMsg_ed5dbcfe96}') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${autoMsg_df50ec273f}: ' + escapeHtml(item.email || '-') + '</div>'
            + '</div>';
    }, '${autoMsg_b67170d46b}');
}

function buildActivityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.activityCode || '-') + '</strong> / ' + escapeHtml(item.activityDomain || item.activityType || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${autoMsg_90d8ab0701}: ' + escapeHtml(item.requestUri || '-') + '</div>'
            + '</div>';
    }, '${autoMsg_4074aa5a05}');
}

function buildBlockRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.blockType || '-') + '</strong> / ' + escapeHtml(item.active ? 'ACTIVE' : 'INACTIVE') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.blockedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;">${autoMsg_5b658ed241}: ' + escapeHtml(item.reason || '-') + '</div>'
            + '<div style="margin-top:4px;font-size:12px;color:#94a3b8;">IP: ' + escapeHtml(item.blockedIp || '-') + '</div>'
            + '</div>';
    }, '${autoMsg_53d8c44942}');
}

function buildChatbotLinkClickRows(items) {
    return buildContextRows(items, function(item) {
        const url = item.url || '';
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div style="font-size:13px;"><strong>' + escapeHtml(item.label || '-') + '</strong></div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.clickedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;"><a href="' + ctx + escapeHtml(url) + '" target="_blank" style="color:#60a5fa;font-family:monospace;text-decoration:none;">' + escapeHtml(url) + '</a></div>'
            + '<div style="margin-top:4px;font-size:11px;color:#94a3b8;">'
            + 'conv #' + escapeHtml(item.conversationId || '-')
            + ' · msg #' + escapeHtml(item.messageId || '-')
            + ' · IP: ' + escapeHtml(item.ipAddress || '-')
            + '</div>'
            + '</div>';
    }, '기록된 챗봇 링크 클릭이 없습니다.');
}

function buildActionTab(m) {
    return ''
        + '<div class="adm-context-actions-grid">'
        + '<div class="adm-context-panel">'
        + '<div style="font-weight:700;margin-bottom:10px;">' + '${autoMsg_3bea6f4cea}' + '</div>'
        + '<div class="detail-label">' + '${autoMsg_49d89a08e9}' + '</div><input id="memberProfileNickname" class="adm-input" type="text" value="' + escapeHtml(m.nickname || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '${autoMsg_e1ee8c64a7}' + '</div><input id="memberProfileNationality" class="adm-input" type="text" value="' + escapeHtml(m.nationality || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '${autoMsg_2da7e47509}' + '</div><input id="memberProfileLang" class="adm-input" type="text" value="' + escapeHtml(m.preferredLang || '') + '">'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="saveMemberProfile(' + escapeHtml(m.userIdx) + ', this)">' + '${autoMsg_2fa1ea1062}' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel">'
        + '<div style="font-weight:700;margin-bottom:10px;">' + '${autoMsg_dfd54827df}' + '</div>'
        + '<div class="detail-label">' + '${autoMsg_7f77d7a7de}' + '</div>'
        + '<div style="display:flex;gap:8px;"><select id="memberStatusSelect" class="adm-select" style="width:100%;"><option value="ACTIVE">${autoMsg_7d951366ce}</option><option value="DORMANT">${autoMsg_bf1d1a6d55}</option><option value="BLOCKED">${autoMsg_e407db387a}</option><option value="DELETED">${autoMsg_cdb6a62812}</option></select><button type="button" class="adm-btn adm-btn-ghost" onclick="applyStatusFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '${autoMsg_84f506fa9a}' + '</button></div>'
        + '<div class="detail-label" style="margin-top:10px;">' + '${autoMsg_59e66372dd}' + '</div>'
        + '<select id="memberRoleSelect" class="adm-select" style="width:100%;"><option value="USER">${autoMsg_0a2f46973a}</option><option value="BUSINESS">${autoMsg_f34987690b}</option><option value="PARTNER">${autoMsg_7cef6bcd99}</option><option value="BOT">${autoMsg_0023796b3f}</option><option value="ADMIN">${autoMsg_1fd3c9991d}</option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '${autoMsg_cfa3e4044d}' + '</div>'
        + '<input id="memberRoleReason" class="adm-input" type="text" maxlength="500" placeholder="' + '${autoMsg_2c82f9503e}' + '">'
        + '<button type="button" class="adm-btn adm-btn-ghost" style="margin-top:12px;" onclick="applyRoleFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '${autoMsg_7a77afbd32}' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel">'
        + '<div style="font-weight:700;margin-bottom:10px;">' + '${autoMsg_569502d33a}' + '</div>'
        + '<div class="detail-label">' + '${autoMsg_657bacf516}' + '</div><select id="detailBlockType" class="adm-select" style="width:100%;"><option value="USER_ONLY">' + '${autoMsg_b165aefc9e}' + '</option><option value="IP_ONLY">' + '${autoMsg_297ccdc718}' + '</option><option value="USER_IP">' + '${autoMsg_e67eb06ea0}' + '</option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '${autoMsg_66a711eccb}' + '</div><input id="detailBlockedIp" class="adm-input" type="text" placeholder="' + '${autoMsg_777c217ebc}' + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '${autoMsg_de9550f28e}' + '</div><input id="detailBlockedUntil" class="adm-input" type="datetime-local">'
        + '<div class="detail-label" style="margin-top:10px;">' + '${autoMsg_5b658ed241}' + '</div><textarea id="detailBlockedReason" class="adm-input" style="min-height:88px;resize:vertical;"></textarea>'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="submitDetailBlock(' + escapeHtml(m.userIdx) + ', this)">' + '${autoMsg_2be055d6af}' + '</button>'
        + '</div>'
        + '</div>';
}

/* ── 회원 상세 모달 ── */
async function openDetail(userIdx, defaultTab) {
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('modalBody').innerHTML =
        '<div style="text-align:center;padding:40px;color:#475569;">' + escapeHtml(ADMIN_MEMBER_MSG.loading) + ' ⏳</div>';

    let data;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx);
        data = await res.json();
    } catch (error) {
        document.getElementById('modalBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(ADMIN_MEMBER_MSG.fetchError) + '</div>';
        return;
    }

    if (!data.success) {
        document.getElementById('modalBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(data.message || ADMIN_MEMBER_MSG.error) + '</div>';
        return;
    }

    const m = data.member || {};
    const h = Array.isArray(data.history) ? data.history : [];
    const securityAudits = Array.isArray(data.securityAudits) ? data.securityAudits : [];
    const emailRequests = Array.isArray(data.emailRequests) ? data.emailRequests : [];
    const emailTokens = Array.isArray(data.emailTokens) ? data.emailTokens : [];
    const activityLogs = Array.isArray(data.activityLogs) ? data.activityLogs : [];
    const recentBlocks = Array.isArray(data.recentBlocks) ? data.recentBlocks : [];
    const chatbotLinkClicks = Array.isArray(data.chatbotLinkClicks) ? data.chatbotLinkClicks : [];
    const activeTab = ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'chatbot', 'actions'].includes(defaultTab) ? defaultTab : 'info';

    document.getElementById('modalTitle').textContent = (m.nickname || ADMIN_MEMBER_MSG.memberDetailsTitle) + ' ' + ADMIN_MEMBER_MSG.memberDetailsSuffix;

    document.getElementById('modalBody').innerHTML = ''
        + '<div class="adm-tabs">'
        + '<button class="adm-tab ' + (activeTab === 'info' ? 'active' : '') + '" onclick="switchTab(\'info\', this)">' + ADMIN_MEMBER_MSG.infoTab + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'hist' ? 'active' : '') + '" onclick="switchTab(\'hist\', this)">' + ADMIN_MEMBER_MSG.loginTab + ' (' + h.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'security' ? 'active' : '') + '" onclick="switchTab(\'security\', this)">' + ADMIN_MEMBER_MSG.securityTab + ' (' + securityAudits.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'emails' ? 'active' : '') + '" onclick="switchTab(\'emails\', this)">' + ADMIN_MEMBER_MSG.emailHistoryTab + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'activity' ? 'active' : '') + '" onclick="switchTab(\'activity\', this)">' + ADMIN_MEMBER_MSG.activityTab + ' (' + activityLogs.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'blocks' ? 'active' : '') + '" onclick="switchTab(\'blocks\', this)">' + ADMIN_MEMBER_MSG.blockTab + ' (' + recentBlocks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'chatbot' ? 'active' : '') + '" onclick="switchTab(\'chatbot\', this)">챗봇 링크 (' + chatbotLinkClicks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'actions' ? 'active' : '') + '" onclick="switchTab(\'actions\', this)">' + ADMIN_MEMBER_MSG.actionsTab + '</button>'
        + '</div>'
        + '<div id="tab-info" style="display:' + (activeTab === 'info' ? '' : 'none') + ';"></div>'
        + '<div id="tab-hist" style="display:' + (activeTab === 'hist' ? '' : 'none') + ';"></div>'
        + '<div id="tab-security" style="display:' + (activeTab === 'security' ? '' : 'none') + ';"></div>'
        + '<div id="tab-emails" style="display:' + (activeTab === 'emails' ? '' : 'none') + ';"></div>'
        + '<div id="tab-activity" style="display:' + (activeTab === 'activity' ? '' : 'none') + ';"></div>'
        + '<div id="tab-blocks" style="display:' + (activeTab === 'blocks' ? '' : 'none') + ';"></div>'
        + '<div id="tab-chatbot" style="display:' + (activeTab === 'chatbot' ? '' : 'none') + ';"></div>'
        + '<div id="tab-actions" style="display:' + (activeTab === 'actions' ? '' : 'none') + ';"></div>';

    document.getElementById('tab-info').innerHTML = buildInfoTab(m);
    document.getElementById('tab-hist').innerHTML = buildHistTab(h);
    document.getElementById('tab-security').innerHTML = buildSecurityRows(securityAudits);
    document.getElementById('tab-emails').innerHTML = ''
        + '<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:16px;">'
        + '<div><div style="font-weight:700;margin-bottom:10px;">' + '${autoMsg_8fd5232912}' + '</div>' + buildEmailRequestRows(emailRequests) + '</div>'
        + '<div><div style="font-weight:700;margin-bottom:10px;">' + '${autoMsg_8b8f445762}' + '</div>' + buildEmailTokenRows(emailTokens) + '</div>'
        + '</div>';
    document.getElementById('tab-activity').innerHTML = buildActivityRows(activityLogs);
    document.getElementById('tab-blocks').innerHTML = buildBlockRows(recentBlocks);
    document.getElementById('tab-chatbot').innerHTML = buildChatbotLinkClickRows(chatbotLinkClicks);
    document.getElementById('tab-actions').innerHTML = buildActionTab(m);
    const statusSelect = document.getElementById('memberStatusSelect');
    const roleSelect = document.getElementById('memberRoleSelect');
    if (statusSelect) statusSelect.value = m.accountStatus || 'ACTIVE';
    if (roleSelect) roleSelect.value = m.userRole || 'USER';
}

function buildInfoTab(m) {
    const statusBadge = buildStatusBadge(m.accountStatus);
    const roleBadge = buildRoleBadge(m.userRole);
    const socialHtml = buildSocialHtml(m.linkedProviders);
    const lastLoginText = formatDateTime(m.lastLoginAt);

    return ''
        + '<div class="detail-grid">'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_2ff6f831e8}' + '</div><div class="detail-value">#' + escapeHtml(m.userIdx) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_901942cda3}' + '</div><div class="detail-value">' + formatNullable(m.userId) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_49d89a08e9}' + '</div><div class="detail-value">' + formatNullable(m.nickname) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_413c58e514}' + '</div><div class="detail-value" style="font-size:12px;">' + formatNullable(m.userEmail) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_7f77d7a7de}' + '</div><div class="detail-value">' + statusBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_59e66372dd}' + '</div><div class="detail-value">' + roleBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_e1ee8c64a7}' + '</div><div class="detail-value">' + formatNullable(m.nationality) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_2da7e47509}' + '</div><div class="detail-value">' + formatNullable(m.preferredLang) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_b7eb2dfc5d}' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailVerified) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_f1ff1384e2}' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailLoginEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_e7d9e4c5c4}' + '</div><div class="detail-value">' + formatBooleanBadge(m.passwordEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '${autoMsg_4ecfd939f8}' + '</div><div class="detail-value" style="font-size:12px;">' + formatDateTime(m.createdAt) + '</div></div>'
        + '</div>'
        + '<div class="detail-item" style="margin-top:12px;">'
        + '<div class="detail-label">' + '${autoMsg_836ad37ce3}' + '</div>'
        + '<div class="detail-value" style="margin-top:4px;">' + socialHtml + '</div>'
        + '</div>'
        + '<div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '${autoMsg_d8bf5f56e9}' + '</div>'
        + '<div style="font-size:20px;font-weight:700;color:#4ade80;margin-top:4px;">' + escapeHtml(m.loginSuccessCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '${autoMsg_1ce445ab81}' + '</div>'
        + '<div style="font-size:20px;font-weight:700;color:#f87171;margin-top:4px;">' + escapeHtml(m.loginFailCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:120px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '${autoMsg_21e9a18ffb}' + '</div>'
        + '<div style="font-size:12px;font-weight:600;color:#94a3b8;margin-top:4px;">' + escapeHtml(lastLoginText) + '</div>'
        + '</div>'
        + '</div>';
}

function buildHistTab(history) {
    if (!history.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">' + '${autoMsg_fe788d3d39}' + '</div>';
    }

    const methodMap = {
        ID: '${autoMsg_901942cda3}',
        EMAIL: '${autoMsg_413c58e514}',
        KAKAO: '${autoMsg_d519188fd7}',
        NAVER: '${autoMsg_039f2a034c}',
        GOOGLE: '${autoMsg_329f00473b}'
    };

    let rows = '';
    history.forEach(function(item) {
        const ok = !!item.success;
        rows += ''
            + '<tr>'
            + '<td>' + escapeHtml(formatHistoryDateTime(item.loginAt)) + '</td>'
            + '<td>' + escapeHtml(methodMap[item.loginMethod] || item.loginMethod || '—') + '</td>'
            + '<td class="' + (ok ? 'h-success' : 'h-fail') + '">' + (ok ? '✅ ' + '${autoMsg_b9b4f87535}' : '❌ ' + '${autoMsg_005440f954}') + '</td>'
            + '<td>' + escapeHtml(item.failReason || '—') + '</td>'
            + '<td style="font-size:11px;color:#475569;">' + escapeHtml(item.ipAddress || '—') + '</td>'
            + '</tr>';
    });

    return ''
        + '<div style="overflow-x:auto;max-height:340px;overflow-y:auto;">'
        + '<table class="history-table">'
        + '<thead><tr><th>' + '${autoMsg_10c248e065}' + '</th><th>' + '${autoMsg_e5becd39c3}' + '</th><th>' + '${autoMsg_b9b4f87535}' + '</th><th>' + '${autoMsg_ef83b25be6}' + '</th><th>${autoMsg_761b84a10b}</th></tr></thead>'
        + '<tbody>' + rows + '</tbody>'
        + '</table>'
        + '</div>';
}

function switchTab(tab, btn) {
    document.querySelectorAll('#detailModal .adm-tab').forEach(t => t.classList.remove('active'));
    btn.classList.add('active');
    ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'actions'].forEach(function(name) {
        const el = document.getElementById('tab-' + name);
        if (el) el.style.display = tab === name ? '' : 'none';
    });
}

async function saveMemberProfile(userIdx, button) {
    const nickname = document.getElementById('memberProfileNickname').value.trim();
    const nationality = document.getElementById('memberProfileNationality').value.trim();
    const preferredLang = document.getElementById('memberProfileLang').value.trim();

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/profile', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ nickname, nationality, preferredLang })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || '${autoMsg_7cb96542d5}');
            setTimeout(() => location.reload(), 700);
        } else {
            adm_toast(data.message || '${autoMsg_69eae2cf3d}', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('${autoMsg_d969ca6ccb}', 'error');
    } finally {
        button.disabled = false;
    }
}

function applyStatusFromDetail(userIdx, button) {
    const status = document.getElementById('memberStatusSelect').value;
    changeStatus(userIdx, status, button);
}

function applyRoleFromDetail(userIdx, button) {
    const role = document.getElementById('memberRoleSelect').value;
    const reason = document.getElementById('memberRoleReason').value.trim();
    if (!reason) {
        adm_toast('${autoMsg_9b4937693e}', 'error');
        return;
    }
    changeRole(userIdx, role, reason, button);
}

async function submitDetailBlock(userIdx, button) {
    const blockType = document.getElementById('detailBlockType').value;
    const blockedIp = document.getElementById('detailBlockedIp').value.trim();
    const expiresAt = document.getElementById('detailBlockedUntil').value;
    const reason = document.getElementById('detailBlockedReason').value.trim();

    if ((blockType === 'IP_ONLY' || blockType === 'USER_IP') && !blockedIp) {
        adm_toast('${autoMsg_c1757340af}', 'error');
        return;
    }

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/block', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ blockType, blockedIp, expiresAt, reason })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || '${autoMsg_35eb4519fe}');
            setTimeout(() => location.reload(), 700);
        } else {
            adm_toast(data.message || '${autoMsg_93595248e5}', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('${autoMsg_82e1a33bf4}', 'error');
    } finally {
        button.disabled = false;
    }
}

function closeDetail() {
    document.getElementById('detailModal').classList.remove('open');
    // 외부에서 ?detailUserIdx=N 으로 들어와 자동 오픈된 경우, 닫힘 후 파라미터 제거 (리프레시 재오픈 방지)
    try {
        const url = new URL(window.location.href);
        if (url.searchParams.has('detailUserIdx')) {
            url.searchParams.delete('detailUserIdx');
            window.history.replaceState(null, '', url.toString());
        }
    } catch (e) {}
}

document.getElementById('detailModal').addEventListener('click', function (e) {
    if (e.target === this) closeDetail();
});

document.getElementById('blockModal').addEventListener('click', function (e) {
    if (e.target === this) closeBlockModal();
});
</script>

<%@ include file="../layout-close.jsp" %>
