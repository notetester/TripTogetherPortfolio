<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_home_hero_title" code="home.hero.title"/>
<spring:message var="msg_home_hero_subtitle" code="home.hero.subtitle"/>
<spring:message var="msg_home_hero_explore" code="home.hero.explore"/>
<spring:message var="msg_home_hero_ai" code="home.hero.ai"/>
<spring:message var="msg_home_feature_ai_title" code="home.feature.ai.title"/>
<spring:message var="msg_home_feature_ai_desc" code="home.feature.ai.desc"/>
<spring:message var="msg_home_feature_schedule_title" code="home.feature.schedule.title"/>
<spring:message var="msg_home_feature_schedule_desc" code="home.feature.schedule.desc"/>
<spring:message var="msg_home_feature_community_title" code="home.feature.community.title"/>
<spring:message var="msg_home_feature_community_desc" code="home.feature.community.desc"/>
<spring:message var="msg_home_popular_title" code="home.popular.title"/>
<spring:message var="msg_home_more" code="home.more"/>
<spring:message var="msg_home_empty_spots" code="home.empty.spots"/>
<spring:message var="msg_home_packages_prev" code="home.packages.prev"/>
<spring:message var="msg_home_packages_next" code="home.packages.next"/>
<spring:message var="msg_home_packages_title" code="home.packages.title"/>
<spring:message var="msg_home_packages_subtitle" code="home.packages.subtitle"/>
<spring:message var="msg_home_packages_partnerBadge" code="home.packages.partnerBadge"/>
<spring:message var="msg_home_packages_noSummary" code="home.packages.noSummary"/>
<spring:message var="msg_home_packages_bookingCount" code="home.packages.bookingCount"/>
<spring:message var="msg_home_courses_title" code="home.courses.title"/>
<spring:message var="msg_home_empty_courses" code="home.empty.courses"/>
<spring:message var="msg_home_plan_duration" code="home.plan.duration"/>
<spring:message var="msg_home_plan_author" code="home.plan.author"/>
<spring:message var="msg_home_community_title" code="home.community.title"/>
<spring:message var="msg_home_empty_posts" code="home.empty.posts"/>
<spring:message var="msg_home_postType_review" code="home.postType.review"/>
<spring:message var="msg_home_postType_photo" code="home.postType.photo"/>
<spring:message var="msg_home_postType_tip" code="home.postType.tip"/>
<spring:message var="msg_home_postType_question" code="home.postType.question"/>
<spring:message var="msg_community_blocked_ai" code="community.blocked.ai"/>
<spring:message var="msg_community_blocked_report" code="community.blocked.report"/>
<spring:message var="msg_community_badge_ai" code="community.badge.ai"/>
<spring:message var="msg_home_blocked_report" code="home.blocked.report"/>
<spring:message var="msg_home_blocked_post" code="home.blocked.post"/>
<spring:message var="msg_home_blocked_user" code="home.blocked.user"/>
<c:set var="pageCSS" value="home/home.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<!-- ===== 히어로 섹션 ===== -->
<section class="hero">
    <div class="hero-bg"></div>
    <div class="hero-ov"></div>
    <div class="hero-c">
        <h1>${msg_home_hero_title}</h1>
        <p>${msg_home_hero_subtitle}</p>
        <div class="hero-btns">
            <button class="btn-pri" onclick="location.href='${pageContext.request.contextPath}/explore'">
                &#128205; ${msg_home_hero_explore}
            </button>
            <button class="btn-sec" onclick="location.href='${pageContext.request.contextPath}/assistant'">
                &#10024; ${msg_home_hero_ai}
            </button>
        </div>
    </div>
</section>

<!-- ===== 피처 섹션 ===== -->
<section class="feat-sec">
    <div class="si">
        <div class="feat-grid">
            <div class="feat-card" style="cursor:pointer;"
                 onclick="location.href='${pageContext.request.contextPath}/assistant'">
                <div class="feat-icon fi-b">&#10024;</div>
                <h3>${msg_home_feature_ai_title}</h3>
                <p>${msg_home_feature_ai_desc}</p>
            </div>
            <div class="feat-card" style="cursor:pointer;"
                 onclick="location.href='${pageContext.request.contextPath}/courses/list'">
                <div class="feat-icon fi-p">&#128197;</div>
                <h3>${msg_home_feature_schedule_title}</h3>
                <p>${msg_home_feature_schedule_desc}</p>
            </div>
            <div class="feat-card" style="cursor:pointer;"
                 onclick="location.href='${pageContext.request.contextPath}/community/list'">
                <div class="feat-icon fi-g">&#128172;</div>
                <h3>${msg_home_feature_community_title}</h3>
                <p>${msg_home_feature_community_desc}</p>
            </div>
        </div>
    </div>
</section>

<!-- ===== 인기 여행지 섹션 ===== -->
<section class="cs">
    <div class="si">
        <div class="sh">
            <h2 class="st">${msg_home_popular_title}</h2>
            <button class="vm" onclick="location.href='${pageContext.request.contextPath}/explore'">${msg_home_more} &#8594;</button>
        </div>
        <div id="spotsSection">
            <c:choose>
                <c:when test="${empty popularSpots}">
                    <div style="padding:40px;text-align:center;color:var(--gray-400);">${msg_home_empty_spots}</div>
                </c:when>
                <c:otherwise>
                    <div class="home-grid">
                        <c:forEach var="spot" items="${popularSpots}" varStatus="st">
                            <c:if test="${st.index < 4}">
                                <div class="cc-wrap" data-spot-id="${spot.spotIdx}">
                                        <div class="dc">
                                            <div class="dc-iw">
                                                <c:choose>
                                                    <c:when test="${not empty spot.imageUrl}">
                                                        <img class="dc-img" src="${spot.imageUrl}" alt="${spot.name}"
                                                             onerror="spotImgError(this)">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="dc-img-placeholder">
                                                            <span class="dc-ph-icon">&#9992;</span>
                                                            <span class="dc-ph-name">${spot.name}</span>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${not empty spot.ratingAvg and spot.ratingAvg > 0}">
                                                    <c:choose>
                                                        <c:when test="${spot.ratingAvg >= 4.8}">
                                                            <span class="dc-badge dc-badge-excellent">&#9733; <fmt:formatNumber value="${spot.ratingAvg}" maxFractionDigits="1"/></span>
                                                        </c:when>
                                                        <c:when test="${spot.ratingAvg >= 4.5}">
                                                            <span class="dc-badge dc-badge-verygood">&#9733; <fmt:formatNumber value="${spot.ratingAvg}" maxFractionDigits="1"/></span>
                                                        </c:when>
                                                        <c:when test="${spot.ratingAvg >= 4.0}">
                                                            <span class="dc-badge dc-badge-good">&#9733; <fmt:formatNumber value="${spot.ratingAvg}" maxFractionDigits="1"/></span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="dc-badge dc-badge-average">&#9733; <fmt:formatNumber value="${spot.ratingAvg}" maxFractionDigits="1"/></span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </div>
                                            <div class="dc-b">
                                                <div class="dc-name">${spot.name}</div>
                                                <c:if test="${not empty spot.region}">
                                                    <div class="dc-ctry">&#128205; ${spot.region}</div>
                                                </c:if>
                                                <c:if test="${not empty spot.description}">
                                                    <div class="dc-desc">${spot.description}</div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<!-- ===== 추천 여행 패키지 섹션 ===== -->
<c:if test="${not empty recommendedPackages}">
    
    
    <section class="cs home-package-sec">
        <div class="si">
            <div class="sh package-sh">
                <div>
                    <h2 class="st">${msg_home_packages_title}</h2>
                    <p class="package-sub">${msg_home_packages_subtitle}</p>
                </div>
                <div class="package-controls">
                    <button type="button" class="package-nav-btn" id="packagePrevBtn" aria-label="${msg_home_packages_prev}">&#8249;</button>
                    <button type="button" class="package-nav-btn" id="packageNextBtn" aria-label="${msg_home_packages_next}">&#8250;</button>
                    <button type="button" class="vm" data-home-package-list-url="${pageContext.request.contextPath}/packages">
                        ${msg_home_more} &#8594;
                    </button>
                </div>
            </div>

            <div class="home-package-slider" id="homePackageSlider">
                <div class="home-package-track" id="homePackageTrack">
                    <c:forEach var="pkg" items="${recommendedPackages}">
                        <c:set var="packageImagePath" value="${pkg.mainImagePath}"/>
                        <c:if test="${not empty pkg.mainImagePath and not (fn:startsWith(pkg.mainImagePath, 'http://') or fn:startsWith(pkg.mainImagePath, 'https://'))}">
                            <c:set var="packageImagePath" value="${pageContext.request.contextPath}${pkg.mainImagePath}"/>
                        </c:if>

                        <article class="home-package-card"
                                 data-spot-id="${pkg.spotIdx}"
                                 tabindex="0">
                            <div class="home-package-img-wrap">
                                <c:choose>
                                    <c:when test="${not empty packageImagePath}">
                                        <img class="home-package-img"
                                             src="${fn:escapeXml(packageImagePath)}"
                                             alt="${fn:escapeXml(pkg.packageTitle)}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="home-package-img home-package-img-empty">TripTogether</div>
                                    </c:otherwise>
                                </c:choose>

                                <c:if test="${pkg.sellerRole eq 'PARTNER'}">
                                    <span class="home-package-partner">${msg_home_packages_partnerBadge}</span>
                                </c:if>
                            </div>

                            <div class="home-package-body">
                                <div class="home-package-spot">
                                    &#128205; ${fn:escapeXml(pkg.spotRegion)} · ${fn:escapeXml(pkg.spotName)}
                                </div>
                                <h3>${fn:escapeXml(pkg.packageTitle)}</h3>
                                <p>
                                    <c:choose>
                                        <c:when test="${not empty pkg.packageSummary}">
                                            ${fn:escapeXml(pkg.packageSummary)}
                                        </c:when>
                                        <c:otherwise>
                                            ${msg_home_packages_noSummary}
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="home-package-meta">
                                    <span>
                                        <fmt:formatNumber value="${pkg.packagePrice}" pattern="#,###"/>
                                        ${fn:escapeXml(pkg.currencyCode)}
                                    </span>
                                    <span>
                                        ${msg_home_packages_bookingCount}
                                        ${pkg.bookingCount}
                                    </span>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
</c:if>

<!-- ===== 트렌딩 여행 코스 섹션 ===== -->
<section class="cs bg">
    <div class="si">
        <div class="sh">
            <h2 class="st">${msg_home_courses_title}</h2>
            <button class="vm" onclick="location.href='${pageContext.request.contextPath}/courses/list'">${msg_home_more} &#8594;</button>
        </div>
        <div id="plansSection">
            <c:choose>
                <c:when test="${empty trendingPlans}">
                    <div style="padding:40px;text-align:center;color:var(--gray-400);">${msg_home_empty_courses}</div>
                </c:when>
                <c:otherwise>
                    <div class="home-grid">
                        <c:forEach var="plan" items="${trendingPlans}" varStatus="st">
                            <c:if test="${st.index < 4}">
                                <div class="cc-wrap" data-plan-id="${plan.planId}">
                                        <div class="tc">
                                            <div class="tc-iw">
                                                <c:choose>
                                                    <c:when test="${not empty plan.imageUrl}">
                                                        <img class="tc-img" src="${plan.imageUrl}" alt="${plan.title}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="tc-img-placeholder">&#9992;</div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${not empty plan.nights}">
                                                    <c:choose>
                                                        <c:when test="${plan.nights <= 1}">
                                                            <span class="tc-badge tc-badge-short">${msg_home_plan_duration}</span>
                                                        </c:when>
                                                        <c:when test="${plan.nights == 2}">
                                                            <span class="tc-badge tc-badge-standard">${msg_home_plan_duration}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="tc-badge tc-badge-long">${msg_home_plan_duration}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </div>
                                            <div class="tc-b">
                                                <div class="tc-title">${plan.title}</div>
                                                <div class="tc-foot">
                                                    <span class="tc-auth">${msg_home_plan_author}</span>
                                                    <c:if test="${not empty plan.destination}">
                                                        <span class="tc-dest">&#128205; ${plan.destination}</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<!-- ===== 커뮤니티 미리보기 섹션 ===== -->
<section class="cs">
    <div class="si">
        <div class="sh">
            <h2 class="st">${msg_home_community_title}</h2>
            <button class="vm" onclick="location.href='${pageContext.request.contextPath}/community/list'">${msg_home_more} &#8594;</button>
        </div>
        <div id="communitySection">
            <c:choose>
                <c:when test="${empty popularPosts}">
                    <div style="padding:40px;text-align:center;color:var(--gray-400);">${msg_home_empty_posts}</div>
                </c:when>
                <c:otherwise>
                    <div class="home-grid">
                        <c:forEach var="post" items="${popularPosts}">
                            <c:set var="isBlocked" value="${post.postStatus == 'BLOCKED' or post.accountStatus == 'BLOCKED'}"/>
                                    <c:set var="isReportOrAi" value="${post.reportCount >= reportThreshold or post.aiFlagged}"/>
                                    <c:if test="${not isBlocked or isReportOrAi or isAdminMode}">
                                        <c:set var="isReportBlur" value="${isReportOrAi and not isAdminMode}"/>
                                        <c:set var="wrapClass" value="cc-wrap"/>
                                        <c:if test="${isReportBlur}"><c:set var="wrapClass" value="${wrapClass} report-blurred-wrap"/></c:if>
                                        <div class="${wrapClass}" data-id="${post.postId}">
                                            <c:set var="cardClass" value="cc"/>
                                            <c:if test="${isReportBlur}"><c:set var="cardClass" value="${cardClass} report-blurred"/></c:if>
                                            <div class="${cardClass}">
                                                <div class="cc-iw">
                                                    <c:choose>
                                                        <c:when test="${not empty post.thumbUrl and fn:startsWith(post.thumbUrl, 'http')}">
                                                            <img class="cc-img" src="${post.thumbUrl}" alt="${post.title}">
                                                        </c:when>
                                                        <c:when test="${not empty post.thumbUrl}">
                                                            <img class="cc-img" src="${pageContext.request.contextPath}${post.thumbUrl}" alt="${post.title}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="cc-img" style="background:var(--gray-100);display:flex;align-items:center;justify-content:center;font-size:40px;">&#9992;</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <span class="cc-badge cc-badge-${post.postType}">
                                                        <c:choose>
                                                            <c:when test="${post.postType == 'review'}">${msg_home_postType_review}</c:when>
                                                            <c:when test="${post.postType == 'photo'}">${msg_home_postType_photo}</c:when>
                                                            <c:when test="${post.postType == 'tip'}">${msg_home_postType_tip}</c:when>
                                                            <c:when test="${post.postType == 'question'}">${msg_home_postType_question}</c:when>
                                                            <c:otherwise>${post.postType}</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <div class="cc-b">
                                                    <div class="cc-title">${post.title}</div>
                                                    <div class="cc-foot">
                                                        <div class="cc-auth">
                                                            <div class="cc-av">${fn:substring(post.nickname, 0, 1)}</div>
                                                            <div>
                                                                <div class="cc-an">${post.nickname}</div>
                                                                <div class="cc-dt"><fmt:formatDate value="${post.createdAtDate}" pattern="yyyy.MM.dd"/></div>
                                                            </div>
                                                        </div>
                                                        <div class="cc-stats">
                                                            <span>&#10084; ${post.likeCount}</span>
                                                            <span>&#128172; ${post.commentCount}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:if test="${isReportBlur}">
                                                <div class="report-blurred-overlay" onclick="removeReportBlur(this)">
                                                    <c:choose>
                                                        <c:when test="${post.aiFlagged}">${msg_community_blocked_ai}</c:when>
                                                        <c:otherwise>${msg_community_blocked_report}</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:if>
                                            <c:if test="${isAdminMode}">
                                                <c:choose>
                                                    <c:when test="${post.aiFlagged}">
                                                        <span class="blocked-badge">${msg_community_badge_ai}</span>
                                                    </c:when>
                                                    <c:when test="${post.postStatus == 'BLOCKED' and post.reportCount >= reportThreshold}">
                                                        <span class="blocked-badge">${msg_home_blocked_report}</span>
                                                    </c:when>
                                                    <c:when test="${post.postStatus == 'BLOCKED'}">
                                                        <span class="blocked-badge">${msg_home_blocked_post}</span>
                                                    </c:when>
                                                    <c:when test="${post.accountStatus == 'BLOCKED'}">
                                                        <span class="blocked-badge">${msg_home_blocked_user}</span>
                                                    </c:when>
                                                </c:choose>
                                            </c:if>
                                        </div>
                                    </c:if>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<script>
    var ctx            = '${pageContext.request.contextPath}';
    var adminMode      = ${isAdminMode};
    var fallbackImgUrl = '${fallbackImageUrl}';


    function spotImgError(img) {
        if (fallbackImgUrl) {
            img.onerror = null;
            img.src = fallbackImgUrl;
        } else {
            img.outerHTML = '<div class="dc-img-placeholder">'
                + '<span class="dc-ph-icon">&#9992;</span>'
                + '<span class="dc-ph-name">' + escHtml(img.alt) + '</span>'
                + '</div>';
        }
    }

    function escHtml(s) {
        return String(s || '').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }

    function removeReportBlur(overlay) {
        var wrap = overlay.closest('.report-blurred-wrap');
        wrap.classList.remove('report-blurred-wrap');
        overlay.previousElementSibling.classList.remove('report-blurred');
        overlay.remove();
    }

    /* ===== 인기 여행지 카드 클릭 ===== */
    var spotsSection = document.getElementById('spotsSection');
    if (spotsSection) {
        spotsSection.querySelectorAll('.cc-wrap[data-spot-id]').forEach(function (wrap) {
            wrap.style.cursor = 'pointer';
            wrap.addEventListener('click', function () {
                location.href = ctx + '/detail/' + this.getAttribute('data-spot-id');
            });
        });
    }

    /* ===== 트렌딩 코스 카드 클릭 ===== */
    var plansSection = document.getElementById('plansSection');
    if (plansSection) {
        plansSection.querySelectorAll('.cc-wrap[data-plan-id]').forEach(function (wrap) {
            wrap.style.cursor = 'pointer';
            wrap.addEventListener('click', function () {
                location.href = ctx + '/courses/detail?planId=' + this.getAttribute('data-plan-id');
            });
        });
    }

    /* ===== 추천 여행 패키지 자동 슬라이드 ===== */
    var packageTrack = document.getElementById('homePackageTrack');
    var packageSlider = document.getElementById('homePackageSlider');
    var packagePrevBtn = document.getElementById('packagePrevBtn');
    var packageNextBtn = document.getElementById('packageNextBtn');
    var packageAutoTimer = null;

    function getPackageStep() {
        if (!packageTrack) return 0;
        var firstCard = packageTrack.querySelector('.home-package-card');
        if (!firstCard) return 0;
        var gap = 24;
        return (firstCard.offsetWidth + gap) * 3;
    }

    function movePackageSlider(direction) {
        if (!packageSlider || !packageTrack) return;

        var step = getPackageStep();
        if (step <= 0) return;

        var maxScroll = packageTrack.scrollWidth - packageSlider.clientWidth;
        var nextLeft = packageSlider.scrollLeft + (step * direction);

        if (nextLeft > maxScroll - 4) {
            nextLeft = 0;
        }
        if (nextLeft < 0) {
            nextLeft = maxScroll;
        }

        packageSlider.scrollTo({
            left: nextLeft,
            behavior: 'smooth'
        });
    }

    function startPackageAutoSlide() {
        if (!packageSlider || packageAutoTimer) return;
        packageAutoTimer = window.setInterval(function () {
            movePackageSlider(1);
        }, 4500);
    }

    function stopPackageAutoSlide() {
        if (!packageAutoTimer) return;
        window.clearInterval(packageAutoTimer);
        packageAutoTimer = null;
    }

    if (packageSlider) {
        if (packagePrevBtn) {
            packagePrevBtn.addEventListener('click', function () {
                movePackageSlider(-1);
            });
        }
        if (packageNextBtn) {
            packageNextBtn.addEventListener('click', function () {
                movePackageSlider(1);
            });
        }

        packageSlider.addEventListener('mouseenter', stopPackageAutoSlide);
        packageSlider.addEventListener('mouseleave', startPackageAutoSlide);

        packageSlider.querySelectorAll('.home-package-card[data-spot-id]').forEach(function (card) {
            card.addEventListener('click', function () {
                location.href = ctx + '/detail/' + this.getAttribute('data-spot-id');
            });
            card.addEventListener('keydown', function (event) {
                if (event.key === 'Enter' || event.key === ' ') {
                    event.preventDefault();
                    location.href = ctx + '/detail/' + this.getAttribute('data-spot-id');
                }
            });
        });

        document.querySelectorAll('[data-home-package-list-url]').forEach(function (button) {
            button.addEventListener('click', function () {
                location.href = this.getAttribute('data-home-package-list-url');
            });
        });

        startPackageAutoSlide();
    }

    /* ===== 인기 여행 이야기 카드 클릭 ===== */
    var communitySection = document.getElementById('communitySection');
    if (communitySection) {
        communitySection.querySelectorAll('.cc-wrap[data-id]').forEach(function (wrap) {
            wrap.style.cursor = 'pointer';
            wrap.addEventListener('click', function () {
                location.href = ctx + '/community/' + this.getAttribute('data-id');
            });
        });
    }
</script>

<%@ include file="../common/footer.jsp" %>

</body>
</html>
