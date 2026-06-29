/* =====================================================================
 * TripTogether 데모 레이어 (정적 GitHub Pages, 백엔드 없음)
 *  - 데모 모드 배너 / 안내 토스트
 *  - 폼·fetch·XHR·서버링크 가로채기
 *  - ★ 데모 인증 시뮬레이션:
 *      · 기본 = 로그아웃 상태
 *      · 6개 목 계정(카카오·네이버·구글·이메일·아이디 일반 + 아이디 관리자)
 *      · 페이지 로드 시 헤더/관리자 크롬을 현재 계정에 맞게 동적 재작성
 *      · 관리자 페이지 게이트 / 로그인 필요 페이지 소프트 게이트
 *      · 로그인 페이지에 데모 계정 선택 패널 주입
 * 이 파일은 모든 스냅샷 HTML에 주입된다.
 * ===================================================================== */
(function () {
  'use strict';

  var BASE  = window.__DEMO_BASE__ || '';
  var HOME  = BASE + 'index.html';
  var LOGIN = BASE + 'auth/login.html';
  var ADMIN = BASE + 'admin.html';
  var SKEY  = 'tt.demo.account';

  // ---------- 목 계정 ----------
  var ACCOUNTS = {
    kakao:  { key: 'kakao',  method: '카카오', nick: '카카오여행가', role: 'USER',  cred: '카카오 간편 로그인' },
    naver:  { key: 'naver',  method: '네이버', nick: '네이버여행러', role: 'USER',  cred: '네이버 간편 로그인' },
    google: { key: 'google', method: '구글',   nick: '구글트래블러', role: 'USER',  cred: '구글 간편 로그인' },
    email:  { key: 'email',  method: '이메일', nick: '이메일여행가', role: 'USER',  cred: 'user@test.com / 1234' },
    id:     { key: 'id',     method: '아이디', nick: '여행가김철수', role: 'USER',  cred: 'user / 1234' },
    admin:  { key: 'admin',  method: '아이디', nick: '최고관리자',   role: 'ADMIN', cred: 'admin / 1234' }
  };
  var ORDER = ['kakao', 'naver', 'google', 'email', 'id', 'admin'];

  function getAcct() { try { return ACCOUNTS[sessionStorage.getItem(SKEY)] || null; } catch (e) { return null; } }
  function setAcct(k) { try { sessionStorage.setItem(SKEY, k); } catch (e) {} }
  function clearAcct() { try { sessionStorage.removeItem(SKEY); } catch (e) {} }
  function login(k) { setAcct(k); location.href = (ACCOUNTS[k] && ACCOUNTS[k].role === 'ADMIN') ? ADMIN : HOME; }
  function logout() { clearAcct(); location.href = HOME; }
  window.__demoLogin = login;
  window.__demoLogout = logout;

  // 딥링크: ?demoacct=admin 으로 접속 시 해당 계정으로 자동 로그인 (공유/캡처용)
  function applyDeepLink() {
    try {
      var m = /[?&]demoacct=([a-zA-Z]+)/.exec(location.search);
      if (m && ACCOUNTS[m[1].toLowerCase()]) {
        setAcct(m[1].toLowerCase());
        var qs = location.search.replace(/([?&])demoacct=[a-zA-Z]+/, '$1').replace(/[?&]+$/, '').replace(/[?&]&/, '?');
        history.replaceState(null, '', location.pathname + qs + location.hash);
      }
    } catch (e) {}
  }
  // ★ 동기 즉시 실행: 페이지 스크립트가 DOMContentLoaded에서 URL을 바꿔
  //   demoacct 파라미터를 지우기 전에 계정을 먼저 설정해야 한다.
  applyDeepLink();

  // ---------- history 가로채기 ----------
  // 정적 데모인데 페이지 스크립트가 history.replaceState/pushState로 URL을
  // 서버 컨텍스트(/TripTogether/...)로 바꿔 주소창을 오염시키고 새로고침 시 404를 유발한다.
  // /TripTogether/ 절대경로로의 history 변경은 무시한다. ('/TripTogetherPortfolio/'는 영향 없음)
  try {
    var _rs = history.replaceState, _ps = history.pushState;
    history.replaceState = function (s, t, u) {
      if (typeof u === 'string' && /\/TripTogether\//.test(u)) return;
      return _rs.apply(history, arguments);
    };
    history.pushState = function (s, t, u) {
      if (typeof u === 'string' && /\/TripTogether\//.test(u)) return;
      return _ps.apply(history, arguments);
    };
  } catch (e) {}

  // ---------- 스타일 주입 ----------
  function injectStyles() {
    if (document.getElementById('tt-demo-style')) return;
    var s = document.createElement('style');
    s.id = 'tt-demo-style';
    s.textContent =
      '#demo-banner{position:relative;z-index:99999;background:linear-gradient(90deg,#2563eb,#0ea5e9);color:#fff;font-size:13px;line-height:1.5;padding:7px 14px;text-align:center;font-family:system-ui,sans-serif;letter-spacing:-.2px}' +
      '.tt-demo-badge{display:inline-block;margin-left:6px;padding:1px 7px;border-radius:999px;background:#0ea5a4;color:#fff;font-size:11px;font-weight:600;vertical-align:middle;font-family:system-ui,sans-serif}' +
      '.tt-demo-badge.admin{background:#dc2626}' +
      '.tt-admin-entry{margin-left:8px;padding:6px 12px;border:0;border-radius:8px;background:#dc2626;color:#fff;font-size:13px;font-weight:600;cursor:pointer;font-family:system-ui,sans-serif}' +
      '.tt-gate{position:fixed;inset:0;z-index:100001;background:rgba(15,23,42,.78);backdrop-filter:blur(3px);display:flex;align-items:center;justify-content:center;padding:20px;font-family:system-ui,sans-serif}' +
      '.tt-gate-card{background:#fff;color:#0f172a;max-width:380px;width:100%;border-radius:16px;padding:28px 24px;text-align:center;box-shadow:0 20px 60px rgba(0,0,0,.35)}' +
      '.tt-gate-card .ic{font-size:34px}' +
      '.tt-gate-card h3{margin:10px 0 6px;font-size:19px}' +
      '.tt-gate-card p{margin:0 0 18px;font-size:14px;color:#475569;line-height:1.5}' +
      '.tt-gate-card .cred{display:inline-block;margin:0 0 16px;padding:6px 12px;border-radius:8px;background:#f1f5f9;font-size:13px;color:#0f172a;font-weight:600}' +
      '.tt-gate-btn{display:block;width:100%;margin:8px 0;padding:11px;border:0;border-radius:10px;font-size:14px;font-weight:600;cursor:pointer;background:#e2e8f0;color:#0f172a}' +
      '.tt-gate-btn.primary{background:#dc2626;color:#fff}' +
      '.tt-gate-btn.alt{background:#2563eb;color:#fff}' +
      '.tt-demo-picker{max-width:420px;margin:18px auto;padding:16px;border:1px dashed #94a3b8;border-radius:14px;background:#f8fafc;font-family:system-ui,sans-serif}' +
      '.tt-demo-picker h4{margin:0 0 4px;font-size:15px;color:#0f172a}' +
      '.tt-demo-picker .sub{margin:0 0 12px;font-size:12px;color:#64748b}' +
      '.tt-demo-picker .grid{display:grid;grid-template-columns:1fr 1fr;gap:8px}' +
      '.tt-acct-btn{display:flex;flex-direction:column;align-items:flex-start;gap:2px;padding:9px 11px;border:1px solid #cbd5e1;border-radius:10px;background:#fff;cursor:pointer;text-align:left}' +
      '.tt-acct-btn:hover{border-color:#0ea5a4;box-shadow:0 2px 8px rgba(14,165,164,.18)}' +
      '.tt-acct-btn.admin{grid-column:1 / -1;border-color:#fecaca;background:#fef2f2}' +
      '.tt-acct-btn .m{font-size:13px;font-weight:700;color:#0f172a}' +
      '.tt-acct-btn .c{font-size:11px;color:#64748b}' +
      '.tt-acct-btn.admin .m{color:#dc2626}' +
      // 페이징 정렬 강제(좌하단 세로로 깨지는 문제 교정 — 정보 좌측 / 이전·다음 우측)
      '.adm-section-list-footer{display:flex !important;align-items:center;justify-content:space-between;gap:12px;flex-wrap:nowrap}' +
      '.adm-section-list-footer.tt-deduped-footer{display:none !important}' +
      '.adm-section-list-footer .adm-section-list-page-tools{display:flex !important;flex-direction:row !important;align-items:center;gap:6px;margin-left:auto}' +
      '.adm-local-pagination{display:flex !important;flex-direction:row !important;align-items:center;justify-content:space-between;gap:12px;flex-wrap:nowrap;padding:10px 16px 12px;width:100%}' +
      '.adm-local-pagination .adm-local-page-info{font-size:12px;color:#94a3b8;white-space:nowrap}' +
      '.adm-local-pagination .adm-local-page-actions{display:flex !important;flex-direction:row !important;align-items:center;gap:6px;margin-left:auto}' +
      // 데모 배너 닫기(X) 버튼
      '#demo-banner{padding-right:40px}' +
      '#demo-banner .tt-banner-x{position:absolute;right:8px;top:50%;transform:translateY(-50%);width:22px;height:22px;border:0;border-radius:50%;background:rgba(255,255,255,.22);color:#fff;font-size:12px;line-height:1;cursor:pointer;display:flex;align-items:center;justify-content:center;padding:0}' +
      '#demo-banner .tt-banner-x:hover{background:rgba(255,255,255,.4)}';
    (document.head || document.documentElement).appendChild(s);
  }

  // ---------- 배너 ----------
  function injectBanner() {
    try { if (sessionStorage.getItem('tt.demo.bannerClosed') === '1') return; } catch (e) {}
    if (document.getElementById('demo-banner')) return;
    var bar = document.createElement('div');
    bar.id = 'demo-banner';
    bar.innerHTML = '<span class="tt-banner-msg">🧭 <b>TripTogether 데모</b> — 둘러보기용 화면입니다. 저장·결제는 동작하지 않으며 로그인은 가상 계정으로 시뮬레이션됩니다.</span>' +
      '<button type="button" class="tt-banner-x" aria-label="배너 닫기" title="이 세션 동안 숨기기">✕</button>';
    if (document.body) document.body.insertBefore(bar, document.body.firstChild);
    var x = bar.querySelector('.tt-banner-x');
    if (x) x.addEventListener('click', function () {
      try { sessionStorage.setItem('tt.demo.bannerClosed', '1'); } catch (e) {}
      bar.parentNode && bar.parentNode.removeChild(bar);
    });
  }

  // ---------- 토스트 ----------
  var toastTimer;
  function toast(msg) {
    var t = document.getElementById('demo-toast');
    if (!t) {
      t = document.createElement('div');
      t.id = 'demo-toast';
      t.style.cssText = 'position:fixed;left:50%;bottom:32px;transform:translateX(-50%);z-index:100000;' +
        'background:rgba(17,24,39,.95);color:#fff;padding:12px 20px;border-radius:10px;font-size:14px;' +
        'font-family:system-ui,sans-serif;box-shadow:0 8px 24px rgba(0,0,0,.25);opacity:0;transition:opacity .2s;max-width:88vw';
      document.body.appendChild(t);
    }
    t.textContent = msg;
    t.style.opacity = '1';
    clearTimeout(toastTimer);
    toastTimer = setTimeout(function () { t.style.opacity = '0'; }, 2600);
  }
  window.__demoToast = toast;

  // ---------- 게이트 오버레이 ----------
  function showGate(opts) {
    var ov = document.createElement('div');
    ov.className = 'tt-gate';
    var card = document.createElement('div');
    card.className = 'tt-gate-card';
    var html = '<div class="ic">' + (opts.icon || '🔐') + '</div><h3>' + opts.title + '</h3><p>' + opts.msg + '</p>';
    if (opts.cred) html += '<div class="cred">' + opts.cred + '</div>';
    card.innerHTML = html;
    (opts.buttons || []).forEach(function (b) {
      var btn = document.createElement('button');
      btn.className = 'tt-gate-btn' + (b.cls ? ' ' + b.cls : '');
      btn.textContent = b.label;
      btn.addEventListener('click', b.onClick);
      card.appendChild(btn);
    });
    ov.appendChild(card);
    document.body.appendChild(ov);
    try { document.body.style.overflow = 'hidden'; } catch (e) {}
  }

  // ---------- 헤더 재작성 (일반 페이지) ----------
  function rewriteUserHeader() {
    var hr = document.querySelector('header .hr');
    if (!hr) return;
    var acct = getAcct();
    var nickEl = hr.querySelector('.user-nick');
    var outBtn = hr.querySelector('.btn-out');
    var noti = hr.querySelector('.noti-wrap');
    // 마이페이지 내비 버튼
    var myNav = null;
    Array.prototype.forEach.call(document.querySelectorAll('#primaryNav .nb'), function (b) {
      if (/mypage\.html/.test(b.getAttribute('onclick') || '')) myNav = b;
    });

    if (!acct) {
      // 로그아웃 상태
      if (noti) noti.style.display = 'none';
      if (nickEl) nickEl.style.display = 'none';
      if (myNav) myNav.style.display = 'none';
      if (outBtn) {
        outBtn.textContent = '로그인';
        outBtn.onclick = function () { location.href = LOGIN; };
        if (!hr.querySelector('.tt-join')) {
          var join = document.createElement('button');
          join.className = 'btn-out tt-join';
          join.textContent = '회원가입';
          join.style.marginLeft = '6px';
          join.onclick = function () { location.href = BASE + 'auth/register.html'; };
          outBtn.parentNode.insertBefore(join, outBtn.nextSibling);
        }
      }
      return;
    }

    // 로그인 상태
    if (noti) noti.style.display = '';
    if (myNav) myNav.style.display = '';
    if (nickEl) {
      nickEl.style.display = '';
      nickEl.textContent = acct.nick;
      var badge = document.createElement('span');
      badge.className = 'tt-demo-badge' + (acct.role === 'ADMIN' ? ' admin' : '');
      badge.textContent = acct.role === 'ADMIN' ? '관리자' : acct.method;
      nickEl.appendChild(badge);
    }
    if (outBtn) { outBtn.textContent = '로그아웃'; outBtn.onclick = function () { logout(); }; }
    // 관리자 계정이면 헤더에 관리자 진입 버튼
    if (acct.role === 'ADMIN' && outBtn && !hr.querySelector('.tt-admin-entry')) {
      var ab = document.createElement('button');
      ab.className = 'tt-admin-entry';
      ab.textContent = '🛠 관리자';
      ab.onclick = function () { location.href = ADMIN; };
      outBtn.parentNode.insertBefore(ab, outBtn);
    }
  }

  // ---------- 관리자 크롬 처리 ----------
  function handleAdminChrome() {
    var sidebar = document.querySelector('.adm-sidebar');
    if (!sidebar) return false;
    var acct = getAcct();
    if (!acct || acct.role !== 'ADMIN') {
      showGate({
        icon: '🔐',
        title: '관리자 데모',
        msg: '관리자 계정으로 로그인해야 볼 수 있는 화면입니다.',
        cred: '관리자 계정 — admin / 1234',
        buttons: [
          { label: '관리자로 보기', cls: 'primary', onClick: function () { setAcct('admin'); location.reload(); } },
          { label: '로그인 페이지로 이동', cls: 'alt', onClick: function () { clearAcct(); location.href = LOGIN; } },
          { label: '홈으로', onClick: function () { location.href = HOME; } }
        ]
      });
      return true;
    }
    // 관리자 로그인 상태 → 사이드바 사용자 정보·로그아웃 연결
    var nameEl = sidebar.querySelector('.adm-user-name');
    if (nameEl) nameEl.textContent = acct.nick;
    var outA = sidebar.querySelector('.adm-logout');
    if (outA) { outA.removeAttribute('href'); outA.style.cursor = 'pointer'; outA.onclick = function (e) { e.preventDefault(); logout(); }; }
    return true;
  }

  // ---------- 로그인 필요 페이지 소프트 게이트 ----------
  var LOGIN_REQUIRED = /(mypage|wallet|inquiry|courses\/(my|write|edit)|packages\/manage|security\/appeal)/i;
  function handleLoginRequired() {
    if (getAcct()) return false;
    var p = location.pathname;
    if (!LOGIN_REQUIRED.test(p)) return false;
    if (/auth\//.test(p)) return false;
    showGate({
      icon: '🔑',
      title: '로그인이 필요합니다',
      msg: '이 화면은 로그인한 사용자만 이용할 수 있습니다. 데모 계정으로 로그인해 보세요.',
      buttons: [
        { label: '로그인', cls: 'alt', onClick: function () { location.href = LOGIN; } },
        { label: '홈으로', onClick: function () { location.href = HOME; } }
      ]
    });
    return true;
  }

  // ---------- 로그인 페이지: 데모 계정 선택 패널 ----------
  function enhanceLoginPage() {
    var form = document.getElementById('loginForm');
    var social = document.querySelector('.social-btns');
    if (!form && !social) return;

    if (!document.querySelector('.tt-demo-picker')) {
      var box = document.createElement('div');
      box.className = 'tt-demo-picker';
      var html = '<h4>🧪 데모 계정으로 로그인</h4><p class="sub">아래에서 바로 선택하거나, 폼/소셜 버튼을 사용해도 됩니다.</p><div class="grid">';
      ORDER.forEach(function (k) {
        var a = ACCOUNTS[k];
        html += '<button type="button" class="tt-acct-btn' + (a.role === 'ADMIN' ? ' admin' : '') + '" data-acct="' + k + '">' +
          '<span class="m">' + (a.role === 'ADMIN' ? '🛠 관리자(아이디)' : a.method) + '</span>' +
          '<span class="c">' + a.nick + ' · ' + a.cred + '</span></button>';
      });
      html += '</div>';
      box.innerHTML = html;
      var anchor = social || form;
      anchor.parentNode.insertBefore(box, anchor);
      box.addEventListener('click', function (e) {
        var b = e.target.closest('.tt-acct-btn');
        if (b) login(b.getAttribute('data-acct'));
      });
    }

    // 기존 소셜 버튼 연결
    var map = { kakao: 'kakao', naver: 'naver', google: 'google' };
    Object.keys(map).forEach(function (cls) {
      var el = document.querySelector('.social-btn.' + cls);
      if (el) el.onclick = function (e) { e.preventDefault(); login(map[cls]); return false; };
    });
    window.demoSocial = function () { return false; };
  }

  function acctFromIdentifier(v) {
    v = (v || '').trim().toLowerCase();
    if (v === 'admin') return 'admin';
    if (v.indexOf('@') >= 0) return 'email';
    return 'id';
  }

  // ---------- 폼 제출 가로채기 ----------
  function isLoginForm(form) {
    return !!form.querySelector('input[name="identifier"], input[name="password"]') &&
           /login|auth/i.test((form.getAttribute('action') || '') + location.pathname);
  }
  document.addEventListener('submit', function (e) {
    var form = e.target;
    e.preventDefault();
    e.stopPropagation();
    if (isLoginForm(form)) {
      var idf = form.querySelector('input[name="identifier"]');
      login(acctFromIdentifier(idf && idf.value));
    } else {
      toast('데모 모드에서는 저장·전송이 지원되지 않습니다.');
    }
    return false;
  }, true);

  // ---------- fetch 가로채기 ----------
  var _fetch = window.fetch;
  window.fetch = function (input) {
    var url = (typeof input === 'string') ? input : (input && input.url) || '';
    if (/\/TripTogether\//.test(url) || /^\/(?!\/)/.test(url)) {
      return Promise.resolve(new Response(JSON.stringify({ demo: true, message: '데모 모드', data: [], list: [], content: [] }), {
        status: 200, headers: { 'Content-Type': 'application/json' }
      }));
    }
    return _fetch.apply(this, arguments);
  };

  // ---------- XHR 가로채기 ----------
  var _open = XMLHttpRequest.prototype.open;
  var _send = XMLHttpRequest.prototype.send;
  XMLHttpRequest.prototype.open = function (m, url) { this.__demoUrl = url || ''; return _open.apply(this, arguments); };
  XMLHttpRequest.prototype.send = function () {
    var u = this.__demoUrl || '';
    if (/\/TripTogether\//.test(u) || /^\/(?!\/)/.test(u)) {
      var self = this;
      setTimeout(function () {
        Object.defineProperty(self, 'readyState', { value: 4, configurable: true });
        Object.defineProperty(self, 'status', { value: 200, configurable: true });
        Object.defineProperty(self, 'responseText', { value: '{"demo":true,"data":[],"list":[]}', configurable: true });
        Object.defineProperty(self, 'response', { value: '{"demo":true,"data":[],"list":[]}', configurable: true });
        if (typeof self.onreadystatechange === 'function') self.onreadystatechange();
        if (typeof self.onload === 'function') self.onload();
      }, 50);
      return;
    }
    return _send.apply(this, arguments);
  };

  // ---------- 서버(/TripTogether/) 링크 → 정적 페이지 매핑 ----------
  // 정적 데모이므로 /TripTogether/* 절대경로 링크는 404가 난다.
  // 존재하는 정적 파일이면 그 경로로 재작성하고, 없으면 안내 토스트로 막아 404를 원천 차단한다.
  var PAGES = new Set(['admin.html','admin/activity-logs.html','admin/ads.html','admin/ads/1/edit.html','admin/ads/new.html','admin/ai-helper.html','admin/ai-helper/chatbot.html','admin/blocks.html','admin/blocks/api/batches/1/detail.html','admin/blocks/api/batches/fragment.html','admin/blocks/api/histories/1/detail.html','admin/blocks/api/histories/fragment.html','admin/blocks/api/ip-rules/1/detail.html','admin/blocks/api/ip-rules/fragment.html','admin/blocks/api/user-blocks/1/detail.html','admin/blocks/api/user-blocks/fragment.html','admin/business-applications.html','admin/business-applications/fragment.html','admin/community.html','admin/community/comments.html','admin/community/posts/1.html','admin/courses.html','admin/courses/1.html','admin/email-tokens.html','admin/email-verifications.html','admin/explore.html','admin/explore/reviews.html','admin/explore/spots/1.html','admin/finance.html','admin/finance/policy.html','admin/finance/refund.html','admin/finance/users/4.html','admin/initial-settings.html','admin/inquiries.html','admin/inquiries/1.html','admin/login-risk/appeal-policy.html','admin/login-risk/appeals.html','admin/login-risk/assessments.html','admin/login-risk/notification-preferences.html','admin/login-risk/policies.html','admin/login-risk/provider-configs.html','admin/login-risk/provider-health-history.html','admin/login-risk/reviews.html','admin/login-risk/security-assessments.html','admin/login-risk/security-reviews.html','admin/login-risk/waf-sync.html','admin/logins.html','admin/logins/fragment.html','admin/members.html','admin/members/fragment.html','admin/moderation.html','admin/packages.html','admin/policies.html','admin/policy-history.html','admin/reports.html','admin/reports/1.html','admin/runtime-settings.html','admin/security.html','admin/security/fragment.html','assistant.html','auth/find-id.html','auth/find-pw.html','auth/login.html','auth/register.html','auth/social/complete.html','blocked-access.html','community/1.html','community/1/comments.html','community/12.html','community/edit/1.html','community/list.html','community/write.html','courses.html','courses/ai/form.html','courses/detail.html','courses/edit.html','courses/my.html','courses/public.html','courses/write.html','detail/1.html','detail/10.html','explore.html','index.html','inquiry/1.html','inquiry/8.html','inquiry/list.html','inquiry/write.html','mypage.html','mypage/bookings/flights.html','mypage/bookings/packages.html','mypage/edit-confirm.html','mypage/edit.html','mypage/history.html','packages.html','packages/manage.html','packages/manage/1/edit.html','packages/manage/write.html','report/1.html','report/list.html','security/appeal.html','security/appeal/new.html','security/appeal/result.html','shop.html','superAdmin/groups.html','superAdmin/members.html','superAdmin/members/2/edit.html','superAdmin/org.html','superAdmin/permission-codes.html','superAdmin/permissions.html','superAdmin/salary.html','superAdmin/stats.html','wallet.html']);
  var PATHMAP = { 'superAdmin': 'superAdmin/members.html' };
  function toStatic(href) {
    var raw = String(href || '').replace(/^\/TripTogether\/?/, '');
    var path = raw.split('#')[0].split('?')[0].replace(/\/+$/, '');
    if (/^auth\/logout/.test(path)) return '__logout__';
    if (path === '') return 'index.html';
    if (PATHMAP[path]) return PATHMAP[path];
    var cand = /\.html$/.test(path) ? path : path + '.html';
    if (PAGES.has(cand)) return cand;
    if (PAGES.has(path + '/index.html')) return path + '/index.html';
    // 상세 페이지 샘플 폴백 (데모엔 대표 1건만 스냅샷 — 404 대신 대표 상세로)
    var SAMPLE = [
      [/^admin\/community\/posts\/\d+/, 'admin/community/posts/1.html'],
      [/^admin\/courses\/\d+/, 'admin/courses/1.html'],
      [/^admin\/explore\/spots\/\d+/, 'admin/explore/spots/1.html'],
      [/^admin\/inquiries\/\d+/, 'admin/inquiries/1.html'],
      [/^admin\/reports\/\d+/, 'admin/reports/1.html'],
      [/^admin\/finance\/users\/\d+/, 'admin/finance/users/4.html'],
      [/^superAdmin\/members\/\d+\/edit/, 'superAdmin/members/2/edit.html'],
      [/^community\/\d+/, 'community/1.html'],
      [/^inquiry\/\d+/, 'inquiry/1.html'],
      [/^detail\/\d+/, 'detail/1.html']
    ];
    for (var i = 0; i < SAMPLE.length; i++) { if (SAMPLE[i][0].test(path)) return SAMPLE[i][1]; }
    return null; // 데모에 없는 페이지
  }
  // 로드 시 + 동적 추가 시: /TripTogether 절대 링크를 정적 경로로 재작성(없으면 표식)
  function rewriteServerLinks(root) {
    var as = (root || document).querySelectorAll('a[href^="/TripTogether"]');
    Array.prototype.forEach.call(as, function (a) {
      if (a.__ttDone) return; a.__ttDone = true;
      var t = toStatic(a.getAttribute('href') || '');
      if (t === '__logout__') { a.setAttribute('href', '#'); a.dataset.ttAction = 'logout'; }
      else if (t) { a.setAttribute('href', BASE + t); a.removeAttribute('target'); }
      else { a.setAttribute('href', '#'); a.dataset.ttAction = 'missing'; }
    });
  }
  // 페이징 중복 제거: 공유 footer + 로컬 페이징이 둘 다 있으면 기능형 로컬만 남기고 공유 footer 숨김
  function dedupePagination() {
    try {
      if (document.querySelector('.adm-local-pagination') && document.querySelector('.adm-section-list-footer')) {
        Array.prototype.forEach.call(document.querySelectorAll('.adm-section-list-footer'), function (el) {
          el.classList.add('tt-deduped-footer');
          el.setAttribute('aria-hidden', 'true');
          el.style.setProperty('display', 'none', 'important');
        });
      }
    } catch (e) {}
  }
  function schedulePaginationDedupe() {
    [80, 250, 600, 1200, 2400].forEach(function (ms) {
      setTimeout(function () { dedupePagination(); }, ms);
    });
  }
  // 데이터 행이 있는데도 스냅샷에 박제된 stale 빈행('현재 조건에 맞는 항목 없음')·'0건' footer가
  // 남은 테이블 교정 (admin-list-tools가 이미 enhanced 상태라 재실행하지 않는 경우).
  function fixAdminListEmpty() {
    try {
      Array.prototype.forEach.call(document.querySelectorAll('table'), function (table) {
        var tbody = table.querySelector('tbody'); if (!tbody) return;
        var dataRows = Array.prototype.filter.call(tbody.querySelectorAll('tr'), function (r) {
          if (r.getAttribute('data-admin-list-empty-row') === 'true') return false;
          if (r.getAttribute('data-admin-list-original-empty-row') === 'true') return false;
          if (r.children.length === 1 && r.children[0].hasAttribute('colspan')) return false;
          return true;
        });
        if (!dataRows.length) return;
        Array.prototype.forEach.call(tbody.querySelectorAll('tr[data-admin-list-empty-row="true"]'), function (r) { r.remove(); });
        if (table.id) {
          var f = document.querySelector('.adm-section-list-footer[data-table-id="' + table.id + '"]');
          var info = f && f.querySelector('.js-admin-list-page-info, .adm-section-list-page-info');
          if (info && /(^|\D)0\s*건/.test(info.textContent)) {
            info.textContent = dataRows.length + '건 중 ' + dataRows.length + '건 표시 · 1/1쪽';
          }
        }
      });
    } catch (e) {}
  }
  var _moPending = false;
  function startLinkObserver() {
    try {
      var mo = new MutationObserver(function () {
        if (_moPending) return; _moPending = true;
        setTimeout(function () { _moPending = false; rewriteServerLinks(); dedupePagination(); fixAdminListEmpty(); }, 80);
      });
      mo.observe(document.body || document.documentElement, { childList: true, subtree: true });
    } catch (e) {}
  }
  // 클릭 폴백(재작성 전 동적 링크 포함) — 어떤 경우에도 404로 안 가게
  document.addEventListener('click', function (e) {
    var a = e.target.closest && e.target.closest('a');
    if (!a) return;
    var act = a.dataset ? a.dataset.ttAction : '';
    if (act === 'logout') { e.preventDefault(); logout(); return; }
    if (act === 'missing') { e.preventDefault(); toast('이 화면은 데모에 포함되지 않았습니다.'); return; }
    var href = a.getAttribute('href') || '';
    if (href.indexOf('/TripTogether') === 0) {
      e.preventDefault();
      var t = toStatic(href);
      if (t === '__logout__') { logout(); }
      else if (t) { location.href = BASE + t; }
      else { toast('이 화면은 데모에 포함되지 않았습니다.'); }
    }
  }, true);

  // ---------- 초기화 ----------
  function init() {
    injectStyles();
    injectBanner();
    rewriteServerLinks();   // /TripTogether 절대 링크 → 정적 경로 (전 페이지 공통)
    startLinkObserver();
    dedupePagination();
    fixAdminListEmpty();
    schedulePaginationDedupe();
    setTimeout(function () { fixAdminListEmpty(); }, 400);
    // 관리자 크롬이면 게이트/관리자 처리 후 종료(일반 헤더 없음)
    if (handleAdminChrome()) return;
    rewriteUserHeader();
    enhanceLoginPage();
    handleLoginRequired();
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
