<script setup lang="ts">
  import { useLocalStorage, watchDebounced } from '@vueuse/core';
  import { useTemplateRef } from 'vue';

  import AppDialog from '@/features/core/components/AppDialog.vue';
  import AppParagraph from '@/features/core/components/AppParagraph.vue';
  import AppTitle from '@/features/core/components/AppTitle.vue';
  import AppCodeVersion from '@/features/core/extensions/AppCodeVersion.vue';

  const dialog = useTemplateRef('dialog');
  const storage = useLocalStorage('app', { version: '0.0.0' });

  watchDebounced(
    dialog,
    () => {
      if (storage.value.version !== APP_VERSION) {
        storage.value.version = APP_VERSION;
        dialog.value?.show();
      }
    },
    { debounce: 100, once: true },
  );
</script>

<template>
  <AppDialog ref="dialog" class="max-h-[32rem] w-3xl">
    <div class="overflow-scroll p-12 font-[BagnardSans] text-slate-300">
      <div class="mb-6 flex place-items-center gap-4">
        <AppTitle keypath="core.changelog" />
        <AppCodeVersion class="text-lg" />
      </div>

      <AppParagraph keypath="core.changelog.description1" />
      <AppParagraph keypath="core.changelog.description2" />
      <AppParagraph is-last keypath="core.changelog.description3" />
    </div>
  </AppDialog>
</template>

<style scoped>
  ::-webkit-scrollbar {
    display: none;
  }
</style>
