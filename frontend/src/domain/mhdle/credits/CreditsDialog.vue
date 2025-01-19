<script setup lang="ts">
  import BaseDialog from '@/core/components/BaseDialog.vue';
  import CreditsTextAbout from '@/domain/mhdle/credits/content/CreditsTextAbout.vue';
  import CreditsTextContributions from '@/domain/mhdle/credits/content/CreditsTextContributions.vue';
  import CreditsTextDevelopment from '@/domain/mhdle/credits/content/CreditsTextDevelopment.vue';
  import CreditsIcon from '@/domain/mhdle/credits/CreditsIcon.vue';
  import DiscordIcon from '@/domain/mhdle/credits/DiscordIcon.vue';
</script>

<template>
  <BaseDialog class="h-[50%] w-[60%]" color="#cbd5e1">
    <template #open="{ dialog }">
      <div class="flex items-center gap-4">
        <CreditsIcon @click="dialog?.showModal()" />
        <DiscordIcon />
      </div>
    </template>

    <div class="overflow-scroll p-12 font-[BagnardSans] text-slate-300">
      <CreditsTextAbout />
      <CreditsTextContributions />
      <CreditsTextDevelopment />
    </div>
  </BaseDialog>
</template>

<style scoped>
  ::-webkit-scrollbar {
    display: none;
  }
</style>
