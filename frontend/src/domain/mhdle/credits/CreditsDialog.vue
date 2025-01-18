<script setup lang="ts">
  import { ref } from 'vue';

  import BaseCloseButton from '@/core/components/BaseCloseButton.vue';
  import CreditsTextAbout from '@/domain/mhdle/credits/content/CreditsTextAbout.vue';
  import CreditsTextContributions from '@/domain/mhdle/credits/content/CreditsTextContributions.vue';
  import CreditsTextDevelopment from '@/domain/mhdle/credits/content/CreditsTextDevelopment.vue';
  import CreditsIcon from '@/domain/mhdle/credits/CreditsIcon.vue';

  const dialog = ref<HTMLDialogElement | null>(null);
</script>

<template>
  <CreditsIcon @click="dialog?.showModal()" />
  <dialog
    ref="dialog"
    class="pointer-events-none flex h-[50%] w-[60%] rounded-lg bg-slate-800 opacity-0 transition-opacity duration-300 backdrop:bg-transparent open:pointer-events-auto open:opacity-100 open:drop-shadow-[0_0_3px_black]"
  >
    <div class="absolute right-2 top-1">
      <BaseCloseButton color="#cbd5e1" @click="dialog?.close()" />
    </div>

    <div class="overflow-scroll p-12 font-[BagnardSans] text-slate-300">
      <CreditsTextAbout />
      <CreditsTextContributions />
      <CreditsTextDevelopment />
    </div>
  </dialog>
</template>

<style scoped>
  ::-webkit-scrollbar {
    display: none;
  }
</style>
