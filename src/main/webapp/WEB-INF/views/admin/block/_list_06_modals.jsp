<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

id="blockDetailModal">
    <div class="adm-modal" style="max-width:860px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockDetailTitle" data-default-title='${msg_admin_blocks_detailTitle}'>${msg_admin_blocks_detailTitle_v2}</div>
            <button class="adm-modal-close" onclick="return (window.TripAdminBlockDetailFallback ? window.TripAdminBlockDetailFallback.close() : closeModal('blockDetailModal'))">✕</button>
        </div>
        <div class="adm-modal-body" id="blockDetailBody"></div>
    </div>
</div>

<div class="adm-modal-overlay" id="memberDetailModal">
    <div class="adm-modal" style="max-width:860px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="memberDetailTitle">${msg_admin_context_memberTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('memberDetailModal')">✕</button>
        </div>
        <div class="adm-modal-body" id="memberDetailBody">
            <div style="text-align:center;padding:40px;color:#64748b;">${msg_admin_common_loading}</div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('memberDetailModal')">${msg_admin_common_close}</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="userBlockEditModal">
    <div class="adm-modal" style="max-width:720px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="userBlockEditTitle">${msg_admin_blocks_userBlocks_editTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('userBlockEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="userBlockEditId">
            <input type="hidden" id="userBlockEditTemplateId">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">${msg_admin_common_member}</div><div class="detail-value" id="userBlockEditMember">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_blocks_targetKey}</div><div class="detail-value" id="userBlockEditTarget">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_blocks_filter_blockType}</div><div class="detail-value" id="userBlockEditType">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_common_status}</div><div class="detail-value" id="userBlockEditStatus">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_blocks_blockedAt}</div><div class="detail-value" id="userBlockEditBlockedAt">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_blocks_syncedAt}</div><div class="detail-value" id="userBlockEditSyncAt">-</div></div>
            </div>
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;margin-top:18px;">
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_common_status}</label>
                    <select id="userBlockEditActive" class="adm-select">
                        <option value="true">${msg_admin_blocks_keepBlocked}</option>
                        <option value="false">${msg_admin_blocks_releaseBlock}</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_context_expiresAt}</label>
                    <input id="userBlockEditExpiresAt" class="adm-input" type="datetime-local">
                    <div class="adm-quick-row">
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="userBlockEditExpiresAt" data-days="1">${msg_admin_common_plusDays}</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="userBlockEditExpiresAt" data-days="7">${msg_admin_common_plusDays}</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="userBlockEditExpiresAt" data-days="30">${msg_admin_common_plusDays}</button>
                        <button type="button" class="adm-chip-btn js-expiry-clear" data-target="userBlockEditExpiresAt">${msg_admin_common_indefinite}</button>
                    </div>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">${msg_admin_common_reason}</label>
                    <textarea id="userBlockEditReason" class="adm-input" style="min-height:120px;"></textarea>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('userBlockEditModal')">${msg_admin_common_close}</button>
            <button class="adm-btn adm-btn-ghost" type="button" id="userBlockEditHistoryBtn">${msg_admin_common_relatedHistory}</button>
            <button class="adm-btn adm-btn-primary" type="button" onclick="submitUserBlockEdit()">${msg_admin_common_save}</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="ipRuleEditModal">
    <div class="adm-modal" style="max-width:760px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="ipRuleEditTitle">${msg_admin_blocks_ipRules_editTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('ipRuleEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="ipRuleEditId">
            <input type="hidden" id="ipRuleEditTemplateId">
            <input type="hidden" id="ipRuleEditHasBatch">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">${msg_admin_common_target}</div><div class="detail-value" id="ipRuleEditTarget">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_context_batch}</div><div class="detail-value" id="ipRuleEditBatch">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_blocks_ruleState}</div><div class="detail-value" id="ipRuleEditRuleState">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_blocks_effectiveState}</div><div class="detail-value" id="ipRuleEditFinalState">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_context_createdAt}</div><div class="detail-value" id="ipRuleEditBlockedAt">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_context_expiresAt}</div><div class="detail-value" id="ipRuleEditExpiresDisplay">-</div></div>
            </div>
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;margin-top:18px;">
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_context_ruleAction}</label>
                    <select id="ipRuleEditAction" class="adm-select">
                        <option value="BLOCK">${msg_admin_context_ruleAction_block}</option>
                        <option value="ALLOW">${msg_admin_context_ruleAction_allow}</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_blocks_controlMode}</label>
                    <select id="ipRuleEditControlMode" class="adm-select"></select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_context_category}</label>
                    <select id="ipRuleEditCategory" class="adm-select">
                        <option value="MANUAL">${msg_admin_blocks_category_manual}</option>
                        <option value="SPAM">${msg_admin_blocks_category_spam}</option>
                        <option value="ABUSE">${msg_admin_blocks_category_abuse}</option>
                        <option value="BRUTE_FORCE">${msg_admin_blocks_category_bruteForce}</option>
                        <option value="GEO">${msg_admin_blocks_category_geo}</option>
                        <option value="VPN">${msg_admin_blocks_category_vpn}</option>
                        <option value="SECURITY">${msg_admin_blocks_category_security}</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_context_priority}</label>
                    <input id="ipRuleEditPriority" class="adm-input" type="number" min="1">
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">${msg_admin_context_expiresAt}</label>
                    <input id="ipRuleEditExpiresAt" class="adm-input" type="datetime-local">
                    <div class="adm-quick-row">
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipRuleEditExpiresAt" data-days="1">${msg_admin_common_plusDays}</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipRuleEditExpiresAt" data-days="7">${msg_admin_common_plusDays}</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipRuleEditExpiresAt" data-days="30">${msg_admin_common_plusDays}</button>
                        <button type="button" class="adm-chip-btn js-expiry-clear" data-target="ipRuleEditExpiresAt">${msg_admin_common_indefinite}</button>
                    </div>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">${msg_admin_blocks_policyReason}</label>
                    <textarea id="ipRuleEditReason" class="adm-input" style="min-height:100px;"></textarea>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">${msg_admin_blocks_description}</label>
                    <textarea id="ipRuleEditDetailMessage" class="adm-input" style="min-height:100px;"></textarea>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('ipRuleEditModal')">${msg_admin_common_close}</button>
            <button class="adm-btn adm-btn-ghost" type="button" id="ipRuleEditHistoryBtn">${msg_admin_common_relatedHistory}</button>
            <button class="adm-btn adm-btn-primary" type="button" onclick="submitIpRuleEdit()">${msg_admin_common_save}</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="ipRuleModal">
    <div class="adm-modal" style="max-width:720px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${msg_admin_blocks_ipRules_createTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('ipRuleModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_context_ruleAction}</label>
                    <select id="ipRuleAction" class="adm-select">
                        <option value="BLOCK">${msg_admin_context_ruleAction_block}</option>
                        <option value="ALLOW">${msg_admin_context_ruleAction_allow}</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_blocks_controlMode}</label>
                    <select id="ipControlMode" class="adm-select">
                        <option value="MANUAL">${msg_admin_blocks_control_manual}</option>
                        <option value="BATCH">${msg_admin_blocks_control_batch}</option>
                        <option value="MANUAL_OVERRIDE">${msg_admin_blocks_control_override}</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_blocks_matchType}</label>
                    <select id="ipMatchType" class="adm-select" onchange="handleIpRuleTypeChange()">
                        <option value="SINGLE_IP">${msg_admin_blocks_match_singleIp}</option>
                        <option value="CIDR">${msg_admin_blocks_match_cidr}</option>
                        <option value="RANGE">${msg_admin_blocks_match_range}</option>
                        <option value="COUNTRY">${msg_admin_blocks_match_country}</option>
                        <option value="ASN">${msg_admin_blocks_match_asn}</option>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_context_category}</label>
                    <select id="ipBlockCategory" class="adm-select">
                        <option value="MANUAL">${msg_admin_blocks_category_manual}</option>
                        <option value="SPAM">${msg_admin_blocks_category_spam}</option>
                        <option value="ABUSE">${msg_admin_blocks_category_abuse}</option>
                        <option value="BRUTE_FORCE">${msg_admin_blocks_category_bruteForce}</option>
                        <option value="GEO">${msg_admin_blocks_category_geo}</option>
                        <option value="VPN">${msg_admin_blocks_category_vpn}</option>
                        <option value="SECURITY">${msg_admin_blocks_category_security}</option>
                    </select>
                </div>
                <div class="sa-form-group" id="fieldSingleIp">
                    <label class="sa-form-label">${msg_admin_common_ip}</label>
                    <input id="ipAddressInput" class="adm-input" type="text" placeholder="203.0.113.10">
                </div>
                <div class="sa-form-group" id="fieldCidr" style="display:none;">
                    <label class="sa-form-label">${msg_admin_blocks_match_cidr}</label>
                    <input id="cidrNotationInput" class="adm-input" type="text" placeholder="203.0.113.0/24">
                </div>
                <div class="sa-form-group" id="fieldRangeStart" style="display:none;">
                    <label class="sa-form-label">${msg_admin_blocks_rangeStartIp}</label>
                    <input id="rangeStartInput" class="adm-input" type="text" placeholder="203.0.113.1">
                </div>
                <div class="sa-form-group" id="fieldRangeEnd" style="display:none;">
                    <label class="sa-form-label">${msg_admin_blocks_rangeEndIp}</label>
                    <input id="rangeEndInput" class="adm-input" type="text" placeholder="203.0.113.255">
                </div>
                <div class="sa-form-group" id="fieldCountry" style="display:none;">
                    <label class="sa-form-label">${msg_admin_blocks_countryCode}</label>
                    <input id="countryCodeInput" class="adm-input" type="text" placeholder="CN">
                </div>
                <div class="sa-form-group" id="fieldAsn" style="display:none;">
                    <label class="sa-form-label">${msg_admin_blocks_match_asn}</label>
                    <input id="asnInput" class="adm-input" type="text" placeholder="AS12345">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_context_batch}</label>
                    <select id="ipBatchIdx" class="adm-select" onchange="handleIpBatchChange()">
                        <option value="">${msg_admin_members_none}</option>
                        <c:forEach var="b" items="${batchFilterOptions}">
                            <option value="${b.ipBlockBatchIdx}">${b.batchName} (${b.batchCode})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_admin_context_priority}</label>
                    <input id="ipPriority" class="adm-input" type="number" min="1" value="1">
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">${msg_admin_context_expiresAt}</label>
                    <input id="ipExpiresAt" class="adm-input" type="datetime-local">
                    <div class="adm-quick-row">
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipExpiresAt" data-days="1">${msg_admin_common_plusDays}</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipExpiresAt" data-days="7">${msg_admin_common_plusDays}</button>
                        <button type="button" class="adm-chip-btn js-expiry-preset" data-target="ipExpiresAt" data-days="30">${msg_admin_common_plusDays}</button>
                        <button type="button" class="adm-chip-btn js-expiry-clear" data-target="ipExpiresAt">${msg_admin_common_indefinite}</button>
                    </div>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">${msg_admin_blocks_policyReason}</label>
                    <textarea id="ipReason" class="adm-input" style="min-height:90px;"></textarea>
                </div>
                <div class="sa-form-group" style="grid-column:1 / span 2;">
                    <label class="sa-form-label">${msg_admin_blocks_description}</label>
                    <textarea id="ipDetailMessage" class="adm-input" style="min-height:90px;"></textarea>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('ipRuleModal')">${msg_admin_common_cancel}</button>
            <button class="adm-btn adm-btn-primary" onclick="submitIpRule()">${msg_admin_common_save}</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchModal">
    <div class="adm-modal" style="max-width:620px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${msg_admin_blocks_batches_createTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('batchModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;">
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_batchCode}</label><input id="batchCode" class="adm-input" type="text" placeholder="VPN_FEED_202604"></div>
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_batchName}</label><input id="batchName" class="adm-input" type="text" placeholder="VPN Public Ranges 2026.04"></div>
<div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_source}</label><select id="batchSourceType" class="adm-select"><option value="MANUAL">${msg_admin_blocks_sourceType_manual}</option><option value="VPN_FEED">${msg_admin_blocks_sourceType_vpnFeed}</option><option value="SPAM_FEED">${msg_admin_blocks_sourceType_spamFeed}</option><option value="GEO_POLICY">${msg_admin_blocks_sourceType_geoPolicy}</option><option value="AUTO_DETECTION">${msg_admin_blocks_sourceType_autoDetection}</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_source} ${msg_admin_common_value}</label><input id="batchSourceName" class="adm-input" type="text" placeholder="Manual registration"></div>
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_baseAction}</label><select id="batchRuleAction" class="adm-select"><option value="BLOCK">${msg_admin_context_ruleAction_block}</option><option value="ALLOW">${msg_admin_context_ruleAction_allow}</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_defaultPriority}</label><input id="batchDefaultPriority" class="adm-input" type="number" min="1" value="1"></div>
                <div class="sa-form-group"><label class="sa-form-label">OFF ${msg_admin_blocks_baseStrategy}</label><select id="batchDisableStrategy" class="adm-select"><option value="BATCH_ONLY">BATCH_ONLY</option><option value="CASCADE_ACTIVE_RULES">CASCADE_ACTIVE_RULES</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">ON ${msg_admin_blocks_baseStrategy}</label><select id="batchEnableStrategy" class="adm-select"><option value="BATCH_ONLY">BATCH_ONLY</option><option value="RESTORE_BATCH_CONTROL">RESTORE_BATCH_CONTROL</option><option value="FORCE_ENABLE_ALL">FORCE_ENABLE_ALL</option></select></div>
                <div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">${msg_admin_blocks_description}</label><textarea id="batchDescription" class="adm-input" style="min-height:90px;"></textarea></div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('batchModal')">${msg_admin_common_cancel}</button>
            <button class="adm-btn adm-btn-primary" onclick="submitBatch()">${msg_admin_common_create}</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchEditModal">
    <div class="adm-modal" style="max-width:720px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="batchEditTitle">${msg_admin_blocks_batches_editTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('batchEditModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="batchEditId">
            <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">${msg_admin_blocks_currentState}</div><div class="detail-value" id="batchEditStatus">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_context_updatedAt}</div><div class="detail-value" id="batchEditUpdatedAt">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_context_createdAt}</div><div class="detail-value" id="batchEditCreatedAt">-</div></div>
                <div class="detail-item"><div class="detail-label">${msg_admin_blocks_ruleStats}</div><div class="detail-value" id="batchEditStats">-</div></div>
            </div>
            <div class="sa-form-grid" style="grid-template-columns:1fr 1fr;margin-top:18px;">
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_batchCode}</label><input id="batchEditCode" class="adm-input" type="text"></div>
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_batchName}</label><input id="batchEditName" class="adm-input" type="text"></div>
<div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_source}</label><select id="batchEditSourceType" class="adm-select"><option value="MANUAL">${msg_admin_blocks_sourceType_manual}</option><option value="VPN_FEED">${msg_admin_blocks_sourceType_vpnFeed}</option><option value="SPAM_FEED">${msg_admin_blocks_sourceType_spamFeed}</option><option value="GEO_POLICY">${msg_admin_blocks_sourceType_geoPolicy}</option><option value="AUTO_DETECTION">${msg_admin_blocks_sourceType_autoDetection}</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_source} ${msg_admin_common_value}</label><input id="batchEditSourceName" class="adm-input" type="text"></div>
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_baseAction}</label><select id="batchEditRuleAction" class="adm-select"><option value="BLOCK">${msg_admin_context_ruleAction_block}</option><option value="ALLOW">${msg_admin_context_ruleAction_allow}</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">${msg_admin_blocks_defaultPriority}</label><input id="batchEditPriority" class="adm-input" type="number" min="1"></div>
                <div class="sa-form-group"><label class="sa-form-label">OFF ${msg_admin_blocks_baseStrategy}</label><select id="batchEditDisableStrategy" class="adm-select"><option value="BATCH_ONLY">BATCH_ONLY</option><option value="CASCADE_ACTIVE_RULES">CASCADE_ACTIVE_RULES</option></select></div>
                <div class="sa-form-group"><label class="sa-form-label">ON ${msg_admin_blocks_baseStrategy}</label><select id="batchEditEnableStrategy" class="adm-select"><option value="BATCH_ONLY">BATCH_ONLY</option><option value="RESTORE_BATCH_CONTROL">RESTORE_BATCH_CONTROL</option><option value="FORCE_ENABLE_ALL">FORCE_ENABLE_ALL</option></select></div>
                <div class="sa-form-group" style="grid-column:1 / span 2;"><label class="sa-form-label">${msg_admin_blocks_description}</label><textarea id="batchEditDescription" class="adm-input" style="min-height:100px;"></textarea></div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeModal('batchEditModal')">${msg_admin_common_close}</button>
            <button class="adm-btn adm-btn-primary" type="button" onclick="submitBatchEdit()">${msg_admin_common_save}</button>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="batchToggleModal">
    <div class="adm-modal" style="max-width:620px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="batchToggleTitle">${msg_admin_blocks_batches_toggleTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('batchToggleModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="batchToggleId">
            <input type="hidden" id="batchToggleActive">
            <div class="detail-item" style="margin-bottom:14px;">
                <div class="detail-label">${msg_admin_blocks_impact}</div>
                <div class="detail-value" id="batchToggleSummary">-</div>
            </div>
            <div class="sa-form-group">
                <label class="sa-form-label">${msg_admin_blocks_option}</label>
                <select id="batchToggleOption" class="adm-select"></select>
            </div>
            <div class="sa-form-group" style="margin-top:14px;">
                <label class="sa-form-label">${msg_admin_blocks_description}</label>
                <textarea id="batchToggleDescription" class="adm-input" style="min-height:90px;"></textarea>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('batchToggleModal')">${msg_admin_common_cancel}</button>
            <button class="adm-btn adm-btn-primary" onclick="submitBatchToggle()">${msg_admin_common_apply}</button>
        </div>
    </div>
</div>

