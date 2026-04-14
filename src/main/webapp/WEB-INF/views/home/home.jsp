<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageCSS" value="home/home.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<!-- ===== 히어로 섹션 ===== -->
<section class="hero">
    <div class="hero-bg"></div>
    <div class="hero-ov"></div>
    <div class="hero-c">
        <h1>세계를 탐험하세요</h1>
        <p>AI가 추천하는 완벽한 여행 계획</p>
        <div class="hero-btns">
            <button class="btn-pri" onclick="location.href='${pageContext.request.contextPath}/explore'">
                &#128205; 여행지 탐색
            </button>
            <button class="btn-sec" onclick="location.href='${pageContext.request.contextPath}/assistant'">
                &#10024; AI 추천받기
            </button>
        </div>
    </div>
</section>

<!-- ===== 피처 섹션 ===== -->
<section class="feat-sec">
    <div class="si">
        <div class="feat-grid">
            <div class="feat-card">
                <div class="feat-icon fi-b">&#10024;</div>
                <h3>AI 여행 도우미</h3>
                <p>AI가 당신의 취향에 맞는 완벽한 여행지와 일정을 추천해드립니다</p>
            </div>
            <div class="feat-card">
                <div class="feat-icon fi-p">&#128197;</div>
                <h3>일정 자동 생성</h3>
                <p>여행 기간과 선호도만 입력하면 최적의 일정이 자동으로 생성됩니다</p>
            </div>
            <div class="feat-card" style="cursor:pointer;"
                 onclick="location.href='${pageContext.request.contextPath}/community/list'">
                <div class="feat-icon fi-g">&#128172;</div>
                <h3>커뮤니티</h3>
                <p>전 세계 여행자들과 경험을 공유하고 유용한 정보를 얻으세요</p>
            </div>
        </div>
    </div>
</section>

<!-- ===== 인기 여행지 섹션 ===== -->
<section class="cs">
    <div class="si">
        <div class="sh">
            <h2 class="st">인기 여행지</h2>
            <button class="vm" onclick="location.href='${pageContext.request.contextPath}/explore'">더보기 &#8594;</button>
        </div>
        <div class="cg" id="home-dest">
            <!-- 샘플 카드 - 실제 서비스 시 서버 데이터로 대체 -->
            <div class="dc" onclick="location.href='${pageContext.request.contextPath}/detail/1'">
                <div class="dc-iw">
                    <img class="dc-img" src="https://images.unsplash.com/photo-1691929607102-5284d991921f?w=600&q=80"
                         alt="도쿄">
                </div>
                <div class="dc-b">
                    <div class="dc-top">
                        <div>
                            <div class="dc-name">도쿄</div>
                            <div class="dc-ctry">&#128205; 일본</div>
                        </div>
                        <div class="dc-rat">&#11088; 4.8 <span class="dc-rev">(2,453)</span></div>
                    </div>
                    <div class="dc-desc">전통과 현대가 공존하는 매력적인 도시</div>
                    <div class="dc-tags">
                        <span class="tag">도시 여행</span>
                        <span class="tag">문화 체험</span>
                    </div>
                </div>
            </div>

            <div class="dc" onclick="location.href='${pageContext.request.contextPath}/detail/2'">
                <div class="dc-iw">
                    <img class="dc-img" src="https://images.unsplash.com/photo-1642947392578-b37fbd9a4d45?w=600&q=80"
                         alt="파리">
                </div>
                <div class="dc-b">
                    <div class="dc-top">
                        <div>
                            <div class="dc-name">파리</div>
                            <div class="dc-ctry">&#128205; 프랑스</div>
                        </div>
                        <div class="dc-rat">&#11088; 4.9 <span class="dc-rev">(3,241)</span></div>
                    </div>
                    <div class="dc-desc">세계에서 가장 낭만적인 도시</div>
                    <div class="dc-tags">
                        <span class="tag">도시 여행</span>
                        <span class="tag">로맨틱</span>
                    </div>
                </div>
            </div>

            <div class="dc" onclick="location.href='${pageContext.request.contextPath}/detail/8'">
                <div class="dc-iw">
                    <img class="dc-img" src="https://images.unsplash.com/photo-1573481726566-9d98bb795fff?w=600&q=80"
                         alt="산토리니">
                </div>
                <div class="dc-b">
                    <div class="dc-top">
                        <div>
                            <div class="dc-name">산토리니</div>
                            <div class="dc-ctry">&#128205; 그리스</div>
                        </div>
                        <div class="dc-rat">&#11088; 4.9 <span class="dc-rev">(3,412)</span></div>
                    </div>
                    <div class="dc-desc">에게해의 보석</div>
                    <div class="dc-tags">
                        <span class="tag">해변 휴양</span>
                        <span class="tag">로맨틱</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== 트렌딩 여행 코스 섹션 ===== -->
<section class="cs bg">
    <div class="si">
        <div class="sh">
            <h2 class="st">트렌딩 여행 코스</h2>
            <button class="vm" onclick="location.href='${pageContext.request.contextPath}/courses'">더보기 &#8594;</button>
        </div>
        <div class="cg" id="home-trips">

            <div class="tc">
                <div class="tc-iw">
                    <img class="tc-img" src="https://images.unsplash.com/photo-1691929607102-5284d991921f?w=600&q=80"
                         alt="도쿄 3박4일">
                    <span class="tc-badge">3박 4일</span>
                </div>
                <div class="tc-b">
                    <div class="tc-title">도쿄 완벽 여행 코스</div>
                    <div class="tc-foot">
                        <span class="tc-auth">by TravelBug</span>
                        <span class="tc-likes">&#10084; 234</span>
                    </div>
                </div>
            </div>

            <div class="tc">
                <div class="tc-iw">
                    <img class="tc-img" src="https://images.unsplash.com/photo-1642947392578-b37fbd9a4d45?w=600&q=80"
                         alt="파리 5박6일">
                    <span class="tc-badge">5박 6일</span>
                </div>
                <div class="tc-b">
                    <div class="tc-title">파리 & 런던 유럽 핵심 코스</div>
                    <div class="tc-foot">
                        <span class="tc-auth">by EuroWanderer</span>
                        <span class="tc-likes">&#10084; 412</span>
                    </div>
                </div>
            </div>

            <div class="tc">
                <div class="tc-iw">
                    <img class="tc-img" src="https://images.unsplash.com/photo-1657788781951-d6beac09d66c?w=600&q=80"
                         alt="발리 7일">
                    <span class="tc-badge">7박 8일</span>
                </div>
                <div class="tc-b">
                    <div class="tc-title">발리 힐링 여행 코스</div>
                    <div class="tc-foot">
                        <span class="tc-auth">by IslandHopper</span>
                        <span class="tc-likes">&#10084; 189</span>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- ===== 커뮤니티 미리보기 섹션 ===== -->
<section class="cs">
    <div class="si">
        <div class="sh">
            <h2 class="st">&#128293; 오늘 인기 여행 이야기</h2>
            <button class="vm" onclick="location.href='${pageContext.request.contextPath}/community/list'">더보기 &#8594;
            </button>
        </div>
        <div id="popularSection">
            <div style="padding:40px;text-align:center;color:var(--gray-400);">불러오는 중...</div>
        </div>
    </div>
</section>

<script>
    var ctx       = '${pageContext.request.contextPath}';
    var adminMode = ${isAdminMode};

    var TYPE_LABELS = { review: '여행후기', photo: '사진', tip: '팁', question: '질문' };

    function escHtml(s) {
        return String(s || '').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }

    function buildCard(p) {
        var blocked = (p.accountStatus === 'BLOCKED' || p.postStatus === 'BLOCKED');
        if (blocked && !adminMode) return '';

        var isReportBlur = p.reportCount >= 3 && p.postStatus === 'BLOCKED' && !adminMode;
        var imgHtml = p.thumbUrl
            ? '<img class="cc-img" src="' + escHtml(p.thumbUrl.startsWith('http') ? p.thumbUrl : ctx + p.thumbUrl) + '" alt="' + escHtml(p.title) + '">'
            : '<div class="cc-img" style="background:var(--gray-100);display:flex;align-items:center;justify-content:center;font-size:40px;">✈️</div>';

        var dateStr = p.createdAt ? p.createdAt.substring(0, 10).replace(/-/g, '.') : '';
        var badge   = adminMode
            ? (p.postStatus === 'BLOCKED' && p.reportCount >= 3 ? '<span class="blocked-badge">🚨 신고에 의해 차단됨</span>'
             : p.postStatus === 'BLOCKED'                       ? '<span class="blocked-badge">🚫 차단된 게시글</span>'
             : p.accountStatus === 'BLOCKED'                    ? '<span class="blocked-badge">🚫 차단된 유저</span>' : '') : '';
        var blurOverlay = isReportBlur
            ? '<div class="report-blurred-overlay" onclick="removeReportBlur(this)">⚠️ 신고된 콘텐츠입니다. 클릭하여 확인</div>' : '';

        return '<div class="cc-wrap' + (isReportBlur ? ' report-blurred-wrap' : '') + '" data-id="' + p.postId + '" style="cursor:pointer;">'
             + '  <div class="cc' + (isReportBlur ? ' report-blurred' : '') + '">'
             + '    <div class="cc-iw">' + imgHtml
             + '      <span class="cc-badge">' + escHtml(TYPE_LABELS[p.postType] || p.postType) + '</span>'
             + '    </div>'
             + '    <div class="cc-b">'
             + '      <div class="cc-title">' + escHtml(p.title) + '</div>'
             + '      <div class="cc-foot">'
             + '        <div class="cc-auth"><div class="cc-av">' + escHtml((p.nickname || '?').charAt(0)) + '</div>'
             + '          <div><div class="cc-an">' + escHtml(p.nickname) + '</div><div class="cc-dt">' + dateStr + '</div></div>'
             + '        </div>'
             + '        <div class="cc-stats"><span>❤ ' + (p.likeCount||0) + '</span><span>💬 ' + (p.commentCount||0) + '</span></div>'
             + '      </div>'
             + '    </div>'
             + '  </div>'
             + blurOverlay + badge
             + '</div>';
    }

    function removeReportBlur(overlay) {
        var wrap = overlay.closest('.report-blurred-wrap');
        wrap.classList.remove('report-blurred-wrap');
        overlay.previousElementSibling.classList.remove('report-blurred');
        overlay.remove();
    }

    function initCarousel(section) {
        var track   = section.querySelector('#homeCarouselTrack');
        var prevBtn = section.querySelector('#homeCarouselPrev');
        var nextBtn = section.querySelector('#homeCarouselNext');
        if (!track || !track.children.length) return;

        track.querySelectorAll('.cc-wrap[data-id]').forEach(function (wrap) {
            wrap.addEventListener('click', function () {
                location.href = ctx + '/community/' + this.getAttribute('data-id');
            });
        });

        var cards   = track.children;
        var total   = cards.length;
        var visible = 4;
        var gap     = 24;
        var current = 0;
        var autoTimer;

        function setCardWidths() {
            var vpWidth = track.parentElement.offsetWidth;
            if (!vpWidth) return;
            var w = (vpWidth - gap * (visible - 1)) / visible;
            Array.from(cards).forEach(function (wrap) {
                wrap.style.width = w + 'px';
                var inner = wrap.querySelector('.cc');
                if (inner) inner.style.width = w + 'px';
            });
            track.style.gap = gap + 'px';
        }

        function cardStep() { return cards[0].getBoundingClientRect().width + gap; }

        function goTo(idx) {
            current = Math.max(0, Math.min(idx, total - visible));
            track.style.transform = 'translateX(-' + (current * cardStep()) + 'px)';
        }

        function next() {
            if (current >= total - visible) {
                track.style.transition = 'none'; current = 0;
                track.style.transform = 'translateX(0)';
                track.getBoundingClientRect(); track.style.transition = '';
            } else { goTo(current + 1); }
        }

        function prev() {
            if (current <= 0) {
                track.style.transition = 'none'; current = total - visible;
                track.style.transform = 'translateX(-' + (current * cardStep()) + 'px)';
                track.getBoundingClientRect(); track.style.transition = '';
            } else { goTo(current - 1); }
        }

        function startAuto() { autoTimer = setInterval(next, 2500); }
        function stopAuto()  { clearInterval(autoTimer); }

        nextBtn.addEventListener('click', function () { stopAuto(); next(); startAuto(); });
        prevBtn.addEventListener('click', function () { stopAuto(); prev(); startAuto(); });
        window.addEventListener('resize', function () { stopAuto(); setCardWidths(); goTo(current); startAuto(); });

        setCardWidths();
        startAuto();
    }

    /* ===== 인기글 AJAX 로드 ===== */
    fetch(ctx + '/community/api/popular')
        .then(function (res) { return res.json(); })
        .then(function (posts) {
            var section = document.getElementById('popularSection');
            if (!posts || posts.length === 0) {
                section.innerHTML = '<div style="padding:40px;text-align:center;color:var(--gray-400);">아직 게시글이 없습니다</div>';
                return;
            }
            var cards = posts.map(buildCard).join('');
            section.innerHTML =
                '<div class="comm-g-outer">'
              + '  <button class="comm-g-btn comm-g-prev" id="homeCarouselPrev">&#8249;</button>'
              + '  <div class="comm-g-vp"><div class="comm-g-track" id="homeCarouselTrack">' + cards + '</div></div>'
              + '  <button class="comm-g-btn comm-g-next" id="homeCarouselNext">&#8250;</button>'
              + '</div>';
            initCarousel(section);
        })
        .catch(function () {
            document.getElementById('popularSection').innerHTML =
                '<div style="padding:40px;text-align:center;color:var(--gray-400);">불러오기 실패</div>';
        });
</script>

<%@ include file="../common/footer.jsp" %>

</body>
</html>
