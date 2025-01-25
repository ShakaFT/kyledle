import { createRouter, createWebHistory } from 'vue-router';

export default createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/mhdle',
    },
    {
      path: '/:pathMatch(.*)*',
      redirect: '/mhdle',
    },
    {
      path: '/mhdle',
      component: () => import('@/features/mhdle/views/ViewHome.vue'),
    },
    {
      path: '/mhdle/classic',
      component: () => import('@/features/mhdle/views/ViewClassic.vue'),
    },
  ],
});
