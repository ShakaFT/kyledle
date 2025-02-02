import { fileURLToPath, URL } from 'node:url';

import vueI18nPlugin from '@intlify/unplugin-vue-i18n/vite';
import tailwindcss from '@tailwindcss/vite';
import vue from '@vitejs/plugin-vue';
import { defineConfig, loadEnv } from 'vite';
import vueDevTools from 'vite-plugin-vue-devtools';

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');

  return {
    plugins: [
      vue(),
      vueDevTools(),
      vueI18nPlugin({
        include: fileURLToPath(new URL('./src/locales/**', import.meta.url)),
      }),
      tailwindcss(),
    ],
    resolve: {
      alias: {
        '@': fileURLToPath(new URL('./src', import.meta.url)),
      },
    },
    server: {
      port: +env.FRONTEND_PORT,
    },
    define: {
      APP_VERSION: JSON.stringify(`v${process.env.npm_package_version}`),
    },
  };
});
