<header>
    <div class="hi">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/'">
            <div class="logo-icon">🌎</div>
            <span class="logo-text">TripTogether</span>
        </div>
        <nav>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/explore'">여행지 탐색</button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/courses'">여행 코스</button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/assistant'">AI 도우미</button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/community/list'">커뮤니티</button>
            <button class="nb" onclick="location.href='${pageContext.request.contextPath}/mypage'">마이페이지</button>
        </nav>
        <div class="hr">
            <label>
                <select class="lang-sel">
                    <option value="ko">한국어</option>
                    <option value="en">English</option>
                    <option value="ja">日本語</option>
                    <option value="zh">中文</option>
                </select>
            </label>
            <button class="btn-out" onclick="location.href='${pageContext.request.contextPath}/auth/login'">로그인</button>
        </div>
    </div>
</header>