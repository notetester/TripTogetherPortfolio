<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message var="autoMsg_f390677e39" code="detail.review.countSuffix"/>
<spring:message var="autoMsg_18cfc8ff7e" code="detail.like.count"/>
<spring:message var="autoMsg_7ba379cfc1" code="detail.back"/>
<spring:message var="autoMsg_59ee812003" code="detail.fav.done"/>
<spring:message var="autoMsg_27c009e3de" code="detail.fav.do"/>
<spring:message var="autoMsg_b1f2f74725" code="detail.like.done"/>
<spring:message var="autoMsg_719fd9e790" code="detail.like.do"/>
<spring:message var="autoMsg_71a7cd69f0" code="detail.ai.plan"/>
<spring:message var="autoMsg_27bfcab9ef" code="detail.edit.admin"/>
<spring:message var="autoMsg_9631b4c050" code="detail.edit.mine"/>
<spring:message var="autoMsg_ff14ce1d34" code="detail.edit.admin.desc"/>
<spring:message var="autoMsg_ef8f21a2de" code="detail.edit.user.desc"/>
<spring:message var="autoMsg_33fe4192c2" code="detail.edit.open"/>
<spring:message var="autoMsg_d9ccc0deff" code="detail.delete.confirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_7bcf2698e9" code="detail.delete"/>
<spring:message var="autoMsg_4255caff58" code="detail.edit.title"/>
<spring:message var="autoMsg_c9a31553cb" code="detail.edit.subtitle"/>
<spring:message var="autoMsg_b4f959ac1c" code="explore.form.name"/>
<spring:message var="autoMsg_7731772680" code="detail.info.region"/>
<spring:message var="autoMsg_5e30f0ac47" code="detail.info.address"/>
<spring:message var="autoMsg_d881a9788e" code="explore.form.lat"/>
<spring:message var="autoMsg_8c08226022" code="explore.form.lng"/>
<spring:message var="autoMsg_a923a49edb" code="explore.form.description"/>
<spring:message var="autoMsg_a120b29936" code="explore.form.image"/>
<spring:message var="autoMsg_aaab74708a" code="explore.form.tags"/>
<spring:message var="autoMsg_6970b19300" code="explore.cancel"/>
<spring:message var="autoMsg_ed0223cde6" code="explore.save"/>
<spring:message var="autoMsg_1e1668a583" code="detail.info.title"/>
<spring:message var="autoMsg_1da30e62a1" code="detail.info.rating"/>
<spring:message var="autoMsg_3b90a30247" code="detail.review.title"/>
<spring:message var="autoMsg_f3d5734333" code="explore.count"/>
<spring:message var="autoMsg_bcc6e7d1f2" code="detail.info.noReview"/>
<spring:message var="autoMsg_a71efec490" code="detail.info.like"/>
<spring:message var="autoMsg_ebf9e656d7" code="detail.intro.title"/>
<spring:message var="autoMsg_abe7e7a95a" code="detail.tags.title"/>
<spring:message var="autoMsg_7d5a4da44c" code="detail.package.imageAlt" javaScriptEscape="true"/>
<spring:message var="autoMsg_77f86a125f" code="detail.location.title"/>
<spring:message var="autoMsg_2ecc46d7bc" code="detail.review.total"/>
<spring:message var="autoMsg_7486c5c523" code="detail.review.write"/>
<spring:message var="autoMsg_ee3088460b" code="detail.review.placeholder"/>
<spring:message var="autoMsg_a2cd1a61bf" code="detail.review.submit"/>
<spring:message var="autoMsg_c795565e05" code="detail.review.written"/>
<spring:message var="autoMsg_d0ab6c7989" code="detail.review.login.need"/>
<spring:message var="autoMsg_63e8959397" code="detail.review.login"/>
<spring:message var="autoMsg_f0ebac93ca" code="detail.review.admin.selectAll"/>
<spring:message var="autoMsg_8daba712e1" code="detail.review.admin.help"/>
<spring:message var="autoMsg_ca78d9f589" code="community.detail.userReport"/>
<spring:message var="autoMsg_94fa83bd66" code="community.detail.report"/>
<spring:message var="autoMsg_b1124bd3b4" code="detail.review.delete"/>
<spring:message var="autoMsg_a985a82f30" code="detail.review.block"/>
<spring:message var="autoMsg_6cceb0a144" code="detail.ai.title"/>
<spring:message var="autoMsg_c5e15f91f8" code="detail.explore.more"/>
<spring:message var="autoMsg_09687754cb" code="community.detail.report.title"/>
<spring:message var="autoMsg_22acf32472" code="community.detail.report.reason"/>
<spring:message var="autoMsg_ec939a1fb7" code="community.detail.report.reason.choose"/>
<spring:message var="autoMsg_892b5724bb" code="community.detail.report.reason.spam"/>
<spring:message var="autoMsg_bce59fbfd9" code="community.detail.report.reason.abuse"/>
<spring:message var="autoMsg_c095d8c7ce" code="community.detail.report.reason.privacy"/>
<spring:message var="autoMsg_d97082c998" code="community.detail.report.reason.illegal"/>
<spring:message var="autoMsg_24ca2dc020" code="community.detail.report.reason.other"/>
<spring:message var="autoMsg_77a41fec80" code="community.detail.report.description"/>
<spring:message var="autoMsg_9b0abd03a8" code="community.detail.report.description.placeholder"/>
<spring:message var="autoMsg_ad8ea8e20e" code="community.detail.cancel"/>
<spring:message var="autoMsg_f59b85e3ad" code="community.detail.report.submit"/>
<spring:message var="autoMsg_84a57dc4cd" code="community.detail.userReport.title"/>
<spring:message var="autoMsg_465c990282" code="community.detail.userReport.description"/>
<spring:message var="autoMsg_f44c70ae24" code="community.detail.userReport.placeholder"/>
<spring:message var="autoMsg_0533c80ab2" code="detail.common.error" javaScriptEscape="true"/>
<spring:message var="autoMsg_5b3b4d0f7a" code="detail.common.loginRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_d49baedede" code="detail.edit.tags.max" javaScriptEscape="true"/>
<spring:message var="autoMsg_11c3b20f7d" code="detail.fav.added" javaScriptEscape="true"/>
<spring:message var="autoMsg_b1fd0ed5a0" code="detail.fav.removed" javaScriptEscape="true"/>
<spring:message var="autoMsg_5214d1ab65" code="detail.like.added" javaScriptEscape="true"/>
<spring:message var="autoMsg_788bdb83fc" code="detail.like.removed" javaScriptEscape="true"/>
<spring:message var="autoMsg_7f8633fbc9" code="detail.review.submit.loading" javaScriptEscape="true"/>
<spring:message var="autoMsg_1ab2849ef2" code="detail.review.submit.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_f5789cadc1" code="detail.review.submit.success" javaScriptEscape="true"/>
<spring:message var="autoMsg_ead131b839" code="detail.review.delete.confirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_0643fc5936" code="detail.review.delete.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_22f8071df6" code="detail.review.delete.success" javaScriptEscape="true"/>
<spring:message var="autoMsg_0c60c7802a" code="detail.review.empty.visible" javaScriptEscape="true"/>
<spring:message var="autoMsg_7a7196f900" code="detail.review.block.confirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_b64f9ce751" code="detail.review.block.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_1266d379f9" code="detail.review.block.success" javaScriptEscape="true"/>
<spring:message var="autoMsg_a6dd1feffa" code="detail.review.block.none" javaScriptEscape="true"/>
<spring:message var="autoMsg_d558dd7f7d" code="detail.review.block.bulkConfirmAll" javaScriptEscape="true"/>
<spring:message var="autoMsg_0b4625057f" code="detail.review.block.bulkConfirmSelected" javaScriptEscape="true"/>
<spring:message var="autoMsg_5fa2784d11" code="detail.review.block.bulkSuccess" javaScriptEscape="true"/>
<spring:message var="autoMsg_3b8a3f2b5d" code="detail.review.admin.blockSelected" javaScriptEscape="true"/>
<spring:message var="autoMsg_5bd7c4703c" code="detail.review.like.success" javaScriptEscape="true"/>
<spring:message var="autoMsg_486a5fd302" code="detail.review.write" javaScriptEscape="true"/>
<spring:message var="autoMsg_104523f557" code="detail.review.submit" javaScriptEscape="true"/>
<spring:message var="autoMsg_48a1167ef8" code="detail.review.empty" javaScriptEscape="true"/>
<spring:message var="autoMsg_0005bf699e" code="detail.package.booking.loginAction" javaScriptEscape="true"/>
<spring:message var="autoMsg_37e76eae10" code="detail.package.booking.action" javaScriptEscape="true"/>
<spring:message var="autoMsg_bc8c678d03" code="detail.package.booking.loginRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_0b814dda73" code="detail.package.booking.insufficientCash" javaScriptEscape="true"/>
<spring:message var="autoMsg_8eeec2a018" code="detail.package.booking.processing" javaScriptEscape="true"/>
<spring:message var="autoMsg_672a4ede58" code="detail.package.booking.error" javaScriptEscape="true"/>
<spring:message var="autoMsg_10e9dc3c7d" code="detail.package.booking.success" javaScriptEscape="true"/>
<spring:message var="autoMsg_71e904bade" code="detail.flight.dateRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_cd44f0d7cf" code="detail.flight.returnDateInvalid" javaScriptEscape="true"/>
<spring:message var="autoMsg_91a3993f6d" code="detail.flight.noDiscount" javaScriptEscape="true"/>
<spring:message var="autoMsg_2040f14ea0" code="detail.flight.loading" javaScriptEscape="true"/>
<spring:message var="autoMsg_571aeb4cc3" code="detail.flight.empty" javaScriptEscape="true"/>
<spring:message var="autoMsg_663d9e9bea" code="detail.flight.loadFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_4c6166fa9b" code="detail.flight.outboundLabel" javaScriptEscape="true"/>
<spring:message var="autoMsg_2732585e57" code="detail.flight.returnLabel" javaScriptEscape="true"/>
<spring:message var="autoMsg_df1bd59f60" code="detail.flight.departLabel" javaScriptEscape="true"/>
<spring:message var="autoMsg_43a23027a2" code="detail.flight.arriveLabel" javaScriptEscape="true"/>
<spring:message var="autoMsg_c9215db6ab" code="detail.flight.mileageLimit" javaScriptEscape="true"/>
<spring:message var="autoMsg_ca5547106e" code="detail.flight.loginRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_4bed199b34" code="detail.flight.selectOffer" javaScriptEscape="true"/>
<spring:message var="autoMsg_b84d9ec61f" code="detail.flight.purchaseFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_ce05461c95" code="detail.flight.purchaseError" javaScriptEscape="true"/>
<spring:message var="autoMsg_b48c522b0e" code="detail.flight.purchaseSuccess" javaScriptEscape="true"/>
<spring:message var="autoMsg_92d7f2a24d" code="detail.location.noCoordinates" javaScriptEscape="true"/>
<spring:message var="autoMsg_cbc4a42159" code="detail.ai.loadFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_11daf76bca" code="community.detail.report.reasonRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_920f39533f" code="community.detail.report.submitted" javaScriptEscape="true"/>
<spring:message var="autoMsg_4fb166adbe" code="community.detail.request.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_c3447494a0" code="community.detail.userReport.minLength" javaScriptEscape="true"/>
<spring:message var="autoMsg_385faf859f" code="detail.fav.done" javaScriptEscape="true"/>
<spring:message var="autoMsg_3335ae8313" code="detail.fav.do" javaScriptEscape="true"/>
<spring:message var="autoMsg_9a1bf4bea9" code="detail.like.done" javaScriptEscape="true"/>
<spring:message var="autoMsg_9e04b6024d" code="detail.like.do" javaScriptEscape="true"/>
<spring:message var="autoMsg_16702be3c7" code="detail.review.placeholder" javaScriptEscape="true"/>
<spring:message var="autoMsg_7fd241d1aa" code="detail.ai.desc"/>
<spring:message var="autoMsg_52ebf8001d" code="detail.ai.trending.title"/>
<spring:message var="autoMsg_b50aa39cea" code="detail.ai.trending.desc"/>
<c:set var="pageCSS" value="explore/explore.css"/>
<%@ include file="../common/header.jsp" %>

<body>
<spring:message code="detail.common.close" var="detailCloseLabel"/>
<spring:message code="detail.package.title" var="detailPackageTitleLabel"/>
<spring:message code="detail.package.carousel" var="detailPackageCarouselLabel"/>
<spring:message code="detail.package.prev" var="detailPackagePrevLabel"/>
<spring:message code="detail.package.next" var="detailPackageNextLabel"/>
<spring:message code="detail.package.period.always" var="detailPackagePeriodAlwaysLabel"/>
<spring:message code="detail.package.defaultSummary" var="detailPackageDefaultSummaryLabel"/>
<spring:message code="detail.package.price" var="detailPackagePriceLabel"/>
<spring:message code="detail.package.period" var="detailPackagePeriodLabel"/>
<spring:message code="detail.package.people" var="detailPackagePeopleLabel"/>
<spring:message code="detail.package.seller" var="detailPackageSellerLabel"/>
<spring:message code="detail.package.booking.title" var="detailPackageBookingTitleLabel"/>
<spring:message code="detail.package.booking.people" var="detailPackageBookingPeopleLabel"/>
<spring:message code="detail.package.booking.mileage" var="detailPackageBookingMileageLabel"/>
<spring:message code="detail.package.booking.total" var="detailPackageBookingTotalLabel"/>
<spring:message code="detail.package.booking.maxMileage" var="detailPackageBookingMaxMileageLabel"/>
<spring:message code="detail.package.booking.cash" var="detailPackageBookingCashLabel"/>
<spring:message code="detail.package.booking.balance" var="detailPackageBookingBalanceLabel"/>
<spring:message code="detail.package.booking.action" var="detailPackageBookingActionLabel"/>
<spring:message code="detail.flight.cheapestFromSeoul" var="detailFlightCheapestLabel"/>
<spring:message code="detail.flight.modal.title" var="detailFlightTitleLabel"/>
<spring:message code="detail.flight.modal.subtitle" var="detailFlightSubtitleLabel"/>
<spring:message code="detail.flight.departureDate" var="detailFlightDepartureDateLabel"/>
<spring:message code="detail.flight.returnDate" var="detailFlightReturnDateLabel"/>
<spring:message code="detail.flight.loading" var="detailFlightLoadingLabel"/>
<spring:message code="detail.flight.originalPrice" var="detailFlightOriginalPriceLabel"/>
<spring:message code="detail.flight.gradeDiscount" var="detailFlightGradeDiscountLabel"/>
<spring:message code="detail.flight.totalPrice" var="detailFlightTotalPriceLabel"/>
<spring:message code="detail.flight.cashBalance" var="detailFlightCashBalanceLabel"/>
<spring:message code="detail.flight.mileageBalance" var="detailFlightMileageBalanceLabel"/>
<spring:message code="detail.flight.useMileage" var="detailFlightUseMileageLabel"/>
<spring:message code="detail.flight.useCash" var="detailFlightUseCashLabel"/>
<spring:message code="detail.flight.useMaxMileage" var="detailFlightUseMaxMileageLabel"/>
<spring:message code="detail.flight.purchase" var="detailFlightPurchaseLabel"/>
<style>
html { scrollbar-gutter: stable; }
/* 히어로 영역 */
.det-hero { position:relative; height:420px; overflow:hidden; background:var(--gray-200); }
.det-hero img { width:100%; height:100%; object-fit:cover; display:block; }
.det-hero-ov { position:absolute; inset:0; background:linear-gradient(to bottom,rgba(0,0,0,.1),rgba(0,0,0,.55)); }
.det-hero-content { position:absolute; bottom:36px; left:36px; right:36px; color:#fff; }
.det-hero-content h1 { font-size:2.4rem; font-weight:700; text-shadow:0 2px 8px rgba(0,0,0,.4); margin-bottom:8px; }
.det-hero-meta { display:flex; align-items:center; gap:16px; font-size:15px; font-weight:500; text-shadow:0 1px 4px rgba(0,0,0,.4); }
.det-hero-rat .star { color:#fbbf24; font-size:18px; }

/* 본문 레이아웃 */
.det-body {
  max-width:960px;
  width:100%;
  margin:0 auto;
  padding:40px 24px 80px;
  box-sizing:border-box;
}

/* 액션 버튼 영역 */
.det-actions { display:flex; gap:12px; margin-bottom:36px; flex-wrap:wrap; }
.det-action-btn {
  display:flex; align-items:center; gap:8px;
  padding:10px 20px; border-radius:10px;
  border:1.5px solid var(--gray-200); background:#fff;
  font-family:inherit; font-size:14px; font-weight:500; color:var(--gray-700);
  cursor:pointer; transition:all .2s; box-shadow:var(--shadow-sm);
}
.det-action-btn:hover { border-color:var(--blue); color:var(--blue); }
.det-action-btn.active { background:var(--blue-light); color:var(--blue); border-color:var(--blue); }
.det-action-icon { font-size:18px; line-height:1; color:var(--gray-400); }
.det-action-label { line-height:1.2; }
.det-action-btn.active .det-action-icon { color:var(--blue); }
.det-action-btn.fav-btn.active .det-action-icon { color:#f59e0b; }
.det-action-btn.like-btn.active .det-action-icon { color:#ef4444; }
.det-back-btn {
  background:none; border:none; color:var(--gray-500); font-family:inherit;
  font-size:14px; font-weight:500; cursor:pointer; padding:0;
  display:flex; align-items:center; gap:4px; margin-bottom:24px; transition:color .15s;
}
.det-back-btn:hover { color:var(--blue); }

/* 섹션 카드 공통 */
.det-section {
  background:#fff; border-radius:var(--radius);
  padding:28px 32px; margin-bottom:24px;
  box-shadow:var(--shadow-sm); border:1px solid var(--gray-100);
  width:100%;
  box-sizing:border-box;
}
.det-section h2 {
  font-size:1.1rem; font-weight:700; color:var(--gray-800);
  margin-bottom:16px; padding-bottom:12px; border-bottom:1px solid var(--gray-100);
}

/* 기본 정보 그리드 */
.info-grid { display:grid; gap:14px; }
.info-row { display:flex; align-items:flex-start; gap:12px; font-size:14px; }
.info-label { width:70px; flex-shrink:0; color:var(--gray-500); font-weight:500; }
.info-value { color:var(--gray-700); line-height:1.6; }
.det-desc { font-size:15px; color:var(--gray-700); line-height:1.8; }
.det-tags { display:flex; flex-wrap:wrap; gap:8px; }

/* 지도 플레이스홀더 */
.map-placeholder {
  width:100%; height:220px;
  background:linear-gradient(135deg,var(--blue-light),#f5f3ff);
  border-radius:10px; display:flex; align-items:center; justify-content:center;
  font-size:14px; color:var(--gray-500); flex-direction:column; gap:8px;
}
.map-placeholder .map-icon { font-size:36px; }
.flight-map-wrap { position:relative; }
.flight-price-chip {
  position:absolute; left:18px; bottom:18px; z-index:5;
  border:0; border-radius:999px; padding:11px 16px;
  background:#111827; color:#fff; font-family:inherit; cursor:pointer;
  box-shadow:0 12px 28px rgba(17,24,39,.26);
  display:flex; align-items:center; gap:10px; transition:transform .16s, box-shadow .16s;
}
.flight-price-chip:hover { transform:translateY(-2px); box-shadow:0 16px 32px rgba(17,24,39,.32); }
.flight-price-chip .flight-chip-icon { font-size:18px; }
.flight-price-chip .flight-chip-label { display:block; font-size:11px; opacity:.78; line-height:1.1; }
.flight-price-chip .flight-chip-price { display:block; font-size:15px; font-weight:800; line-height:1.2; }
.flight-modal {
  display:none; position:fixed; inset:0; z-index:10000;
  background:rgba(15,23,42,.58); align-items:center; justify-content:center;
  padding:20px; box-sizing:border-box;
}
.flight-modal.show { display:flex; }
.flight-modal-card {
  width:min(640px, 100%); max-height:90vh; overflow:auto;
  background:#fff; border-radius:18px; box-shadow:0 24px 60px rgba(15,23,42,.28);
}
.flight-modal-head {
  display:flex; align-items:flex-start; justify-content:space-between; gap:16px;
  padding:24px 26px; border-bottom:1px solid var(--gray-100);
}
.flight-modal-title { font-size:20px; font-weight:800; color:var(--gray-900); margin:0 0 6px; }
.flight-modal-sub { font-size:13px; color:var(--gray-500); line-height:1.5; }
.flight-modal-close { border:0; background:none; font-size:24px; color:var(--gray-400); cursor:pointer; line-height:1; }
.flight-modal-body { padding:24px 26px 28px; }
.flight-date-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px; margin-bottom:18px; }
.flight-date-field { display:flex; flex-direction:column; gap:7px; }
.flight-date-field label { font-size:12px; font-weight:800; color:var(--gray-600); }
.flight-date-field input {
  width:100%; box-sizing:border-box; border:1.5px solid var(--gray-200);
  border-radius:10px; padding:10px 12px; font-family:inherit; font-weight:700; color:var(--gray-800);
}
.flight-offer-list { display:grid; gap:12px; margin-bottom:22px; }
.flight-offer-card {
  border:1.5px solid var(--gray-200); border-radius:14px; padding:16px;
  cursor:pointer; transition:border-color .16s, box-shadow .16s, background .16s;
}
.flight-offer-card.active {
  border-color:var(--blue); background:var(--blue-light); box-shadow:0 8px 20px rgba(37,99,235,.12);
}
.flight-offer-top { display:flex; justify-content:space-between; gap:16px; margin-bottom:10px; }
.flight-airline { font-weight:800; color:var(--gray-900); }
.flight-no { font-size:12px; color:var(--gray-500); margin-top:2px; }
.flight-price { font-weight:900; color:var(--blue); white-space:nowrap; }
.flight-route { display:flex; align-items:center; gap:10px; color:var(--gray-700); font-size:14px; }
.flight-route strong { color:var(--gray-900); }
.flight-pay-box { border:1px solid var(--gray-100); background:var(--gray-50); border-radius:14px; padding:18px; }
.flight-pay-row { display:flex; justify-content:space-between; align-items:center; gap:12px; margin-bottom:12px; font-size:14px; }
.flight-pay-row strong { color:var(--gray-900); }
.flight-pay-input {
  width:160px; max-width:50%; padding:9px 10px; border:1.5px solid var(--gray-200);
  border-radius:9px; text-align:right; font-family:inherit; font-weight:700;
}
.flight-pay-actions { display:flex; justify-content:flex-end; gap:10px; margin-top:16px; flex-wrap:wrap; }
.flight-pay-btn {
  border:0; border-radius:10px; padding:10px 18px; font-family:inherit; font-weight:700; cursor:pointer;
}
.flight-pay-btn.secondary { background:#fff; color:var(--gray-700); border:1px solid var(--gray-200); }
.flight-pay-btn.primary { background:var(--blue); color:#fff; }
.flight-pay-msg { margin-top:12px; font-size:13px; color:var(--gray-600); min-height:18px; }
@media (max-width:640px) {
  .flight-date-grid { grid-template-columns:1fr; }
}

/* 연결 패키지 상품 */
.detail-package-head {
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:14px;
  margin-bottom:16px;
  padding-bottom:12px;
  border-bottom:1px solid var(--gray-100);
}
.detail-package-head h2 {
  margin:0;
  padding:0;
  border:0;
}
.detail-package-controls {
  display:flex;
  align-items:center;
  gap:8px;
  flex-shrink:0;
}
.detail-package-page {
  min-width:58px;
  color:var(--gray-500);
  font-size:13px;
  font-weight:800;
  text-align:center;
}
.detail-package-nav {
  width:34px;
  height:34px;
  border:1px solid var(--gray-200);
  border-radius:50%;
  background:#fff;
  color:var(--gray-700);
  font-size:18px;
  font-weight:800;
  cursor:pointer;
  box-shadow:var(--shadow-sm);
  transition:background .15s, color .15s, border-color .15s, opacity .15s;
}
.detail-package-nav:hover:not(:disabled) {
  border-color:var(--blue);
  background:var(--blue);
  color:#fff;
}
.detail-package-nav:disabled {
  opacity:.35;
  cursor:not-allowed;
}
.detail-package-carousel {
  position:relative;
  overflow:hidden;
}
.detail-package-grid {
  display:flex;
  gap:14px;
  overflow-x:auto;
  overflow-y:hidden;
  scroll-behavior:smooth;
  scroll-snap-type:x mandatory;
  scrollbar-width:none;
  padding:2px 2px 10px;
}
.detail-package-grid::-webkit-scrollbar {
  display:none;
}
.detail-package-card {
  overflow:hidden;
  flex:0 0 280px;
  scroll-snap-align:start;
  border:1px solid var(--gray-200);
  border-radius:14px;
  background:#fff;
  box-shadow:var(--shadow-sm);
  cursor:pointer;
  transition:transform .16s, box-shadow .16s, border-color .16s;
}
.detail-package-card:hover {
  transform:translateY(-2px);
  border-color:#bfdbfe;
  box-shadow:0 14px 28px rgba(15,23,42,.12);
}
.detail-package-thumb {
  position:relative;
  overflow:hidden;
  height:132px;
  background:linear-gradient(135deg,var(--blue-light),#fff7ed);
  display:grid;
  place-items:center;
  color:var(--blue);
  font-weight:800;
}
.detail-package-thumb img {
  position:absolute;
  inset:0;
  width:100%;
  height:100%;
  object-fit:cover;
}
.detail-package-body {
  padding:16px;
}
.detail-package-spot {
  margin:0 0 6px;
  color:var(--blue);
  font-size:12px;
  font-weight:800;
}
.detail-package-title {
  margin:0;
  color:var(--gray-900);
  font-size:16px;
  font-weight:800;
  line-height:1.35;
}
.detail-package-summary {
  min-height:40px;
  margin:8px 0 14px;
  color:var(--gray-500);
  font-size:13px;
  line-height:1.55;
}
.detail-package-meta {
  display:grid;
  gap:8px;
  margin:0;
}
.detail-package-meta div {
  display:flex;
  justify-content:space-between;
  gap:10px;
  border-radius:10px;
  padding:8px 10px;
  background:var(--gray-50);
  font-size:13px;
}
.detail-package-meta dt { color:var(--gray-500); font-weight:700; }
.detail-package-meta dd { margin:0; color:var(--gray-800); font-weight:800; text-align:right; }
.detail-package-modal {
  display:none;
  position:fixed;
  inset:0;
  z-index:10020;
  align-items:center;
  justify-content:center;
  padding:22px;
  background:rgba(15,23,42,.62);
  box-sizing:border-box;
}
.detail-package-modal.show {
  display:flex;
}
.detail-package-modal-card {
  width:min(680px,100%);
  max-height:90vh;
  overflow:auto;
  border-radius:20px;
  background:#fff;
  box-shadow:0 24px 64px rgba(15,23,42,.3);
}
.detail-package-modal-hero {
  position:relative;
  overflow:hidden;
  height:220px;
  background:linear-gradient(135deg,var(--blue-light),#fff7ed);
  display:grid;
  place-items:center;
  color:var(--blue);
  font-weight:900;
}
.detail-package-modal-hero img {
  position:absolute;
  inset:0;
  width:100%;
  height:100%;
  object-fit:cover;
}
.detail-package-modal-close {
  position:absolute;
  top:14px;
  right:14px;
  z-index:2;
  width:36px;
  height:36px;
  border:0;
  border-radius:50%;
  background:rgba(15,23,42,.72);
  color:#fff;
  font-size:22px;
  cursor:pointer;
}
.detail-package-modal-body {
  padding:24px 26px 28px;
}
.detail-package-modal-kicker {
  margin:0 0 8px;
  color:var(--blue);
  font-size:12px;
  font-weight:900;
}
.detail-package-modal-title {
  margin:0;
  color:var(--gray-900);
  font-size:24px;
  font-weight:900;
  line-height:1.35;
}
.detail-package-modal-summary {
  margin:12px 0 18px;
  color:var(--gray-600);
  line-height:1.7;
  white-space:pre-wrap;
}
.detail-package-modal-meta {
  display:grid;
  grid-template-columns:repeat(2,minmax(0,1fr));
  gap:10px;
  margin:0;
}
.detail-package-modal-meta div {
  border-radius:14px;
  padding:12px 14px;
  background:var(--gray-50);
}
.detail-package-modal-meta dt {
  margin-bottom:5px;
  color:var(--gray-500);
  font-size:12px;
  font-weight:800;
}
.detail-package-modal-meta dd {
  margin:0;
  color:var(--gray-900);
  font-weight:900;
}
.detail-package-booking {
  margin-top:18px;
  border:1px solid #bfdbfe;
  border-radius:16px;
  padding:16px;
  background:#eff6ff;
}
.detail-package-booking h4 {
  margin:0 0 12px;
  color:var(--gray-900);
  font-size:15px;
  font-weight:900;
}
.detail-package-booking-grid {
  display:grid;
  grid-template-columns:repeat(2,minmax(0,1fr));
  gap:10px;
}
.detail-package-booking-field {
  display:flex;
  flex-direction:column;
  gap:6px;
}
.detail-package-booking-field label {
  color:var(--gray-600);
  font-size:12px;
  font-weight:800;
}
.detail-package-booking-field input {
  width:100%;
  border:1px solid #cbd5e1;
  border-radius:10px;
  padding:10px 12px;
  font-family:inherit;
  font-weight:800;
  box-sizing:border-box;
}
.detail-package-pay-summary {
  display:grid;
  gap:8px;
  margin-top:12px;
}
.detail-package-pay-summary div {
  display:flex;
  justify-content:space-between;
  gap:10px;
  color:var(--gray-700);
  font-size:13px;
}
.detail-package-pay-summary strong {
  color:var(--gray-900);
}
.detail-package-booking-actions {
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  margin-top:14px;
  flex-wrap:wrap;
}
.detail-package-booking-message {
  min-height:18px;
  color:var(--gray-600);
  font-size:13px;
  font-weight:700;
}
.detail-package-booking-message.is-error {
  color:#dc2626;
}
.detail-package-booking-message.is-success {
  color:#166534;
}
.detail-package-booking-btn {
  border:0;
  border-radius:10px;
  padding:10px 18px;
  background:var(--blue);
  color:#fff;
  font-family:inherit;
  font-weight:900;
  cursor:pointer;
}
.detail-package-booking-btn:disabled {
  opacity:.55;
  cursor:not-allowed;
}
@media (max-width:640px) {
  .detail-package-head {
    align-items:flex-start;
    flex-direction:column;
  }
  .detail-package-controls {
    align-self:flex-end;
  }
  .detail-package-card {
    flex-basis:82%;
  }
  .detail-package-modal-meta {
    grid-template-columns:1fr;
  }
  .detail-package-booking-grid {
    grid-template-columns:1fr;
  }
  .detail-package-modal-hero {
    height:180px;
  }
}

/* 리뷰 요약 헤더 */
.review-summary-wrap {
  display:flex; align-items:center; gap:32px;
  padding-bottom:24px; margin-bottom:24px;
  border-bottom:1px solid var(--gray-100); flex-wrap:wrap;
}
.review-big-score { font-size:3.2rem; font-weight:800; color:var(--blue); line-height:1; }
.review-stars-big { font-size:22px; letter-spacing:3px; margin:6px 0 4px; }
.review-sub { font-size:13px; color:var(--gray-400); }

/* 별점 선택기 */
.star-picker { display:flex; gap:6px; margin-bottom:12px; }
.star-picker .sp { font-size:28px; cursor:pointer; color:var(--gray-200); transition:color .1s; }
.star-picker .sp.on { color:#f59e0b; }

/* 리뷰 작성 폼 */
.review-form-box {
  background:var(--gray-50); border-radius:10px;
  padding:20px; margin-bottom:28px;
  border:1.5px solid var(--gray-200);
}
.review-form-box h3 { font-size:15px; font-weight:700; margin-bottom:14px; color:var(--gray-800); }
.review-textarea {
  width:100%; min-height:90px;
  padding:12px 14px; border:1.5px solid var(--gray-200);
  border-radius:9px; font-family:inherit; font-size:14px;
  resize:vertical; outline:none; transition:border-color .2s;
  background:#fff;
}
.review-textarea:focus { border-color:var(--blue); }
.review-form-foot { display:flex; justify-content:space-between; align-items:center; margin-top:10px; flex-wrap:wrap; gap:8px; }
.review-char { font-size:12px; color:var(--gray-400); }
.review-submit-btn {
  padding:9px 22px; border-radius:9px; border:none;
  background:var(--blue); color:#fff; font-family:inherit;
  font-size:14px; font-weight:600; cursor:pointer; transition:background .2s;
}
.review-submit-btn:hover { background:#1d4ed8; }
.review-submit-btn:disabled { opacity:.5; cursor:not-allowed; }

/* 로그인 유도 박스 */
.review-login-box {
  background:var(--blue-light); border-radius:10px;
  padding:20px 24px; margin-bottom:28px;
  display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:12px;
  border:1.5px solid #bfdbfe;
}
.review-login-box p { font-size:14px; color:var(--blue); font-weight:500; margin:0; }
.review-login-link {
  padding:8px 18px; border-radius:8px;
  background:var(--blue); color:#fff; font-size:14px; font-weight:600;
  text-decoration:none; transition:background .2s;
  white-space:nowrap;
}
.review-login-link:hover { background:#1d4ed8; }

/* 리뷰 카드 목록 */
.review-list { display:flex; flex-direction:column; gap:16px; }
.review-admin-tools {
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  margin-bottom:16px;
  padding:12px 14px;
  border:1px solid #fed7aa;
  border-radius:10px;
  background:#fff7ed;
  flex-wrap:wrap;
}
.review-admin-left {
  display:flex;
  align-items:center;
  gap:10px;
  flex-wrap:wrap;
}
.review-admin-select-all {
  display:inline-flex;
  align-items:center;
  gap:8px;
  font-size:13px;
  font-weight:600;
  color:#9a3412;
}
.review-admin-bulk-btn {
  padding:8px 14px;
  border-radius:8px;
  border:1px solid #fdba74;
  background:#fff;
  color:#c2410c;
  font-family:inherit;
  font-size:13px;
  font-weight:700;
  cursor:pointer;
}
.review-admin-bulk-btn:disabled {
  opacity:.5;
  cursor:not-allowed;
}
.review-card {
  padding:18px 20px; border-radius:10px;
  background:var(--gray-50); border:1px solid var(--gray-200);
}
.review-card.admin-selecting {
  border-color:#fdba74;
  background:#fff7ed;
}
.review-card-top { display:flex; align-items:center; justify-content:space-between; margin-bottom:8px; flex-wrap:wrap; gap:8px; }
.review-author-info { display:flex; align-items:center; gap:10px; }
.review-admin-check {
  width:18px;
  height:18px;
  accent-color:#ea580c;
  cursor:pointer;
}
.review-avatar {
  width:36px; height:36px; border-radius:50%;
  background:linear-gradient(135deg,var(--blue),var(--purple));
  display:flex; align-items:center; justify-content:center;
  color:#fff; font-weight:700; font-size:14px; flex-shrink:0;
}
.review-nickname { font-size:14px; font-weight:600; color:var(--gray-800); }
.review-date { font-size:12px; color:var(--gray-400); margin-top:1px; }
.review-stars-small { font-size:14px; letter-spacing:1px; }
.review-content { font-size:14px; color:var(--gray-700); line-height:1.65; margin-top:8px; }
.review-delete-btn {
  background:none; border:none; color:var(--gray-400);
  font-size:12px; cursor:pointer; padding:4px 8px;
  border-radius:6px; transition:all .15s;
}
.review-delete-btn:hover { background:#fee2e2; color:#ef4444; }
.review-action-row { display:flex; align-items:center; gap:8px; flex-wrap:wrap; }
.review-like-btn,
.review-report-btn {
  background:none;
  border:1px solid var(--gray-200);
  color:var(--gray-500);
  font-size:12px;
  cursor:pointer;
  padding:5px 9px;
  border-radius:999px;
  transition:all .15s;
}
.review-like-btn:hover,
.review-report-btn:hover { border-color:var(--blue); color:var(--blue); }
.review-like-btn.active { border-color:#fca5a5; color:#ef4444; background:#fff1f2; }
.review-user-report-link {
  font-size:11px;
  color:var(--gray-400);
  cursor:pointer;
  text-decoration:underline;
}
.review-user-report-link:hover { color:var(--blue); }
.review-empty { text-align:center; padding:36px; color:var(--gray-400); font-size:14px; }
.ai-rec-content {
  min-height: 420px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.ai-rec-state {
  text-align: center;
  padding: 32px;
  color: var(--gray-400);
  font-size: 14px;
}

/* 관리자 편집 영역 */
.det-admin-bar {
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  padding:16px 18px;
  margin-bottom:24px;
  border:1px solid #bfdbfe;
  border-radius:14px;
  background:#eff6ff;
  flex-wrap:wrap;
}
.det-admin-copy { font-size:13px; color:#1d4ed8; line-height:1.6; }
.det-admin-actions { display:flex; gap:10px; flex-wrap:wrap; }
.det-admin-btn {
  padding:10px 16px;
  border-radius:10px;
  border:1px solid #93c5fd;
  background:#fff;
  color:#1d4ed8;
  font-family:inherit;
  font-size:13px;
  font-weight:700;
  cursor:pointer;
}
.det-admin-btn.danger {
  border-color:#fecaca;
  color:#dc2626;
}
.det-admin-review-btn {
  background:#fff7ed;
  border:1px solid #fdba74;
  color:#c2410c;
  font-size:12px;
  cursor:pointer;
  padding:5px 9px;
  border-radius:6px;
}
.det-admin-modal {
  position:fixed;
  inset:0;
  display:none;
  align-items:center;
  justify-content:center;
  background:rgba(15, 23, 42, .56);
  z-index:1200;
  padding:20px;
}
.det-admin-modal.show { display:flex; }
.det-admin-dialog {
  width:min(920px, 100%);
  max-height:calc(100vh - 40px);
  overflow-y:auto;
  background:#fff;
  border-radius:20px;
  box-shadow:0 24px 60px rgba(15, 23, 42, .28);
  padding:24px;
}
.det-admin-head {
  display:flex;
  align-items:flex-start;
  justify-content:space-between;
  gap:16px;
  margin-bottom:18px;
}
.det-admin-head h3 { margin:0 0 6px; font-size:1.2rem; color:var(--gray-800); }
.det-admin-head p { margin:0; font-size:13px; color:var(--gray-500); }
.det-admin-close {
  width:36px; height:36px; border:none; border-radius:50%;
  background:var(--gray-100); color:var(--gray-600); font-size:22px; cursor:pointer;
}
.det-admin-alert {
  padding:12px 14px;
  border-radius:12px;
  margin-bottom:16px;
  font-size:13px;
}
.det-admin-alert.error {
  background:#fef2f2;
  color:#b91c1c;
  border:1px solid #fecaca;
}
.det-admin-grid {
  display:grid;
  grid-template-columns:1fr 1fr;
  gap:14px;
}
.det-admin-field {
  display:grid;
  gap:8px;
}
.det-admin-field.full { grid-column:1 / -1; }
.det-admin-field label {
  font-size:13px;
  font-weight:700;
  color:var(--gray-700);
}
.det-admin-field input[type="text"],
.det-admin-field input[type="number"],
.det-admin-field textarea,
.det-admin-field input[type="file"] {
  width:100%;
  border:1.5px solid var(--gray-200);
  border-radius:12px;
  padding:12px 13px;
  font-family:inherit;
  font-size:14px;
  color:var(--gray-800);
  background:#fff;
  box-sizing:border-box;
}
.det-admin-field textarea {
  min-height:160px;
  resize:vertical;
}
.det-admin-tag-box {
  display:flex;
  flex-wrap:wrap;
  gap:10px;
  padding:14px;
  border:1.5px solid var(--gray-200);
  border-radius:14px;
  background:var(--gray-50);
}
.det-admin-tag {
  display:inline-flex;
  align-items:center;
  gap:8px;
  padding:8px 12px;
  background:#fff;
  border:1px solid var(--gray-200);
  border-radius:999px;
  font-size:13px;
  color:var(--gray-700);
}
.det-admin-foot {
  display:flex;
  justify-content:flex-end;
  gap:10px;
  margin-top:22px;
  flex-wrap:wrap;
}

/* 반응형 대응 */
@media (max-width:640px) {
  .det-hero { height:280px; }
  .det-hero-content h1 { font-size:1.6rem; }
  .det-hero-content { left:20px; right:20px; bottom:20px; }
  .det-body { padding:24px 16px 60px; }
  .det-section { padding:20px; }
  .det-admin-grid { grid-template-columns:1fr; }
}
</style>

<!-- 히어로 이미지 -->
<div class="det-hero">
  <img src="${not empty spot.thumbUrl
             ? spot.thumbUrl
             : 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=1200&q=80'}"
       alt="${fn:escapeXml(spot.name)}"
       onerror="this.src='https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=1200&q=80'">
  <div class="det-hero-ov"></div>
  <div class="det-hero-content">
    <h1>${fn:escapeXml(spot.name)}</h1>
    <div class="det-hero-meta">
      <c:if test="${not empty spot.region}">
        <span>${fn:escapeXml(spot.region)}</span>
      </c:if>
      <span class="det-hero-rat">
        <span class="star">&#11088;</span>
        <fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/>
        <span style="font-size:13px;opacity:.8">(${spot.reviewCount}${autoMsg_f390677e39})</span>
      </span>
      <span>&#10084; ${spot.likeCount} ${autoMsg_18cfc8ff7e}</span>
    </div>
  </div>
</div>

<!-- 상세 본문 -->
<div class="det-body">

  <button class="det-back-btn" onclick="history.back()">
    &#8592; ${autoMsg_7ba379cfc1}
  </button>

  <!-- 액션 버튼 -->
  <div class="det-actions">
    <button class="det-action-btn fav-btn ${spot.favorited ? 'active' : ''}"
            data-spot-idx="${spot.spotIdx}">
      <span class="det-action-icon">${spot.favorited ? '⭐' : '☆'}</span>
      <span class="det-action-label">
        <c:choose>
          <c:when test="${spot.favorited}">${autoMsg_59ee812003}</c:when>
          <c:otherwise>${autoMsg_27c009e3de}</c:otherwise>
        </c:choose>
      </span>
    </button>
    <button class="det-action-btn like-btn ${spot.liked ? 'active' : ''}"
            data-spot-idx="${spot.spotIdx}">
      <span class="det-action-icon">${spot.liked ? '❤️' : '🤍'}</span>
      <span class="det-action-label">
        <c:choose>
          <c:when test="${spot.liked}">${autoMsg_b1f2f74725}</c:when>
          <c:otherwise>${autoMsg_719fd9e790}</c:otherwise>
        </c:choose>
      </span>
    </button>
    <button class="det-action-btn"
            onclick="location.href='${pageContext.request.contextPath}/assistant'">
      &#10024; ${autoMsg_71a7cd69f0}
    </button>
  </div>

  <c:if test="${canEditSpot}">
    <div class="det-admin-bar">
      <div class="det-admin-copy">
        <strong>
          ${isAdminMode ? '🛡️ ' : '✏️ '}
          <c:choose>
            <c:when test="${isAdminMode}">${autoMsg_27bfcab9ef}</c:when>
            <c:otherwise>${autoMsg_9631b4c050}</c:otherwise>
          </c:choose>
        </strong><br>
        <c:choose>
          <c:when test="${isAdminMode}">${autoMsg_ff14ce1d34}</c:when>
          <c:otherwise>${autoMsg_ef8f21a2de}</c:otherwise>
        </c:choose>
      </div>
      <div class="det-admin-actions">
        <button type="button" class="det-admin-btn" id="openAdminEditBtn">${autoMsg_33fe4192c2}</button>
        <c:if test="${isAdminMode}">
          <form method="post" action="${pageContext.request.contextPath}/detail/${spot.spotIdx}/admin/delete"
                onsubmit="return confirm('${autoMsg_d9ccc0deff}');">
            <button type="submit" class="det-admin-btn danger">${autoMsg_7bcf2698e9}</button>
          </form>
        </c:if>
      </div>
    </div>
  </c:if>

  <c:if test="${canEditSpot}">
    <div class="det-admin-modal ${openAdminEditModal ? 'show' : ''}" id="adminEditModal">
      <div class="det-admin-dialog">
        <div class="det-admin-head">
          <div>
            <h3>${autoMsg_4255caff58}</h3>
            <p>${autoMsg_c9a31553cb}</p>
          </div>
          <button type="button" class="det-admin-close" id="closeAdminEditBtn">&#215;</button>
        </div>

        <c:if test="${not empty adminEditError}">
          <div class="det-admin-alert error">${fn:escapeXml(adminEditError)}</div>
        </c:if>

        <form method="post"
              action="${pageContext.request.contextPath}/detail/${spot.spotIdx}/admin/update"
              enctype="multipart/form-data"
              id="adminEditForm">
          <div class="det-admin-grid">
            <div class="det-admin-field">
              <label for="adminSpotName">${autoMsg_b4f959ac1c}</label>
              <input type="text" id="adminSpotName" name="name" maxlength="100"
                     value="${fn:escapeXml(adminEditForm.name)}" required>
            </div>
            <div class="det-admin-field">
              <label for="adminSpotRegion">${autoMsg_7731772680}</label>
              <input type="text" id="adminSpotRegion" name="region" maxlength="100"
                     value="${fn:escapeXml(adminEditForm.region)}" required>
            </div>
            <div class="det-admin-field full">
              <label for="adminSpotAddress">${autoMsg_5e30f0ac47}</label>
              <input type="text" id="adminSpotAddress" name="address" maxlength="255"
                     value="${fn:escapeXml(adminEditForm.address)}" required>
            </div>
            <div class="det-admin-field">
              <label for="adminSpotLat">${autoMsg_d881a9788e}</label>
              <input type="number" id="adminSpotLat" name="latitude" step="0.000001"
                     value="${adminEditForm.latitude}" required>
            </div>
            <div class="det-admin-field">
              <label for="adminSpotLng">${autoMsg_8c08226022}</label>
              <input type="number" id="adminSpotLng" name="longitude" step="0.000001"
                     value="${adminEditForm.longitude}" required>
            </div>
            <div class="det-admin-field full">
              <label for="adminSpotDesc">${autoMsg_a923a49edb}</label>
              <textarea id="adminSpotDesc" name="description" maxlength="2000" required>${fn:escapeXml(adminEditForm.description)}</textarea>
            </div>
            <div class="det-admin-field full">
              <label for="adminSpotImage">${autoMsg_a120b29936}</label>
              <input type="file" id="adminSpotImage" name="image" accept=".jpg,.jpeg,.png,.gif,.webp">
            </div>
            <div class="det-admin-field full">
              <label>${autoMsg_aaab74708a}</label>
              <div class="det-admin-tag-box">
                <c:forEach var="tag" items="${writeTagList}">
                  <label class="det-admin-tag">
                    <input type="checkbox" name="tags" value="${fn:escapeXml(tag)}"
                           <c:forEach var="selectedTag" items="${adminEditForm.tags}">
                             <c:if test="${selectedTag == tag}">checked</c:if>
                           </c:forEach>>
                    <span>${fn:escapeXml(tag)}</span>
                  </label>
                </c:forEach>
              </div>
            </div>
          </div>
          <div class="det-admin-foot">
            <button type="button" class="det-action-btn" id="cancelAdminEditBtn">${autoMsg_6970b19300}</button>
            <button type="submit" class="det-action-btn active">${autoMsg_ed0223cde6}</button>
          </div>
        </form>
      </div>
    </div>
  </c:if>

  <!-- 기본 정보 -->
  <div class="det-section">
    <h2>&#127760; ${autoMsg_1e1668a583}</h2>
    <div class="info-grid">
      <c:if test="${not empty spot.region}">
        <div class="info-row">
          <span class="info-label">${autoMsg_7731772680}</span>
          <span class="info-value">${fn:escapeXml(spot.region)}</span>
        </div>
      </c:if>
      <c:if test="${not empty spot.address}">
        <div class="info-row">
          <span class="info-label">${autoMsg_5e30f0ac47}</span>
          <span class="info-value">${fn:escapeXml(spot.address)}</span>
        </div>
      </c:if>
      <div class="info-row">
        <span class="info-label">${autoMsg_1da30e62a1}</span>
        <span class="info-value">
          &#11088;
          <c:choose>
            <c:when test="${spot.reviewCount > 0}">
              <fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/> / 5.0
              &nbsp;(${autoMsg_3b90a30247} ${spot.reviewCount}${autoMsg_f3d5734333})
            </c:when>
            <c:otherwise>${autoMsg_bcc6e7d1f2}</c:otherwise>
          </c:choose>
        </span>
      </div>
      <div class="info-row">
        <span class="info-label">${autoMsg_a71efec490}</span>
        <span class="info-value">&#10084; ${spot.likeCount}${autoMsg_f3d5734333}</span>
      </div>
    </div>
  </div>

  <!-- 소개 -->
  <c:if test="${not empty spot.description}">
    <div class="det-section">
      <h2>&#128214; ${autoMsg_ebf9e656d7}</h2>
      <p class="det-desc">${fn:escapeXml(spot.description)}</p>
    </div>
  </c:if>

  <!-- 태그 -->
  <c:if test="${not empty spot.tags}">
    <div class="det-section">
      <h2>&#127914; ${autoMsg_abe7e7a95a}</h2>
      <div class="det-tags">
        <c:forEach var="tag" items="${spot.tags}">
          <span class="spot-tag">${fn:escapeXml(tag)}</span>
        </c:forEach>
      </div>
    </div>
  </c:if>

  <!-- 연결 패키지 상품 -->
  <c:if test="${not empty approvedPackageList}">
    <div class="det-section">
      <div class="detail-package-head">
        <h2>&#127873; ${detailPackageTitleLabel}</h2>
        <div class="detail-package-controls" aria-label="${detailPackageCarouselLabel}">
          <button type="button" class="detail-package-nav" id="packagePrevBtn" aria-label="${detailPackagePrevLabel}">&lt;</button>
          <span class="detail-package-page" id="packagePageText">1 / 1</span>
          <button type="button" class="detail-package-nav" id="packageNextBtn" aria-label="${detailPackageNextLabel}">&gt;</button>
        </div>
      </div>
      <div class="detail-package-carousel">
        <div class="detail-package-grid" id="detailPackageRail">
          <c:forEach var="pkg" items="${approvedPackageList}">
            <c:set var="pkgPeriod">
              <c:choose>
                <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">${pkg.startDate} ~ ${pkg.endDate}</c:when>
                <c:otherwise>${detailPackagePeriodAlwaysLabel}</c:otherwise>
              </c:choose>
            </c:set>
            <c:choose>
              <c:when test="${not empty pkg.maxPeople}">
                <spring:message code="detail.package.people.range" arguments="${pkg.minPeople},${pkg.maxPeople}" var="pkgPeople"/>
              </c:when>
              <c:otherwise>
                <spring:message code="detail.package.people.minOnly" arguments="${pkg.minPeople}" var="pkgPeople"/>
              </c:otherwise>
            </c:choose>
            <spring:message code="detail.package.viewDetail" arguments="${fn:escapeXml(pkg.packageTitle)}" var="pkgDetailLabel"/>
            <fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0" var="pkgPriceText"/>
            <article class="detail-package-card"
                     tabindex="0"
                     role="button"
                     aria-label="${pkgDetailLabel}"
                     data-title="${fn:escapeXml(pkg.packageTitle)}"
                     data-summary="${fn:escapeXml(empty pkg.packageSummary ? detailPackageDefaultSummaryLabel : pkg.packageSummary)}"
                     data-content="${fn:escapeXml(pkg.packageContent)}"
                     data-image="${fn:escapeXml(pkg.mainImagePath)}"
                     data-package-idx="${pkg.packageIdx}"
                     data-unit-price="${pkg.packagePrice}"
                     data-min-people="${pkg.minPeople}"
                     data-max-people="${pkg.maxPeople}"
                     data-region="${fn:escapeXml(pkg.spotRegion)}"
                     data-spot="${fn:escapeXml(pkg.spotName)}"
                     data-price="${fn:escapeXml(pkgPriceText)} ${fn:escapeXml(pkg.currencyCode)}"
                     data-period="${fn:escapeXml(pkgPeriod)}"
                     data-people="${fn:escapeXml(pkgPeople)}"
                     data-seller="${fn:escapeXml(pkg.sellerNickname)}">
              <div class="detail-package-thumb">
                <c:choose>
                  <c:when test="${not empty pkg.mainImagePath}">
                    <img src="${fn:escapeXml(pkg.mainImagePath)}" alt="${fn:escapeXml(pkg.packageTitle)}">
                  </c:when>
                  <c:otherwise>
                    <span>TripTogether</span>
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="detail-package-body">
                <p class="detail-package-spot">${fn:escapeXml(pkg.spotRegion)} · ${fn:escapeXml(pkg.spotName)}</p>
                <h3 class="detail-package-title">${fn:escapeXml(pkg.packageTitle)}</h3>
                <p class="detail-package-summary">
                  <c:choose>
                    <c:when test="${not empty pkg.packageSummary}">${fn:escapeXml(pkg.packageSummary)}</c:when>
                    <c:otherwise>${detailPackageDefaultSummaryLabel}</c:otherwise>
                  </c:choose>
                </p>
                <dl class="detail-package-meta">
                  <div>
                    <dt>${detailPackagePriceLabel}</dt>
                    <dd><fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}</dd>
                  </div>
                  <div>
                    <dt>${detailPackagePeriodLabel}</dt>
                    <dd>
                      <c:choose>
                        <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                          ${pkg.startDate} ~ ${pkg.endDate}
                        </c:when>
                        <c:otherwise>${detailPackagePeriodAlwaysLabel}</c:otherwise>
                      </c:choose>
                    </dd>
                  </div>
                  <div>
                    <dt>${detailPackagePeopleLabel}</dt>
                    <dd>${pkgPeople}</dd>
                  </div>
                </dl>
              </div>
            </article>
          </c:forEach>
        </div>
      </div>
    </div>
    <div class="detail-package-modal" id="packageDetailModal" aria-hidden="true">
      <div class="detail-package-modal-card" role="dialog" aria-modal="true" aria-labelledby="packageModalTitle">
        <div class="detail-package-modal-hero" id="packageModalHero">
          <span id="packageModalHeroFallback">TripTogether</span>
          <button type="button" class="detail-package-modal-close" id="packageModalCloseBtn" aria-label="${detailCloseLabel}">×</button>
        </div>
        <div class="detail-package-modal-body">
          <p class="detail-package-modal-kicker" id="packageModalKicker"></p>
          <h3 class="detail-package-modal-title" id="packageModalTitle"></h3>
          <p class="detail-package-modal-summary" id="packageModalSummary"></p>
          <dl class="detail-package-modal-meta">
            <div>
              <dt>${detailPackagePriceLabel}</dt>
              <dd id="packageModalPrice"></dd>
            </div>
            <div>
              <dt>${detailPackagePeriodLabel}</dt>
              <dd id="packageModalPeriod"></dd>
            </div>
            <div>
              <dt>${detailPackagePeopleLabel}</dt>
              <dd id="packageModalPeople"></dd>
            </div>
            <div>
              <dt>${detailPackageSellerLabel}</dt>
              <dd id="packageModalSeller"></dd>
            </div>
          </dl>
          <div class="detail-package-booking">
            <h4>${detailPackageBookingTitleLabel}</h4>
            <div class="detail-package-booking-grid">
              <div class="detail-package-booking-field">
                <label for="packagePeopleCount">${detailPackageBookingPeopleLabel}</label>
                <input type="number" id="packagePeopleCount" min="1" step="1" value="1">
              </div>
              <div class="detail-package-booking-field">
                <label for="packageMileageAmount">${detailPackageBookingMileageLabel}</label>
                <input type="number" id="packageMileageAmount" min="0" step="1000" value="0">
              </div>
            </div>
            <div class="detail-package-pay-summary">
              <div><span>${detailPackageBookingTotalLabel}</span><strong id="packageBookingTotal">0 C</strong></div>
              <div><span>${detailPackageBookingMaxMileageLabel}</span><strong id="packageBookingMaxMileage">0 M</strong></div>
              <div><span>${detailPackageBookingCashLabel}</span><strong id="packageBookingCash">0 C</strong></div>
              <div><span>${detailPackageBookingBalanceLabel}</span><strong id="packageBookingBalance">0 C / 0 M</strong></div>
            </div>
            <div class="detail-package-booking-actions">
              <span class="detail-package-booking-message" id="packageBookingMessage"></span>
              <button type="button" class="detail-package-booking-btn" id="packageBookingBtn">${detailPackageBookingActionLabel}</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
    (function () {
      var rail = document.getElementById('detailPackageRail');
      var prevBtn = document.getElementById('packagePrevBtn');
      var nextBtn = document.getElementById('packageNextBtn');
      var pageText = document.getElementById('packagePageText');
      var modal = document.getElementById('packageDetailModal');
      var modalHero = document.getElementById('packageModalHero');
      var modalCloseBtn = document.getElementById('packageModalCloseBtn');
      if (!rail || !prevBtn || !nextBtn || !pageText) return;

      var pageSize = 3;
      var contextPath = '${pageContext.request.contextPath}';
      var isLoggedIn = ${not empty sessionScope.loginUser};
      var userCashBalance = Number('${empty sessionScope.loginUser ? 0 : sessionScope.loginUser.cashBalance}');
      var userMileageBalance = Number('${empty sessionScope.loginUser ? 0 : sessionScope.loginUser.mileageBalance}');
      var currentPackage = null;

      function getMoveSize() {
        var firstCard = rail.querySelector('.detail-package-card');
        if (!firstCard) return rail.clientWidth;
        return (firstCard.getBoundingClientRect().width + 14) * pageSize;
      }

      function getCardStepSize() {
        var firstCard = rail.querySelector('.detail-package-card');
        if (!firstCard) return rail.clientWidth;
        return firstCard.getBoundingClientRect().width + 14;
      }

      function getPageCount() {
        var cardCount = rail.querySelectorAll('.detail-package-card').length;
        return Math.max(1, Math.ceil(cardCount / pageSize));
      }

      function getCurrentPage() {
        var pageWidth = getCardStepSize() * pageSize;
        if (pageWidth <= 0) return 1;
        return Math.min(getPageCount(), Math.floor((rail.scrollLeft + pageWidth / 2) / pageWidth) + 1);
      }

      function updateButtons() {
        var maxScrollLeft = rail.scrollWidth - rail.clientWidth - 2;
        prevBtn.disabled = rail.scrollLeft <= 2;
        nextBtn.disabled = rail.scrollLeft >= maxScrollLeft;
        pageText.textContent = getCurrentPage() + ' / ' + getPageCount();
      }

      prevBtn.addEventListener('click', function () {
        rail.scrollBy({ left: -getMoveSize(), behavior: 'smooth' });
      });
      nextBtn.addEventListener('click', function () {
        rail.scrollBy({ left: getMoveSize(), behavior: 'smooth' });
      });
      rail.addEventListener('scroll', updateButtons);
      window.addEventListener('resize', updateButtons);
      updateButtons();

      function setText(id, value) {
        var element = document.getElementById(id);
        if (element) element.textContent = value || '-';
      }

      function formatAmount(value) {
        return Number(value || 0).toLocaleString();
      }

      function floorToThousand(value) {
        return Math.floor(Number(value || 0) / 1000) * 1000;
      }

      function setBookingMessage(message, type) {
        var messageEl = document.getElementById('packageBookingMessage');
        if (!messageEl) return;
        messageEl.textContent = message || '';
        messageEl.classList.toggle('is-error', type === 'error');
        messageEl.classList.toggle('is-success', type === 'success');
      }

      function updatePackageBookingPreview() {
        if (!currentPackage) return;
        var peopleInput = document.getElementById('packagePeopleCount');
        var mileageInput = document.getElementById('packageMileageAmount');
        var bookingBtn = document.getElementById('packageBookingBtn');
        if (!peopleInput || !mileageInput || !bookingBtn) return;

        var unitPrice = Number(currentPackage.unitPrice || 0);
        var minPeople = Number(currentPackage.minPeople || 1);
        var maxPeople = Number(currentPackage.maxPeople || 0);
        var peopleCount = Number(peopleInput.value || minPeople);
        if (peopleCount < minPeople) peopleCount = minPeople;
        if (maxPeople > 0 && peopleCount > maxPeople) peopleCount = maxPeople;
        peopleInput.value = peopleCount;

        var totalPrice = unitPrice * peopleCount;
        var maxMileageUse = floorToThousand(totalPrice * 30 / 100);
        var mileageAmount = Number(mileageInput.value || 0);
        if (mileageAmount < 0) mileageAmount = 0;
        if (mileageAmount > maxMileageUse) mileageAmount = maxMileageUse;
        if (mileageAmount > userMileageBalance) mileageAmount = floorToThousand(userMileageBalance);
        mileageInput.value = mileageAmount;

        var cashAmount = totalPrice - mileageAmount;
        setText('packageBookingTotal', formatAmount(totalPrice) + ' C');
        setText('packageBookingMaxMileage', formatAmount(maxMileageUse) + ' M');
        setText('packageBookingCash', formatAmount(cashAmount) + ' C');
        setText('packageBookingBalance', formatAmount(userCashBalance) + ' C / ' + formatAmount(userMileageBalance) + ' M');

        if (!isLoggedIn) {
          bookingBtn.textContent = detailMessages.packageLoginAction;
          bookingBtn.disabled = false;
          setBookingMessage(detailMessages.packageLoginRequired, '');
          return;
        }
        bookingBtn.textContent = detailMessages.packageBookingAction;
        if (userCashBalance < cashAmount) {
          bookingBtn.disabled = true;
          setBookingMessage(detailMessages.packageInsufficientCash, 'error');
          return;
        }
        bookingBtn.disabled = false;
        setBookingMessage('', '');
      }

      function openPackageModal(card) {
        if (!modal || !modalHero) return;
        var data = card.dataset;
        var imagePath = data.image || '';
        currentPackage = {
          packageIdx: data.packageIdx,
          unitPrice: Number(data.unitPrice || 0),
          minPeople: Number(data.minPeople || 1),
          maxPeople: Number(data.maxPeople || 0)
        };

        modalHero.querySelectorAll('img').forEach(function (img) {
          img.remove();
        });
        if (imagePath) {
          var image = document.createElement('img');
          image.src = imagePath;
          image.alt = data.title || '${autoMsg_7d5a4da44c}';
          modalHero.prepend(image);
        }

        setText('packageModalKicker', (data.region || '') + ' · ' + (data.spot || ''));
        setText('packageModalTitle', data.title);
        setText('packageModalSummary', data.content || data.summary);
        setText('packageModalPrice', data.price);
        setText('packageModalPeriod', data.period);
        setText('packageModalPeople', data.people);
        setText('packageModalSeller', data.seller);

        var peopleInput = document.getElementById('packagePeopleCount');
        var mileageInput = document.getElementById('packageMileageAmount');
        if (peopleInput) {
          peopleInput.min = currentPackage.minPeople || 1;
          if (currentPackage.maxPeople > 0) {
            peopleInput.max = currentPackage.maxPeople;
          } else {
            peopleInput.removeAttribute('max');
          }
          peopleInput.value = currentPackage.minPeople || 1;
        }
        if (mileageInput) {
          mileageInput.value = 0;
        }
        updatePackageBookingPreview();

        modal.classList.add('show');
        modal.setAttribute('aria-hidden', 'false');
        document.body.style.overflow = 'hidden';
      }

      function closePackageModal() {
        if (!modal) return;
        modal.classList.remove('show');
        modal.setAttribute('aria-hidden', 'true');
        document.body.style.overflow = '';
      }

      rail.querySelectorAll('.detail-package-card').forEach(function (card) {
        card.addEventListener('click', function () {
          openPackageModal(card);
        });
        card.addEventListener('keydown', function (event) {
          if (event.key === 'Enter' || event.key === ' ') {
            event.preventDefault();
            openPackageModal(card);
          }
        });
      });

      // 광고에서 ?openPackage={pkgId}로 진입 시 해당 패키지 모달 자동 오픈
      try {
        var pkgIdParam = new URLSearchParams(window.location.search).get('openPackage');
        if (pkgIdParam) {
          var targetCard = rail.querySelector('.detail-package-card[data-package-idx="' + pkgIdParam + '"]');
          if (targetCard) {
            targetCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
            setTimeout(function () { openPackageModal(targetCard); }, 250);
          }
        }
      } catch (e) { /* URL 파싱 실패는 조용히 무시 */ }

      if (modalCloseBtn) {
        modalCloseBtn.addEventListener('click', closePackageModal);
      }
      var peopleInput = document.getElementById('packagePeopleCount');
      var mileageInput = document.getElementById('packageMileageAmount');
      var bookingBtn = document.getElementById('packageBookingBtn');
      if (peopleInput) peopleInput.addEventListener('input', updatePackageBookingPreview);
      if (mileageInput) mileageInput.addEventListener('input', updatePackageBookingPreview);
      if (bookingBtn) {
        bookingBtn.addEventListener('click', function () {
          if (!currentPackage) return;
          if (!isLoggedIn) {
            window.location.href = contextPath + '/auth/login?redirect=' + encodeURIComponent(window.location.pathname + window.location.search);
            return;
          }
          bookingBtn.disabled = true;
          setBookingMessage(detailMessages.packageProcessing, '');
          fetch(contextPath + '/packages/' + currentPackage.packageIdx + '/book', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({
              peopleCount: Number(peopleInput.value || 1),
              mileageAmount: Number(mileageInput.value || 0)
            })
          })
          .then(function (res) { return res.json(); })
          .then(function (data) {
            if (!data.success) {
              if (data.loginRequired) {
                window.location.href = contextPath + '/auth/login?redirect=' + encodeURIComponent(window.location.pathname + window.location.search);
                return;
              }
              bookingBtn.disabled = false;
              setBookingMessage(data.message || detailMessages.packageError, 'error');
              return;
            }
            userCashBalance = Number(data.cashBalance || 0);
            userMileageBalance = Number(data.mileageBalance || 0);
            setBookingMessage(formatMessage(detailMessages.packageSuccessTemplate, data.bookingNo), 'success');
            updatePackageBookingPreview();
          })
          .catch(function () {
            bookingBtn.disabled = false;
            setBookingMessage(detailMessages.packageError, 'error');
          });
        });
      }
      if (modal) {
        modal.addEventListener('click', function (event) {
          if (event.target === modal) closePackageModal();
        });
      }
      document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape' && modal && modal.classList.contains('show')) {
          closePackageModal();
        }
      });
    })();
    </script>
  </c:if>

  <!-- 위치 -->
  <c:if test="${not empty spot.latitude and not empty spot.longitude and spot.latitude != 0 and spot.longitude != 0}">
    <div class="det-section">
      <h2>&#128506; ${autoMsg_77f86a125f}</h2>

      <!-- 지도 컨테이너 -->
      <div class="flight-map-wrap">
        <div id="googleMap" style="
            width:100%; height:420px;
            border-radius:10px; overflow:hidden;
            border:1px solid var(--gray-200);
            background:var(--gray-100);">
        </div>

        <c:if test="${flightAvailable and not empty lowestFlightOffer}">
          <button type="button"
                  class="flight-price-chip"
                  id="openFlightModalBtn"
                  data-spot-idx="${spot.spotIdx}">
            <span class="flight-chip-icon">✈</span>
            <span>
              <span class="flight-chip-label">${detailFlightCheapestLabel}</span>
              <span class="flight-chip-price">
                  <fmt:formatNumber value="${lowestFlightOffer.finalPrice}" pattern="#,##0"/> C
              </span>
            </span>
          </button>
        </c:if>
      </div>

    </div>
  </c:if>

  <c:if test="${flightAvailable and not empty lowestFlightOffer}">
    <div class="flight-modal" id="flightModal" aria-hidden="true">
      <div class="flight-modal-card" role="dialog" aria-modal="true" aria-labelledby="flightModalTitle">
        <div class="flight-modal-head">
          <div>
            <h3 class="flight-modal-title" id="flightModalTitle">${detailFlightTitleLabel}</h3>
            <div class="flight-modal-sub">
              ${detailFlightSubtitleLabel}
            </div>
          </div>
          <button type="button" class="flight-modal-close" id="closeFlightModalBtn" aria-label="${detailCloseLabel}">×</button>
        </div>
        <div class="flight-modal-body">
          <div class="flight-date-grid">
            <div class="flight-date-field">
              <label for="flightDepartureDate">${detailFlightDepartureDateLabel}</label>
              <input type="date" id="flightDepartureDate">
            </div>
            <div class="flight-date-field">
              <label for="flightReturnDate">${detailFlightReturnDateLabel}</label>
              <input type="date" id="flightReturnDate">
            </div>
          </div>

          <div class="flight-offer-list" id="flightOfferList">
            <div class="flight-pay-msg">${detailFlightLoadingLabel}</div>
          </div>

          <div class="flight-pay-box">
            <div class="flight-pay-row">
              <span>${detailFlightOriginalPriceLabel}</span>
              <strong id="flightOriginalPrice">-</strong>
            </div>
            <div class="flight-pay-row">
              <span>${detailFlightGradeDiscountLabel}</span>
              <strong id="flightGradeDiscount">-</strong>
            </div>
            <div class="flight-pay-row">
              <span>${detailFlightTotalPriceLabel}</span>
              <strong id="flightTotalPrice">-</strong>
            </div>
            <div class="flight-pay-row">
              <span>${detailFlightCashBalanceLabel}</span>
              <strong id="flightCashBalance">
                <fmt:formatNumber value="${loginUser.cashBalance}" pattern="#,##0"/> C
              </strong>
            </div>
            <div class="flight-pay-row">
              <span>${detailFlightMileageBalanceLabel}</span>
              <strong id="flightMileageBalance">
                <fmt:formatNumber value="${loginUser.mileageBalance}" pattern="#,##0"/> M
              </strong>
            </div>
            <div class="flight-pay-row">
              <span>${detailFlightUseMileageLabel} <small id="flightMileageLimitText"></small></span>
              <input type="number" id="flightMileageInput" class="flight-pay-input" min="0" step="1000" value="0">
            </div>
            <div class="flight-pay-row">
              <span>${detailFlightUseCashLabel}</span>
              <input type="number" id="flightCashInput" class="flight-pay-input" min="0" step="1000" value="0" readonly>
            </div>
            <div class="flight-pay-actions">
              <button type="button" class="flight-pay-btn secondary" id="flightUseMaxMileageBtn">${detailFlightUseMaxMileageLabel}</button>
              <button type="button" class="flight-pay-btn primary" id="flightPurchaseBtn">${detailFlightPurchaseLabel}</button>
            </div>
            <div class="flight-pay-msg" id="flightPayMessage"></div>
          </div>
        </div>
      </div>
    </div>
  </c:if>

  <!-- 리뷰 섹션 -->
  <div class="det-section">
    <h2>&#128172; ${autoMsg_3b90a30247}</h2>

    <!-- 리뷰 요약 -->
    <div class="review-summary-wrap">
      <div>
        <div class="review-big-score">
          <c:choose>
            <c:when test="${spot.reviewCount > 0}">
              <fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/>
            </c:when>
            <c:otherwise>-</c:otherwise>
          </c:choose>
        </div>
        <div class="review-stars-big">
          <c:choose>
            <c:when test="${spot.ratingAvg >= 4.5}">⭐⭐⭐⭐⭐</c:when>
            <c:when test="${spot.ratingAvg >= 3.5}">⭐⭐⭐⭐☆</c:when>
            <c:when test="${spot.ratingAvg >= 2.5}">⭐⭐⭐☆☆</c:when>
            <c:when test="${spot.ratingAvg >= 1.5}">⭐⭐☆☆☆</c:when>
            <c:when test="${spot.reviewCount > 0}">⭐☆☆☆☆</c:when>
            <c:otherwise>☆☆☆☆☆</c:otherwise>
          </c:choose>
        </div>
        <div class="review-sub">${autoMsg_2ecc46d7bc}</div>
      </div>
    </div>

    <!-- 리뷰 작성 영역 -->
    <div id="reviewWriteArea">
    <c:choose>
      <%-- 로그인했고 아직 리뷰를 작성하지 않은 경우 작성 폼 표시 --%>
      <c:when test="${canWrite}">
        <div class="review-form-box" id="reviewFormBox">
          <h3>&#9997; ${autoMsg_7486c5c523}</h3>
          <div class="star-picker" id="starPicker">
            <span class="sp" data-v="1">&#9733;</span>
            <span class="sp" data-v="2">&#9733;</span>
            <span class="sp" data-v="3">&#9733;</span>
            <span class="sp" data-v="4">&#9733;</span>
            <span class="sp" data-v="5">&#9733;</span>
          </div>
          <textarea class="review-textarea" id="reviewContent"
                    maxlength="500" placeholder="${autoMsg_ee3088460b}"></textarea>
          <div class="review-form-foot">
            <span class="review-char"><span id="charCount">0</span> / 500</span>
            <button class="review-submit-btn" id="reviewSubmitBtn" disabled>${autoMsg_a2cd1a61bf}</button>
          </div>
        </div>
      </c:when>
      <%-- 로그인했고 이미 리뷰를 작성한 경우 안내 문구 --%>
      <c:when test="${isLoggedIn and not canWrite}">
        <div id="alreadyReviewBox"
             style="background:var(--gray-50);border-radius:10px;padding:16px 20px;margin-bottom:28px;
                    font-size:14px;color:var(--gray-500);border:1px solid var(--gray-200);">
          &#10003; ${autoMsg_c795565e05}
        </div>
      </c:when>
      <%-- 비로그인 시 로그인 유도 --%>
      <c:otherwise>
        <div class="review-login-box">
          <p>&#128172; ${autoMsg_d0ab6c7989}</p>
          <a href="${pageContext.request.contextPath}/auth/login" class="review-login-link">${autoMsg_63e8959397}</a>
        </div>
      </c:otherwise>
    </c:choose>
    </div><%-- /reviewWriteArea --%>

    <!-- 리뷰 목록 -->
    <c:if test="${isAdminMode and not empty reviewList}">
      <div class="review-admin-tools">
        <div class="review-admin-left">
          <label class="review-admin-select-all">
            <input type="checkbox" id="reviewSelectAll">
            <span>${autoMsg_f0ebac93ca}</span>
          </label>
          <span class="review-sub">${autoMsg_8daba712e1}</span>
        </div>
        <button type="button" class="review-admin-bulk-btn" id="blockSelectedReviewsBtn" disabled>
          <spring:message code="detail.review.admin.blockSelected"/>
        </button>
      </div>
    </c:if>

    <div class="review-list" id="reviewList">
      <c:choose>
        <c:when test="${not empty reviewList}">
          <c:forEach var="rv" items="${reviewList}">
            <div class="review-card ${rv.bubbleClass}" id="rv-${rv.reviewIdx}">
              <div class="review-card-top">
                <div class="review-author-info">
                  <c:if test="${isAdminMode}">
                    <input type="checkbox"
                           class="review-admin-check"
                           data-review-select="${rv.reviewIdx}">
                  </c:if>
                  <div class="review-avatar">
                    ${fn:substring(rv.nickname, 0, 1)}
                  </div>
                  <div>
                    <div class="review-nickname">
                      <span class="tt-nickname ${rv.nicknameColorClass} ${rv.nicknameEffectClass}">${fn:escapeXml(rv.nickname)}</span>
                      <c:if test="${not empty rv.profileBadgeLabel}">
                        <span class="tt-profile-badge ${rv.profileBadgeClass}">${rv.profileBadgeLabel}</span>
                      </c:if>
                      <c:if test="${not empty sessionScope.loginUser and rv.userIdx ne loginUserIdx and not isAdminMode}">
                        <span class="review-user-report-link rpt-user-link"
                              data-user-idx="${rv.userIdx}"
                              data-source-type="review"
                              data-source-id="${rv.reviewIdx}">${autoMsg_ca78d9f589}</span>
                      </c:if>
                    </div>
                    <div class="review-date">
                      <fmt:formatDate value="${rv.createdAtDate}" pattern="yyyy.MM.dd" type="date"/>
                    </div>
                  </div>
                </div>
                <div class="review-action-row">
                  <span class="review-stars-small">
                    <c:forEach begin="1" end="5" var="i">
                      <c:choose>
                        <c:when test="${i <= rv.rating}">⭐</c:when>
                        <c:otherwise>☆</c:otherwise>
                      </c:choose>
                    </c:forEach>
                    (${rv.rating}/5)
                  </span>
                  <c:if test="${not isAdminMode}">
                    <button type="button"
                            class="review-like-btn ${rv.likedByLoginUser ? 'active' : ''}"
                            data-review-like-idx="${rv.reviewIdx}"
                            data-spot-idx="${spot.spotIdx}">
                      <span class="review-like-icon">${rv.likedByLoginUser ? '❤️' : '🤍'}</span>
                      <span class="review-like-count">${rv.likeCount != null ? rv.likeCount : 0}</span>
                    </button>
                  </c:if>
                  <c:if test="${not empty sessionScope.loginUser and rv.userIdx ne loginUserIdx and not isAdminMode}">
                    <button type="button"
                            class="review-report-btn"
                            data-review-report-idx="${rv.reviewIdx}">${autoMsg_94fa83bd66}</button>
                  </c:if>
                  <c:if test="${rv.userIdx == loginUserIdx}">
                    <button class="review-delete-btn"
                            data-review-idx="${rv.reviewIdx}"
                            data-spot-idx="${spot.spotIdx}">${autoMsg_b1124bd3b4}</button>
                  </c:if>
                  <c:if test="${isAdminMode}">
                    <button class="det-admin-review-btn"
                            type="button"
                            data-block-review-idx="${rv.reviewIdx}"
                            data-block-spot-idx="${spot.spotIdx}">${autoMsg_a985a82f30}</button>
                  </c:if>
                </div>
              </div>
              <p class="review-content">${fn:escapeXml(rv.content)}</p>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="review-empty" id="reviewEmpty">
            <spring:message code="detail.review.empty"/>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </div><!-- /리뷰 섹션 -->

  <!-- AI 맞춤 여행지 추천 섹션 <로그인 사용자만> -->
  <c:if test="${isLoggedIn}">
  <div class="det-section" id="aiRecommendSection">
    <h2 id="aiRecTitle">${autoMsg_6cceb0a144}</h2>
    <p id="aiRecDesc" style="font-size:13px;color:var(--gray-500);margin-bottom:20px;">
      <spring:message code="detail.ai.desc"/>
    </p>
    <div class="ai-rec-content">
      <div id="recLoadingMsg" class="ai-rec-state">
        <span style="font-size:24px;display:block;margin-bottom:8px;">&#x1F916;</span>
        <spring:message code="detail.ai.loading"/>
      </div>
      <div class="spot-grid" id="recGrid" style="display:none;"></div>
      <div id="recEmptyMsg" class="ai-rec-state" style="display:none;">
        <spring:message code="detail.ai.empty"/>
      </div>
    </div>
  </div>
  </c:if>

  <!-- 탐색 버튼 -->
  <div style="text-align:center;margin-top:32px;">
    <button class="det-action-btn"
            onclick="location.href='${pageContext.request.contextPath}/explore'"
            style="margin:0 auto;">
      &#128269; ${autoMsg_c5e15f91f8}
    </button>
  </div>

</div>

<!-- 토스트 -->
<div class="toast" id="toast"></div>
<div id="adminEditSuccessMsg" data-message="${fn:escapeXml(adminEditSuccess)}" style="display:none;"></div>

<div id="rpt-modal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:9999;align-items:center;justify-content:center;">
  <div style="background:#fff;border-radius:16px;padding:28px 32px;min-width:320px;max-width:460px;width:90%;box-shadow:0 8px 32px rgba(0,0,0,.18);">
    <div style="font-size:16px;font-weight:700;color:var(--gray-800);margin-bottom:20px;">${autoMsg_09687754cb}</div>
    <input type="hidden" id="rptTargetType" value="">
    <input type="hidden" id="rptTargetId" value="">
    <div style="margin-bottom:16px;">
      <label style="display:block;font-size:13px;font-weight:600;color:var(--gray-700);margin-bottom:6px;">${autoMsg_22acf32472} <span style="color:#ef4444;">*</span></label>
      <select id="rptReason" style="width:100%;padding:10px 12px;border:1px solid var(--gray-200);border-radius:8px;font-family:inherit;font-size:14px;color:var(--gray-800);outline:none;">
        <option value="">${autoMsg_ec939a1fb7}</option>
        <option value="spam">${autoMsg_892b5724bb}</option>
        <option value="abuse">${autoMsg_bce59fbfd9}</option>
        <option value="privacy">${autoMsg_c095d8c7ce}</option>
        <option value="illegal">${autoMsg_d97082c998}</option>
        <option value="etc">${autoMsg_24ca2dc020}</option>
      </select>
      <div id="rptReasonMsg" style="font-size:12px;color:#ef4444;margin-top:6px;"></div>
    </div>
    <div style="margin-bottom:20px;">
      <label style="display:block;font-size:13px;font-weight:600;color:var(--gray-700);margin-bottom:6px;">${autoMsg_77a41fec80}</label>
      <textarea id="rptDescription" rows="5" style="width:100%;padding:10px 12px;border:1px solid var(--gray-200);border-radius:8px;font-family:inherit;font-size:14px;color:var(--gray-800);outline:none;resize:vertical;" placeholder="${autoMsg_9b0abd03a8}"></textarea>
    </div>
    <div style="display:flex;justify-content:flex-end;gap:10px;">
      <button type="button" id="rptCancelBtn" class="det-action-btn">${autoMsg_ad8ea8e20e}</button>
      <button type="button" id="rptSubmitBtn" class="det-action-btn active">${autoMsg_f59b85e3ad}</button>
    </div>
  </div>
</div>

<div id="rpt-user-modal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:9999;align-items:center;justify-content:center;">
  <div style="background:#fff;border-radius:16px;padding:28px 32px;min-width:320px;max-width:460px;width:90%;box-shadow:0 8px 32px rgba(0,0,0,.18);">
    <div style="font-size:16px;font-weight:700;color:var(--gray-800);margin-bottom:8px;">${autoMsg_84a57dc4cd}</div>
    <div style="font-size:13px;color:var(--gray-500);margin-bottom:20px;">${autoMsg_465c990282}</div>
    <input type="hidden" id="rptUserTargetIdx" value="">
    <input type="hidden" id="rptUserSourceType" value="">
    <input type="hidden" id="rptUserSourceId" value="">
    <div style="margin-bottom:20px;">
      <textarea id="rptUserDescription" rows="6" style="width:100%;padding:10px 12px;border:1px solid var(--gray-200);border-radius:8px;font-family:inherit;font-size:14px;color:var(--gray-800);outline:none;resize:vertical;" placeholder="${autoMsg_f44c70ae24}"></textarea>
      <div id="rptUserDescMsg" style="font-size:12px;color:#ef4444;margin-top:6px;"></div>
    </div>
    <div style="display:flex;justify-content:flex-end;gap:10px;">
      <button type="button" id="rptUserCancelBtn" class="det-action-btn">${autoMsg_ad8ea8e20e}</button>
      <button type="button" id="rptUserSubmitBtn" class="det-action-btn active">${autoMsg_f59b85e3ad}</button>
    </div>
  </div>
</div>

<%@ include file="../common/footer.jsp" %>

<script>
(function () {
  'use strict';

  const ctx      = '${pageContext.request.contextPath}';
  const spotIdx  = '${spot.spotIdx}';
  const loginUserIdx = '${loginUserIdx}';
  const detailMessages = window.detailMessages = {
    genericError: '${autoMsg_0533c80ab2}',
    loginRequired: '${autoMsg_5b3b4d0f7a}',
    tagLimit: '${autoMsg_d49baedede}',
    favAdded: '${autoMsg_11c3b20f7d}',
    favRemoved: '${autoMsg_b1fd0ed5a0}',
    likeAdded: '${autoMsg_5214d1ab65}',
    likeRemoved: '${autoMsg_788bdb83fc}',
    reviewSubmitLoading: '${autoMsg_7f8633fbc9}',
    reviewSubmitFail: '${autoMsg_1ab2849ef2}',
    reviewSubmitSuccess: '${autoMsg_f5789cadc1}',
    reviewDeleteConfirm: '${autoMsg_ead131b839}',
    reviewDeleteFail: '${autoMsg_0643fc5936}',
    reviewDeleteSuccess: '${autoMsg_22f8071df6}',
    reviewEmptyVisible: '${autoMsg_0c60c7802a}',
    reviewBlockConfirm: '${autoMsg_7a7196f900}',
    reviewBlockFail: '${autoMsg_b64f9ce751}',
    reviewBlockSuccess: '${autoMsg_1266d379f9}',
    reviewBlockNone: '${autoMsg_a6dd1feffa}',
    reviewBlockBulkConfirmAll: '${autoMsg_d558dd7f7d}',
    reviewBlockBulkConfirmSelected: '${autoMsg_0b4625057f}',
    reviewBlockBulkSuccessTemplate: '${autoMsg_5fa2784d11}',
    reviewBlockSelectedLabel: '${autoMsg_3b8a3f2b5d}',
    reviewLikeSuccess: '${autoMsg_5bd7c4703c}',
    reviewWriteTitle: '${autoMsg_486a5fd302}',
    reviewSubmitLabel: '${autoMsg_104523f557}',
    reviewEmptyHtml: '${autoMsg_48a1167ef8}',
    packageLoginAction: '${autoMsg_0005bf699e}',
    packageBookingAction: '${autoMsg_37e76eae10}',
    packageLoginRequired: '${autoMsg_bc8c678d03}',
    packageInsufficientCash: '${autoMsg_0b814dda73}',
    packageProcessing: '${autoMsg_8eeec2a018}',
    packageError: '${autoMsg_672a4ede58}',
    packageSuccessTemplate: '${autoMsg_10e9dc3c7d}',
    flightDateRequired: '${autoMsg_71e904bade}',
    flightReturnInvalid: '${autoMsg_cd44f0d7cf}',
    flightNoDiscount: '${autoMsg_91a3993f6d}',
    flightLoading: '${autoMsg_2040f14ea0}',
    flightEmpty: '${autoMsg_571aeb4cc3}',
    flightLoadFail: '${autoMsg_663d9e9bea}',
    flightOutboundLabel: '${autoMsg_4c6166fa9b}',
    flightReturnLabel: '${autoMsg_2732585e57}',
    flightDepartLabel: '${autoMsg_df1bd59f60}',
    flightArriveLabel: '${autoMsg_43a23027a2}',
    flightMileageLimitTemplate: '${autoMsg_c9215db6ab}',
    flightLoginRequired: '${autoMsg_ca5547106e}',
    flightSelectOffer: '${autoMsg_4bed199b34}',
    flightPurchaseFail: '${autoMsg_b84d9ec61f}',
    flightPurchaseError: '${autoMsg_ce05461c95}',
    flightPurchaseSuccessTemplate: '${autoMsg_b48c522b0e}',
    locationNoCoordinates: '${autoMsg_92d7f2a24d}',
    aiLoadFail: '${autoMsg_cbc4a42159}',
    reportReasonRequired: '${autoMsg_11daf76bca}',
    reportSubmitted: '${autoMsg_920f39533f}',
    requestFail: '${autoMsg_4fb166adbe}',
    userReportMinLength: '${autoMsg_c3447494a0}'
  };
  function formatMessage(template) {
    var args = Array.prototype.slice.call(arguments, 1);
    return String(template || '').replace(/\{(\d+)\}/g, function (_, index) {
      return typeof args[index] !== 'undefined' ? args[index] : '';
    });
  }
  const adminEditModal = document.getElementById('adminEditModal');
  if (adminEditModal && adminEditModal.classList.contains('show')) {
    document.body.classList.add('modal-open');
  }

  /* 토스트 */
  function showToast(msg) {
    const t = document.getElementById('toast');
    t.textContent = msg;
    t.classList.add('show');
    setTimeout(() => t.classList.remove('show'), 2500);
  }

  const successMsg = document.getElementById('adminEditSuccessMsg');
  if (successMsg && successMsg.dataset.message) {
    showToast(successMsg.dataset.message);
  }

  /* 관리자 여행지 수정 모달 */
  function openAdminModal() {
    if (!adminEditModal) return;
    adminEditModal.classList.add('show');
    document.body.classList.add('modal-open');
  }

  function closeAdminModal() {
    if (!adminEditModal) return;
    adminEditModal.classList.remove('show');
    document.body.classList.remove('modal-open');
  }

  const openAdminEditBtn = document.getElementById('openAdminEditBtn');
  const closeAdminEditBtn = document.getElementById('closeAdminEditBtn');
  const cancelAdminEditBtn = document.getElementById('cancelAdminEditBtn');

  openAdminEditBtn && openAdminEditBtn.addEventListener('click', openAdminModal);
  closeAdminEditBtn && closeAdminEditBtn.addEventListener('click', closeAdminModal);
  cancelAdminEditBtn && cancelAdminEditBtn.addEventListener('click', closeAdminModal);

  adminEditModal && adminEditModal.addEventListener('click', function (e) {
    if (e.target === adminEditModal) {
      closeAdminModal();
    }
  });

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && adminEditModal && adminEditModal.classList.contains('show')) {
      closeAdminModal();
    }
  });

  const adminTagCheckboxes = document.querySelectorAll('#adminEditForm input[name="tags"]');
  adminTagCheckboxes.forEach(function (checkbox) {
    checkbox.addEventListener('change', function () {
      const checked = document.querySelectorAll('#adminEditForm input[name="tags"]:checked');
      if (checked.length > 4) {
        this.checked = false;
        showToast(detailMessages.tagLimit);
      }
    });
  });

  /* 찜 / 좋아요 토글 */
  function toggleAction(endpoint, btn, onText, offText, onMsg, offMsg, key) {
    fetch(ctx + endpoint, { method: 'POST' })
      .then(r => r.json())
      .then(data => {
        if (!data.success) {
          showToast(detailMessages.loginRequired);
          setTimeout(() => { window.location.href = ctx + '/auth/login'; }, 1500);
          return;
        }
        const active = data[key];
        btn.classList.toggle('active', active);
        btn.querySelector('.det-action-label').textContent = active ? onText : offText;
        btn.querySelector('.det-action-icon').textContent =
            active ? (key === 'favorited' ? '⭐' : '❤️') : (key === 'favorited' ? '☆' : '🤍');
        showToast(active ? onMsg : offMsg);
      })
      .catch(() => showToast(detailMessages.genericError));
  }

  const favBtn  = document.querySelector('.fav-btn');
  const likeBtn = document.querySelector('.like-btn');

  favBtn && favBtn.addEventListener('click', function () {
    toggleAction('/explore/favorite/' + spotIdx, this,
                 '${autoMsg_385faf859f}',
                 '${autoMsg_3335ae8313}',
                 detailMessages.favAdded, detailMessages.favRemoved, 'favorited');
  });

  likeBtn && likeBtn.addEventListener('click', function () {
    toggleAction('/explore/like/' + spotIdx, this,
                 '${autoMsg_9a1bf4bea9}',
                 '${autoMsg_9e04b6024d}',
                 detailMessages.likeAdded, detailMessages.likeRemoved, 'liked');
  });

  /* 별점 선택기 */
  let selectedRating = 0;

  function bindStarPicker() {
    const stars = document.querySelectorAll('#starPicker .sp');
    function renderStars(n) {
      stars.forEach(s => s.classList.toggle('on', parseInt(s.dataset.v) <= n));
    }
    stars.forEach(s => {
      s.addEventListener('mouseover', function () { renderStars(parseInt(this.dataset.v)); });
      s.addEventListener('mouseout',  function () { renderStars(selectedRating); });
      s.addEventListener('click',     function () {
        selectedRating = parseInt(this.dataset.v);
        renderStars(selectedRating);
        checkSubmit();
      });
    });
  }

  function checkSubmit() {
    const btn  = document.getElementById('reviewSubmitBtn');
    const area = document.getElementById('reviewContent');
    if (!btn || !area) return;
    btn.disabled = !(selectedRating > 0 && area.value.trim().length > 0);
  }

  /* 리뷰 등록 */
  function bindSubmitBtn() {
    const textarea  = document.getElementById('reviewContent');
    const submitBtn = document.getElementById('reviewSubmitBtn');
    const charCount = document.getElementById('charCount');

    textarea && textarea.addEventListener('input', function () {
      if (charCount) charCount.textContent = this.value.length;
      checkSubmit();
    });

    submitBtn && submitBtn.addEventListener('click', function () {
      const content = textarea ? textarea.value.trim() : '';
      if (selectedRating === 0 || !content) return;

      submitBtn.disabled = true;
      submitBtn.textContent = detailMessages.reviewSubmitLoading;

      fetch(ctx + '/detail/' + spotIdx + '/review', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ rating: selectedRating, content: content })
      })
      .then(r => r.json())
      .then(data => {
        if (!data.success) {
          showToast(data.message || detailMessages.reviewSubmitFail);
          submitBtn.disabled = false;
          submitBtn.textContent = detailMessages.reviewSubmitLabel;
          return;
        }
        showToast(detailMessages.reviewSubmitSuccess);
        setTimeout(() => location.reload(), 800);
      })
      .catch(() => {
        showToast(detailMessages.genericError);
        submitBtn.disabled = false;
        submitBtn.textContent = detailMessages.reviewSubmitLabel;
      });
    });
  }

  // 페이지 최초 로드 시 폼이 있으면 바인딩
  if (document.getElementById('starPicker'))   bindStarPicker();
  if (document.getElementById('reviewSubmitBtn')) bindSubmitBtn();

  /* 리뷰 삭제 */
  function bindDeleteBtns() {
    document.querySelectorAll('.review-delete-btn').forEach(btn => {
      btn.addEventListener('click', function () {
        if (!confirm(detailMessages.reviewDeleteConfirm)) return;
        const rIdx = this.dataset.reviewIdx;
        const sIdx = this.dataset.spotIdx;

        fetch(ctx + '/detail/' + sIdx + '/review/' + rIdx, { method: 'DELETE' })
          .then(r => r.json())
          .then(data => {
            if (!data.success) { showToast(data.message || detailMessages.reviewDeleteFail); return; }

            // 1. 카드 제거
            const card = document.getElementById('rv-' + rIdx);
            card && card.remove();
            showToast(detailMessages.reviewDeleteSuccess);

            // 2. 리뷰 목록이 비었으면 빈 상태 메시지 표시
            const list = document.getElementById('reviewList');
            if (list && list.querySelectorAll('.review-card').length === 0) {
              list.innerHTML = '<div class="review-empty">' + detailMessages.reviewEmptyHtml + '</div>';
            }

            // 3. "이미 작성" 안내 박스를 지우고 작성 폼 복원
            const alreadyBox = document.getElementById('alreadyReviewBox');
            if (alreadyBox) alreadyBox.remove();
            showWriteForm();
          })
          .catch(() => showToast(detailMessages.genericError));
      });
    });
  }

  /* 관리자 리뷰 차단 */
  function bindBlockBtns() {
    document.querySelectorAll('[data-block-review-idx]').forEach(btn => {
      btn.addEventListener('click', function () {
        if (!confirm(detailMessages.reviewBlockConfirm)) return;

        const reviewIdx = this.dataset.blockReviewIdx;
        const currentSpotIdx = this.dataset.blockSpotIdx;

        fetch(ctx + '/detail/' + currentSpotIdx + '/review/' + reviewIdx + '/block', {
          method: 'POST'
        })
          .then(r => r.json())
          .then(data => {
            if (!data.success) {
              showToast(data.message || detailMessages.reviewBlockFail);
              return;
            }

            const card = document.getElementById('rv-' + reviewIdx);
            card && card.remove();
            showToast(detailMessages.reviewBlockSuccess);

            const list = document.getElementById('reviewList');
            if (list && list.querySelectorAll('.review-card').length === 0) {
              list.innerHTML = '<div class="review-empty">' + detailMessages.reviewEmptyVisible + '</div>';
            }
          })
          .catch(() => showToast(detailMessages.genericError));
      });
    });
  }

  /* 관리자 리뷰 선택 / 전체선택 / 선택 차단 */
  const reviewSelectAll = document.getElementById('reviewSelectAll');
  const blockSelectedReviewsBtn = document.getElementById('blockSelectedReviewsBtn');

  function getSelectedReviewCheckboxes() {
    return Array.from(document.querySelectorAll('[data-review-select]:checked'));
  }

  function syncReviewSelectionUi() {
    const allCheckboxes = Array.from(document.querySelectorAll('[data-review-select]'));
    const checkedCheckboxes = getSelectedReviewCheckboxes();

    allCheckboxes.forEach(function (checkbox) {
      const card = checkbox.closest('.review-card');
      if (card) {
        card.classList.toggle('admin-selecting', checkbox.checked);
      }
    });

    if (reviewSelectAll) {
      reviewSelectAll.checked = allCheckboxes.length > 0 && checkedCheckboxes.length === allCheckboxes.length;
      reviewSelectAll.indeterminate = checkedCheckboxes.length > 0 && checkedCheckboxes.length < allCheckboxes.length;
    }

    if (blockSelectedReviewsBtn) {
      blockSelectedReviewsBtn.disabled = checkedCheckboxes.length === 0;
      blockSelectedReviewsBtn.textContent = checkedCheckboxes.length > 0
        ? detailMessages.reviewBlockSelectedLabel + ' (' + checkedCheckboxes.length + ')'
        : detailMessages.reviewBlockSelectedLabel;
    }
  }

  function bindReviewSelection() {
    document.querySelectorAll('[data-review-select]').forEach(function (checkbox) {
      checkbox.addEventListener('change', syncReviewSelectionUi);
    });

    reviewSelectAll && reviewSelectAll.addEventListener('change', function () {
      const checked = this.checked;
      document.querySelectorAll('[data-review-select]').forEach(function (checkbox) {
        checkbox.checked = checked;
      });
      syncReviewSelectionUi();
    });

    blockSelectedReviewsBtn && blockSelectedReviewsBtn.addEventListener('click', function () {
      const selectedIds = getSelectedReviewCheckboxes().map(function (checkbox) {
        return Number(checkbox.dataset.reviewSelect);
      });

      if (selectedIds.length === 0) {
        showToast(detailMessages.reviewBlockNone);
        return;
      }

      const isAllSelected = document.querySelectorAll('[data-review-select]').length === selectedIds.length;
      const confirmMessage = isAllSelected
        ? detailMessages.reviewBlockBulkConfirmAll
        : detailMessages.reviewBlockBulkConfirmSelected;
      if (!confirm(confirmMessage)) return;

      fetch(ctx + '/detail/' + spotIdx + '/review/block-bulk', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ reviewIdxList: selectedIds })
      })
        .then(function (r) { return r.json(); })
        .then(function (data) {
          if (!data.success) {
            showToast(data.message || detailMessages.reviewBlockFail);
            return;
          }

          selectedIds.forEach(function (reviewId) {
            const card = document.getElementById('rv-' + reviewId);
            card && card.remove();
          });

          if (reviewSelectAll) {
            reviewSelectAll.checked = false;
            reviewSelectAll.indeterminate = false;
          }

          syncReviewSelectionUi();
          showToast(formatMessage(detailMessages.reviewBlockBulkSuccessTemplate, data.blockedCount || selectedIds.length));

          const list = document.getElementById('reviewList');
          if (list && list.querySelectorAll('.review-card').length === 0) {
            const tools = document.querySelector('.review-admin-tools');
            tools && tools.remove();
            list.innerHTML = '<div class="review-empty">' + detailMessages.reviewEmptyVisible + '</div>';
          }
        })
        .catch(function () {
          showToast(detailMessages.genericError);
        });
    });

    syncReviewSelectionUi();
  }

  /* 리뷰 작성 폼을 #reviewWriteArea 안에 동적으로 생성 */
  function showWriteForm() {
    const area = document.getElementById('reviewWriteArea');
    if (!area) return;
    // 이미 폼이 있으면 중복 생성 방지
    if (area.querySelector('#reviewFormBox')) return;

    area.innerHTML = `
      <div class="review-form-box" id="reviewFormBox">
        <h3>✍ ${detailMessages.reviewWriteTitle}</h3>
        <div class="star-picker" id="starPicker">
          <span class="sp" data-v="1">★</span>
          <span class="sp" data-v="2">★</span>
          <span class="sp" data-v="3">★</span>
          <span class="sp" data-v="4">★</span>
          <span class="sp" data-v="5">★</span>
        </div>
        <textarea class="review-textarea" id="reviewContent"
                  maxlength="500" placeholder="${autoMsg_16702be3c7}"></textarea>
        <div class="review-form-foot">
          <span class="review-char"><span id="charCount">0</span> / 500</span>
          <button class="review-submit-btn" id="reviewSubmitBtn" disabled>${detailMessages.reviewSubmitLabel}</button>
        </div>
      </div>`;

    // 새로 생성된 폼에 이벤트 재바인딩
    selectedRating = 0;
    bindStarPicker();
    bindSubmitBtn();
  }

  bindDeleteBtns();
  bindBlockBtns();
  bindReviewSelection();

  function openReportModal(targetType, targetId) {
    document.getElementById('rptTargetType').value = targetType;
    document.getElementById('rptTargetId').value = targetId;
    document.getElementById('rptReason').value = '';
    document.getElementById('rptDescription').value = '';
    document.getElementById('rptReasonMsg').textContent = '';
    document.getElementById('rpt-modal').style.display = 'flex';
  }

  function openUserReportModal(targetUserIdx, sourceType, sourceId) {
    document.getElementById('rptUserTargetIdx').value = targetUserIdx;
    document.getElementById('rptUserSourceType').value = sourceType || '';
    document.getElementById('rptUserSourceId').value = sourceId || '';
    document.getElementById('rptUserDescription').value = '';
    document.getElementById('rptUserDescMsg').textContent = '';
    document.getElementById('rpt-user-modal').style.display = 'flex';
  }

  function bindReviewLikeBtns() {
    document.querySelectorAll('[data-review-like-idx]').forEach(btn => {
      btn.addEventListener('click', function () {
        const reviewIdx = this.dataset.reviewLikeIdx;
        const currentSpotIdx = this.dataset.spotIdx;

        fetch(ctx + '/detail/' + currentSpotIdx + '/review/' + reviewIdx + '/like', {
          method: 'POST'
        })
          .then(r => r.json())
          .then(data => {
            if (!data.success) {
              showToast(data.message || detailMessages.genericError);
              return;
            }

            this.classList.toggle('active', !!data.liked);
            const icon = this.querySelector('.review-like-icon');
            const count = this.querySelector('.review-like-count');
            if (icon) icon.textContent = data.liked ? '❤️' : '🤍';
            if (count) count.textContent = data.likeCount;
            showToast(data.message || detailMessages.reviewLikeSuccess);
          })
          .catch(() => showToast(detailMessages.genericError));
      });
    });
  }

  function bindReviewReportBtns() {
    document.querySelectorAll('[data-review-report-idx]').forEach(btn => {
      btn.addEventListener('click', function () {
        openReportModal('review', this.dataset.reviewReportIdx);
      });
    });
  }

  const rptModal = document.getElementById('rpt-modal');
  const rptCancelBtn = document.getElementById('rptCancelBtn');
  const rptSubmitBtn = document.getElementById('rptSubmitBtn');
  const rptReasonSel = document.getElementById('rptReason');
  const rptReasonMsg = document.getElementById('rptReasonMsg');

  rptCancelBtn && rptCancelBtn.addEventListener('click', function () {
    rptModal.style.display = 'none';
  });
  rptModal && rptModal.addEventListener('click', function (e) {
    if (e.target === rptModal) rptModal.style.display = 'none';
  });
  rptSubmitBtn && rptSubmitBtn.addEventListener('click', function () {
    const targetType = document.getElementById('rptTargetType').value;
    const targetId = document.getElementById('rptTargetId').value;
    const reason = rptReasonSel.value;
    const description = document.getElementById('rptDescription').value.trim();

    if (!reason) {
      rptReasonMsg.textContent = detailMessages.reportReasonRequired;
      return;
    }
    rptReasonMsg.textContent = '';

    rptSubmitBtn.disabled = true;
    fetch(ctx + '/report/' + targetType + '/' + targetId, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'reason=' + encodeURIComponent(reason) + '&description=' + encodeURIComponent(description)
    })
      .then(r => r.json())
      .then(data => {
        rptModal.style.display = 'none';
        showToast(data.message || detailMessages.reportSubmitted);
      })
      .catch(() => showToast(detailMessages.requestFail))
      .finally(() => { rptSubmitBtn.disabled = false; });
  });

  const rptUserModal = document.getElementById('rpt-user-modal');
  const rptUserCancelBtn = document.getElementById('rptUserCancelBtn');
  const rptUserSubmitBtn = document.getElementById('rptUserSubmitBtn');
  const rptUserDescArea = document.getElementById('rptUserDescription');
  const rptUserDescMsg = document.getElementById('rptUserDescMsg');

  rptUserCancelBtn && rptUserCancelBtn.addEventListener('click', function () {
    rptUserModal.style.display = 'none';
  });
  rptUserModal && rptUserModal.addEventListener('click', function (e) {
    if (e.target === rptUserModal) rptUserModal.style.display = 'none';
  });
  rptUserSubmitBtn && rptUserSubmitBtn.addEventListener('click', function () {
    const targetUserIdx = document.getElementById('rptUserTargetIdx').value;
    const sourceType = document.getElementById('rptUserSourceType').value;
    const sourceId = document.getElementById('rptUserSourceId').value;
    const description = rptUserDescArea.value.trim();

    if (description.length < 10) {
      rptUserDescMsg.textContent = detailMessages.userReportMinLength;
      return;
    }
    rptUserDescMsg.textContent = '';

    let body = 'description=' + encodeURIComponent(description);
    if (sourceType) body += '&sourceType=' + encodeURIComponent(sourceType);
    if (sourceId) body += '&sourceId=' + encodeURIComponent(sourceId);

    rptUserSubmitBtn.disabled = true;
    fetch(ctx + '/report/user/' + targetUserIdx, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: body
    })
      .then(r => r.json())
      .then(data => {
        rptUserModal.style.display = 'none';
        showToast(data.message || detailMessages.reportSubmitted);
      })
      .catch(() => showToast(detailMessages.requestFail))
      .finally(() => { rptUserSubmitBtn.disabled = false; });
  });

  document.addEventListener('click', function (e) {
    const el = e.target.closest('.rpt-user-link[data-user-idx]');
    if (!el) return;
    e.preventDefault();
    openUserReportModal(
      el.getAttribute('data-user-idx'),
      el.getAttribute('data-source-type'),
      el.getAttribute('data-source-id')
    );
  });

  bindReviewLikeBtns();
  bindReviewReportBtns();

})();
</script>

<c:if test="${flightAvailable and not empty lowestFlightOffer}">
<script>
(function () {
  var detailMessages = window.detailMessages || {};
  function formatMessage(template) {
    var args = Array.prototype.slice.call(arguments, 1);
    return String(template || '').replace(/\{(\d+)\}/g, function (_, index) {
      return typeof args[index] !== 'undefined' ? args[index] : '';
    });
  }
  var flightModal = document.getElementById('flightModal');
  var openBtn = document.getElementById('openFlightModalBtn');
  var closeBtn = document.getElementById('closeFlightModalBtn');
  var offerList = document.getElementById('flightOfferList');
  var originalPriceEl = document.getElementById('flightOriginalPrice');
  var gradeDiscountEl = document.getElementById('flightGradeDiscount');
  var totalPriceEl = document.getElementById('flightTotalPrice');
  var cashBalanceEl = document.getElementById('flightCashBalance');
  var mileageBalanceEl = document.getElementById('flightMileageBalance');
  var mileageLimitText = document.getElementById('flightMileageLimitText');
  var mileageInput = document.getElementById('flightMileageInput');
  var cashInput = document.getElementById('flightCashInput');
  var departureDateInput = document.getElementById('flightDepartureDate');
  var returnDateInput = document.getElementById('flightReturnDate');
  var useMaxMileageBtn = document.getElementById('flightUseMaxMileageBtn');
  var purchaseBtn = document.getElementById('flightPurchaseBtn');
  var messageEl = document.getElementById('flightPayMessage');

  var ctx = '${pageContext.request.contextPath}';
  var spotIdx = '${spot.spotIdx}';
  var isLoggedIn = ${isLoggedIn ? 'true' : 'false'};
  var cashBalance = Number('${empty loginUser ? 0 : loginUser.cashBalance}');
  var mileageBalance = Number('${empty loginUser ? 0 : loginUser.mileageBalance}');
  var offers = [];
  var selectedOffer = null;

  function toDateValue(date) {
    var year = date.getFullYear();
    var month = String(date.getMonth() + 1).padStart(2, '0');
    var day = String(date.getDate()).padStart(2, '0');
    return year + '-' + month + '-' + day;
  }

  function initializeDateInputs() {
    if (!departureDateInput || !returnDateInput) return;
    var tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    var defaultDeparture = new Date();
    defaultDeparture.setDate(defaultDeparture.getDate() + 14);
    var defaultReturn = new Date();
    defaultReturn.setDate(defaultReturn.getDate() + 19);
    departureDateInput.min = toDateValue(tomorrow);
    departureDateInput.value = toDateValue(defaultDeparture);
    returnDateInput.min = toDateValue(new Date(defaultDeparture.getTime() + 24 * 60 * 60 * 1000));
    returnDateInput.value = toDateValue(defaultReturn);
  }

  function getSelectedDates() {
    return {
      departureDate: departureDateInput ? departureDateInput.value : '',
      returnDate: returnDateInput ? returnDateInput.value : ''
    };
  }

  function validateSelectedDates() {
    var dates = getSelectedDates();
    if (!dates.departureDate || !dates.returnDate) {
      messageEl.textContent = detailMessages.flightDateRequired;
      return false;
    }
    if (dates.returnDate <= dates.departureDate) {
      messageEl.textContent = detailMessages.flightReturnInvalid;
      return false;
    }
    return true;
  }

  function formatMoney(value, suffix) {
    return Number(value || 0).toLocaleString('ko-KR') + ' ' + suffix;
  }

  function getFinalPrice(offer) {
    return Number(offer.finalPrice || offer.totalPrice || 0);
  }

  function getDiscountText(offer) {
    var discountRate = Number(offer.discountRate || 0);
    var discountAmount = Number(offer.discountAmount || 0);
    if (discountRate <= 0 || discountAmount <= 0) {
      return detailMessages.flightNoDiscount;
    }
    return escapeHtml(offer.memberGrade || 'BRONZE') + ' ' + discountRate.toFixed(2) + '% · -' + formatMoney(discountAmount, 'C');
  }

  function formatDateTime(value) {
    if (!value) return '-';
    if (Array.isArray(value)) {
      var month = String(value[1]).padStart(2, '0');
      var day = String(value[2]).padStart(2, '0');
      var hour = String(value[3]).padStart(2, '0');
      var minute = String(value[4]).padStart(2, '0');
      return value[0] + '-' + month + '-' + day + ' ' + hour + ':' + minute;
    }
    return String(value).replace('T', ' ').substring(0, 16);
  }

  function escapeHtml(value) {
    return String(value == null ? '' : value)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }

  function openFlightModal() {
    if (!isLoggedIn) {
      location.href = ctx + '/auth/login?redirect=' + encodeURIComponent('/detail/' + spotIdx);
      return;
    }
    if (!flightModal) return;
    flightModal.classList.add('show');
    flightModal.setAttribute('aria-hidden', 'false');
    document.body.classList.add('modal-open');
    loadOffers();
  }

  function closeFlightModal() {
    if (!flightModal) return;
    flightModal.classList.remove('show');
    flightModal.setAttribute('aria-hidden', 'true');
    document.body.classList.remove('modal-open');
  }

  function loadOffers() {
    if (!validateSelectedDates()) return;
    if (offers.length > 0) return;
    var dates = getSelectedDates();
    offerList.innerHTML = '<div class="flight-pay-msg">' + detailMessages.flightLoading + '</div>';

    fetch(ctx + '/flight/offers?spotIdx=' + encodeURIComponent(spotIdx)
      + '&departureDate=' + encodeURIComponent(dates.departureDate)
      + '&returnDate=' + encodeURIComponent(dates.returnDate))
      .then(function (res) { return res.json(); })
      .then(function (data) {
        if (!data.success || !data.available || !data.offers || data.offers.length === 0) {
          offerList.innerHTML = '<div class="flight-pay-msg">' + detailMessages.flightEmpty + '</div>';
          return;
        }
        offers = data.offers;
        renderOffers();
        selectOffer(offers[0].offerId);
      })
      .catch(function () {
        offerList.innerHTML = '<div class="flight-pay-msg">' + detailMessages.flightLoadFail + '</div>';
      });
  }

  function renderOffers() {
    offerList.innerHTML = offers.map(function (offer) {
      return [
        '<div class="flight-offer-card" data-offer-id="' + escapeHtml(offer.offerId) + '">',
        '  <div class="flight-offer-top">',
        '    <div>',
        '      <div class="flight-airline">' + escapeHtml(offer.airlineName) + '</div>',
        '      <div class="flight-no">' + escapeHtml(offer.flightNo) + ' · ' + escapeHtml(offer.seatClass) + '</div>',
        '    </div>',
        '    <div class="flight-price">' + formatMoney(getFinalPrice(offer), 'C') + '</div>',
        '  </div>',
        '  <div class="flight-route">',
        '    <strong>' + escapeHtml(offer.originAirportCode) + '</strong>',
        '    <span>→</span>',
        '    <strong>' + escapeHtml(offer.destinationAirportCode) + '</strong>',
        '    <span>' + escapeHtml(offer.durationText) + '</span>',
        '  </div>',
        '  <div class="flight-no">' + detailMessages.flightOutboundLabel + ' ' + formatDateTime(offer.departureTime) + ' ' + detailMessages.flightDepartLabel + ' · ' + formatDateTime(offer.arrivalTime) + ' ' + detailMessages.flightArriveLabel + '</div>',
        '  <div class="flight-no">' + detailMessages.flightReturnLabel + ' ' + escapeHtml(offer.returnOriginAirportCode) + ' → ' + escapeHtml(offer.returnDestinationAirportCode) + ' · ' + formatDateTime(offer.returnDepartureTime) + ' ' + detailMessages.flightDepartLabel + ' · ' + formatDateTime(offer.returnArrivalTime) + ' ' + detailMessages.flightArriveLabel + '</div>',
        '</div>'
      ].join('');
    }).join('');

    offerList.querySelectorAll('.flight-offer-card').forEach(function (card) {
      card.addEventListener('click', function () {
        selectOffer(card.dataset.offerId);
      });
    });
  }

  function selectOffer(offerId) {
    selectedOffer = offers.find(function (offer) { return offer.offerId === offerId; });
    if (!selectedOffer) return;

    offerList.querySelectorAll('.flight-offer-card').forEach(function (card) {
      card.classList.toggle('active', card.dataset.offerId === offerId);
    });

    originalPriceEl.textContent = formatMoney(selectedOffer.totalPrice, 'C');
    gradeDiscountEl.textContent = getDiscountText(selectedOffer);
    totalPriceEl.textContent = formatMoney(getFinalPrice(selectedOffer), 'C');
    mileageLimitText.textContent = formatMessage(detailMessages.flightMileageLimitTemplate, formatMoney(selectedOffer.maxMileageUse, 'M'));
    mileageInput.max = Math.min(selectedOffer.maxMileageUse, mileageBalance);
    mileageInput.value = 0;
    updateCashAmount();
    messageEl.textContent = '';
  }

  function updateCashAmount() {
    if (!selectedOffer) return;
    var mileage = Math.max(0, Number(mileageInput.value || 0));
    var maxMileage = Math.min(selectedOffer.maxMileageUse, mileageBalance);
    if (mileage > maxMileage) {
      mileage = maxMileage;
      mileageInput.value = mileage;
    }
    cashInput.value = getFinalPrice(selectedOffer) - mileage;
  }

  function purchaseFlight() {
    if (!isLoggedIn) {
      messageEl.textContent = detailMessages.flightLoginRequired;
      return;
    }
    if (!selectedOffer) {
      messageEl.textContent = detailMessages.flightSelectOffer;
      return;
    }
    if (!validateSelectedDates()) return;

    var mileageAmount = Number(mileageInput.value || 0);
    var cashAmount = Number(cashInput.value || 0);
    var dates = getSelectedDates();
    if (cashAmount > cashBalance) {
      messageEl.textContent = detailMessages.packageInsufficientCash;
      return;
    }

    purchaseBtn.disabled = true;
    messageEl.textContent = detailMessages.packageProcessing;

    fetch(ctx + '/flight/purchase', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        spotIdx: Number(spotIdx),
        offerId: selectedOffer.offerId,
        departureDate: dates.departureDate,
        returnDate: dates.returnDate,
        cashAmount: cashAmount,
        mileageAmount: mileageAmount
      })
    })
      .then(function (res) { return res.json(); })
      .then(function (data) {
        if (!data.success) {
          messageEl.textContent = data.message || detailMessages.flightPurchaseFail;
          return;
        }
        cashBalance = Number(data.cashBalance || 0);
        mileageBalance = Number(data.mileageBalance || 0);
        cashBalanceEl.textContent = formatMoney(cashBalance, 'C');
        mileageBalanceEl.textContent = formatMoney(mileageBalance, 'M');
        messageEl.textContent = formatMessage(detailMessages.flightPurchaseSuccessTemplate, data.purchaseNo);
        updateCashAmount();
      })
      .catch(function () {
        messageEl.textContent = detailMessages.flightPurchaseError;
      })
      .finally(function () {
        purchaseBtn.disabled = false;
      });
  }

  openBtn && openBtn.addEventListener('click', openFlightModal);
  closeBtn && closeBtn.addEventListener('click', closeFlightModal);
  flightModal && flightModal.addEventListener('click', function (e) {
    if (e.target === flightModal) closeFlightModal();
  });
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && flightModal && flightModal.classList.contains('show')) {
      closeFlightModal();
    }
  });
  mileageInput && mileageInput.addEventListener('input', updateCashAmount);
  useMaxMileageBtn && useMaxMileageBtn.addEventListener('click', function () {
    if (!selectedOffer) return;
    mileageInput.value = Math.min(selectedOffer.maxMileageUse, mileageBalance);
    updateCashAmount();
  });
  departureDateInput && departureDateInput.addEventListener('change', function () {
    if (!departureDateInput.value || !returnDateInput) return;
    var nextReturnDate = new Date(departureDateInput.value);
    nextReturnDate.setDate(nextReturnDate.getDate() + 1);
    returnDateInput.min = toDateValue(nextReturnDate);
    if (returnDateInput.value <= departureDateInput.value) {
      returnDateInput.value = toDateValue(nextReturnDate);
    }
    offers = [];
    selectedOffer = null;
    loadOffers();
  });
  returnDateInput && returnDateInput.addEventListener('change', function () {
    offers = [];
    selectedOffer = null;
    loadOffers();
  });
  purchaseBtn && purchaseBtn.addEventListener('click', purchaseFlight);

  initializeDateInputs();
  window.openFlightTicketModal = openFlightModal;
})();
</script>
</c:if>

<%-- Google Maps: 위도/경도가 있는 경우만 로드 --%>
<c:if test="${not empty spot.latitude and not empty spot.longitude and spot.latitude != 0 and spot.longitude != 0}">
<script>
var detailMessages = window.detailMessages || {};
/* 여행지 좌표와 이름 */
var SPOT_LAT  = parseFloat('<fmt:formatNumber value="${spot.latitude}"  pattern="0.######" groupingUsed="false"/>');
var SPOT_LNG  = parseFloat('<fmt:formatNumber value="${spot.longitude}" pattern="0.######" groupingUsed="false"/>');
var SPOT_NAME = '${fn:escapeXml(spot.name)}';

/* 서울 기준 좌표 */
var SEOUL_LAT = 37.5665;
var SEOUL_LNG = 126.9780;

var googleMap, destinationMarker, seoulMarker, routeLine, labelOverlay;
var lineVisible = false;

/* 1. 도시명 라벨 (OverlayView 커스텀 표시) */
function CityLabel(position, map) {
  this.position_ = position;
  this.div_      = null;
  this.setMap(map);
}

function cityLabel_onAdd() {
  var div = document.createElement('div');
  div.style.cssText = [
    'position:absolute',
    'background:#fff',
    'border:1.5px solid #ef4444',
    'border-radius:7px',
    'padding:4px 10px',
    'box-shadow:0 2px 6px rgba(0,0,0,.20)',
    'pointer-events:none',
    'white-space:nowrap',
    'text-align:center',
    'transform:translateX(-50%)',
    'font-size:13px',
    'font-weight:700',
    'color:#1f2937',
    'font-family:"Noto Sans KR",sans-serif'
  ].join(';');
  div.textContent = SPOT_NAME;

  /* 말풍선 꼬리 */
  var tail = document.createElement('div');
  tail.style.cssText = [
    'position:absolute',
    'bottom:-7px',
    'left:50%',
    'transform:translateX(-50%)',
    'width:0',
    'height:0',
    'border-left:5px solid transparent',
    'border-right:5px solid transparent',
    'border-top:7px solid #ef4444'
  ].join(';');
  div.appendChild(tail);

  this.div_ = div;
  this.getPanes().floatPane.appendChild(div);
}

function cityLabel_draw() {
  var pos = this.getProjection().fromLatLngToDivPixel(this.position_);
  if (pos && this.div_) {
    this.div_.style.left = pos.x + 'px';
    this.div_.style.top  = (pos.y - 48) + 'px';
  }
}

function cityLabel_onRemove() {
  if (this.div_ && this.div_.parentNode) {
    this.div_.parentNode.removeChild(this.div_);
    this.div_ = null;
  }
}

/* 2. Google Maps 초기화 */
function initMap() {
  if (isNaN(SPOT_LAT) || isNaN(SPOT_LNG)) {
    document.getElementById('googleMap').innerHTML =
      '<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#6b7280;font-size:14px;">'
      + detailMessages.locationNoCoordinates + '</div>';
    return;
  }

  /* google.maps 로드 후 OverlayView 연결 */
  CityLabel.prototype = Object.create(google.maps.OverlayView.prototype);
  CityLabel.prototype.constructor = CityLabel;
  CityLabel.prototype.onAdd    = cityLabel_onAdd;
  CityLabel.prototype.draw     = cityLabel_draw;
  CityLabel.prototype.onRemove = cityLabel_onRemove;

  var destLatLng  = { lat: SPOT_LAT,  lng: SPOT_LNG  };
  var seoulLatLng = { lat: SEOUL_LAT, lng: SEOUL_LNG };

  /* 지도 생성 */
  googleMap = new google.maps.Map(document.getElementById('googleMap'), {
    center:            destLatLng,
    zoom:              5,
    mapTypeId:         'roadmap',
    zoomControl:       true,
    mapTypeControl:    false,
    streetViewControl: false,
    fullscreenControl: true
  });

  /* 목적지 포함 Bounds */
  var bounds = new google.maps.LatLngBounds();
  bounds.extend(new google.maps.LatLng(SPOT_LAT,  SPOT_LNG));
  bounds.extend(new google.maps.LatLng(SEOUL_LAT, SEOUL_LNG));
  googleMap.fitBounds(bounds, { top: 100, right: 60, bottom: 60, left: 60 });

  /* 목적지 여행지 마커 (빨간 핀) */
  destinationMarker = new google.maps.Marker({
    position:  destLatLng,
    map:       googleMap,
    title:     SPOT_NAME,
    icon: {
      path:         google.maps.SymbolPath.CIRCLE,
      scale:        8,
      fillColor:    '#ef4444',
      fillOpacity:  1,
      strokeColor:  '#ffffff',
      strokeWeight: 2
    },
    zIndex:    10,
    animation: google.maps.Animation.DROP
  });

  /* 서울 기준 마커 (파란 핀) */
  seoulMarker = new google.maps.Marker({
    position:  seoulLatLng,
    map:       googleMap,
    title:     '\uc11c\uc6b8',
    icon: {
      path:         google.maps.SymbolPath.CIRCLE,
      scale:        7,
      fillColor:    '#2563eb',
      fillOpacity:  1,
      strokeColor:  '#ffffff',
      strokeWeight: 2
    },
    zIndex:    9,
    animation: google.maps.Animation.DROP
  });

  /* 서울 라벨 */
  new google.maps.Marker({
    position: { lat: SEOUL_LAT + 1.6, lng: SEOUL_LNG },
    map:      googleMap,
    icon:     { path: google.maps.SymbolPath.CIRCLE, scale: 0 },
    label: {
      text:       '\uc11c\uc6b8',
      color:      '#1e40af',
      fontSize:   '12px',
      fontWeight: '700'
    }
  });

  /* 목적지 도시명 라벨 (항상 표시) */
  labelOverlay = new CityLabel(
    new google.maps.LatLng(SPOT_LAT, SPOT_LNG),
    googleMap
  );

  /* 목적지 연결선 Polyline (초기 숨김) */
  routeLine = new google.maps.Polyline({
    path:          [seoulLatLng, destLatLng],
    geodesic:      true,
    strokeColor:   '#2563eb',
    strokeOpacity: 0,
    strokeWeight:  2,
    icons: [{
      icon:   { path: 'M 0,-1 0,1', strokeOpacity: 1, scale: 3 },
      offset: '0',
      repeat: '16px'
    }],
    map: googleMap
  });

  /* 여행지 마커 클릭: 항공권이 있으면 모달을 열고, 없으면 연결선을 토글 */
  destinationMarker.addListener('click', function () {
    if (typeof window.openFlightTicketModal === 'function') {
      window.openFlightTicketModal();
      destinationMarker.setAnimation(google.maps.Animation.BOUNCE);
      setTimeout(function() { destinationMarker.setAnimation(null); }, 1200);
      return;
    }

    if (lineVisible) {
      routeLine.setOptions({ strokeOpacity: 0 });
      lineVisible = false;
    } else {
      var opacity = 0;
      var fadeIn = setInterval(function() {
        opacity += 0.1;
        routeLine.setOptions({ strokeOpacity: Math.min(opacity, 0.85) });
        if (opacity >= 0.85) clearInterval(fadeIn);
      }, 25);
      lineVisible = true;
    }
    destinationMarker.setAnimation(google.maps.Animation.BOUNCE);
    setTimeout(function() { destinationMarker.setAnimation(null); }, 1200);
  });

  /* 지도 클릭 시 연결선 닫기 */
  googleMap.addListener('click', function () {
    routeLine.setOptions({ strokeOpacity: 0 });
    lineVisible = false;
  });
}
</script>

<!-- Google Maps JavaScript API -->
<script
  src="https://maps.googleapis.com/maps/api/js?key=${mapsApiKey}&callback=initMap&loading=async&language=ko&region=KR"
  async defer></script>
</c:if>

<%-- 체류 시간 기록 + AI 추천 (로그인 사용자만) --%>
<c:if test="${isLoggedIn}">
<script>
(function() {
  var CTX_REC      = '${pageContext.request.contextPath}';
  var SPOT_IDX_REC = '${spot.spotIdx}';
  var AI_DEFAULT_TITLE = '${autoMsg_6cceb0a144}';
  var AI_DEFAULT_DESC = '${autoMsg_7fd241d1aa}';
  var AI_TRENDING_TITLE = '${autoMsg_52ebf8001d}';
  var AI_TRENDING_DESC = '${autoMsg_b50aa39cea}';
  var pageEnter    = Date.now();
  var logSent      = false;

  /* 체류 시간 전송: fetch + keepalive 사용 */
  function sendViewLog() {
    if (logSent) return;
    var staySeconds = Math.round((Date.now() - pageEnter) / 1000);
    if (staySeconds < 2) return;
    logSent = true;
    fetch(CTX_REC + '/recommend/view-log', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ spotIdx: SPOT_IDX_REC, staySeconds: staySeconds }),
      keepalive: true
    }).then(function() {
      /* 체류 시간 전송 완료 후 추천 섹션 즉시 새로고침 */
      refreshRecommendations();
    }).catch(function() { /* 무시 */ });
  }
  window.addEventListener('beforeunload', sendViewLog);
  document.addEventListener('visibilitychange', function() {
    if (document.visibilityState === 'hidden') sendViewLog();
  });

  /* 추천 카드 HTML 생성 */
  function buildRecCard(spot) {
    var thumb = spot.thumbUrl ||
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80';
    var tags  = (spot.tags || []).slice(0, 3).map(function(t) {
      return '<span class="spot-tag">' + escHtml(t) + '</span>';
    }).join('');
    var rating = (spot.ratingAvg || 0).toFixed(1);
    var reason = spot.recReason ? '<p style="font-size:12px;color:var(--blue);margin-top:6px;">&#x1F916; ' + escHtml(spot.recReason) + '</p>' : '';

    return '<div class="spot-card" style="cursor:pointer;" onclick="location.href=\'' +
           CTX_REC + '/detail/' + spot.spotIdx + '\'">' +
      '<div class="spot-card__img-wrap">' +
        '<img class="spot-card__img" src="' + escHtml(thumb) + '" alt="' + escHtml(spot.spotName) + '"' +
             ' onerror="this.src=\'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80\'">' +
        (spot.region ? '<span class="spot-card__region-badge">' + escHtml(spot.region) + '</span>' : '') +
      '</div>' +
      '<div class="spot-card__body">' +
        '<div class="spot-card__top">' +
          '<div class="spot-card__name">' + escHtml(spot.spotName) + '</div>' +
          '<div class="spot-card__rating"><span class="star">&#11088;</span>' + rating +
            '<span class="spot-card__review-cnt">(' + (spot.reviewCount || 0) + ')</span></div>' +
        '</div>' +
        reason +
        '<div class="spot-card__tags" style="margin-top:8px;">' + tags + '</div>' +
      '</div>' +
    '</div>';
  }

  function escHtml(str) {
    if (!str) return '';
    return String(str)
      .replace(/&/g, '&amp;').replace(/</g, '&lt;')
      .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  }

  /* AI 추천 조회 (최초 로드) */
  function loadRecommendations() {
    fetch(CTX_REC + '/recommend/spots?currentSpotIdx=' + SPOT_IDX_REC)
      .then(function(r) { return r.json(); })
      .then(function(data) {
        var loadMsg  = document.getElementById('recLoadingMsg');
        var grid     = document.getElementById('recGrid');
        var emptyMsg = document.getElementById('recEmptyMsg');

        if (!data.success || !data.spots || data.spots.length === 0) {
          if (loadMsg)  loadMsg.style.display  = 'none';
          if (emptyMsg) emptyMsg.style.display = 'block';
          return;
        }
        /* 인기 추천 응답이면 섹션 제목 변경 */
        var title = document.getElementById('aiRecTitle');
        var desc  = document.getElementById('aiRecDesc');
        if (data.isTrending) {
          if (title) title.textContent = AI_TRENDING_TITLE;
          if (desc)  desc.textContent  = AI_TRENDING_DESC;
        } else {
          if (title) title.textContent = AI_DEFAULT_TITLE;
          if (desc)  desc.textContent = AI_DEFAULT_DESC;
        }
        if (grid) {
          grid.innerHTML     = data.spots.map(buildRecCard).join('');
          grid.style.display = '';
        }
        if (loadMsg) loadMsg.style.display = 'none';
        if (emptyMsg) emptyMsg.style.display = 'none';
      })
      .catch(function() {
        var loadMsg = document.getElementById('recLoadingMsg');
        if (loadMsg) loadMsg.textContent = detailMessages.aiLoadFail;
      });
  }

  /* 추천만 조용히 새로고침 (체류 기록 전송 후) */
  function refreshRecommendations() {
    fetch(CTX_REC + '/recommend/spots?currentSpotIdx=' + SPOT_IDX_REC)
      .then(function(r) { return r.json(); })
      .then(function(data) {
        var grid     = document.getElementById('recGrid');
        var emptyMsg = document.getElementById('recEmptyMsg');
        if (!data.success || !data.spots || data.spots.length === 0) return;
        if (grid) {
          grid.innerHTML     = data.spots.map(buildRecCard).join('');
          grid.style.display = '';
        }
        if (emptyMsg) emptyMsg.style.display = 'none';
      })
      .catch(function() { /* 새로고침 실패는 조용히 무시 */ });
  }

  /* 페이지 로드 후 1초 뒤 최초 추천 조회 */
  setTimeout(loadRecommendations, 1000);
})();
</script>
</c:if>

</body>
</html>





