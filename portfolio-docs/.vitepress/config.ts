import { defineConfig } from 'vitepress'

// 라이브: https://notetester.github.io/TripTogetherPortfolio/docs/
export default defineConfig({
  lang: 'ko-KR',
  title: 'TripTogether',
  description: 'Spring Boot 기반 통합 여행 플랫폼 — 기능별 기술 설명서',
  base: '/TripTogetherPortfolio/docs/',
  lastUpdated: true,
  cleanUrls: true,
  ignoreDeadLinks: true,

  head: [
    ['meta', { name: 'theme-color', content: '#0ea5a4' }],
    ['meta', { property: 'og:title', content: 'TripTogether 기술 설명서' }],
    ['meta', { property: 'og:description', content: '통합 여행 플랫폼의 도메인별 기능·설계 결정 정리' }],
  ],

  themeConfig: {
    outline: { level: [2, 3], label: '목차' },
    docFooter: { prev: '이전', next: '다음' },
    darkModeSwitchLabel: '테마',
    sidebarMenuLabel: '메뉴',
    returnToTopLabel: '맨 위로',
    lastUpdatedText: '마지막 수정',

    nav: [
      { text: '개요', link: '/overview' },
      { text: '아키텍처', link: '/architecture' },
      { text: '설계 결정', link: '/decisions' },
      { text: '라이브 데모 ↗', link: 'https://notetester.github.io/TripTogetherPortfolio/' },
      { text: 'GitHub ↗', link: 'https://github.com/notetester/TripTogetherPortfolio' },
    ],

    sidebar: [
      {
        text: '시작하기',
        items: [
          { text: '프로젝트 개요', link: '/overview' },
          { text: '아키텍처', link: '/architecture' },
        ],
      },
      {
        text: '도메인별 기능',
        items: [
          { text: '인증 · 계정 · 보안', link: '/auth' },
          { text: '커뮤니티 · 신고', link: '/community' },
          { text: '여행 코스 · AI 일정', link: '/courses' },
          { text: '탐색 · 커머스', link: '/explore' },
          { text: 'AI 통합', link: '/ai' },
          { text: '관리자 · 운영', link: '/admin' },
          { text: '문의 · 알림 · 마이페이지', link: '/inquiry' },
          { text: '공통 · 인프라 · i18n', link: '/common' },
        ],
      },
      {
        text: '심화',
        items: [
          { text: '설계 결정 (ADR 종합)', link: '/decisions' },
        ],
      },
    ],

    search: {
      provider: 'local',
      options: {
        translations: {
          button: { buttonText: '검색', buttonAriaLabel: '검색' },
          modal: {
            noResultsText: '결과 없음',
            resetButtonTitle: '지우기',
            footer: { selectText: '선택', navigateText: '이동', closeText: '닫기' },
          },
        },
      },
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/notetester/TripTogetherPortfolio' },
    ],
  },
})
