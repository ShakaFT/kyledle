import PrimeVue from 'primevue/config';
import { createApp } from 'vue';

import App from '@/App.vue';
import i18n from '@/plugins/i18n';
import pinia from '@/plugins/pinia';
import router from '@/plugins/router';

import '@/assets/styles/main.css';

createApp(App)
  .use(i18n)
  .use(pinia)
  .use(PrimeVue, { unstyled: true })
  .use(router)
  .mount('#app');
