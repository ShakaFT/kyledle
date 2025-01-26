<script setup lang="ts">
  import { useTemplateRef } from 'vue';

  import AppDialog from '@/features/core/components/AppDialog.vue';
  import HomeCreditsIcon from '@/features/mhdle/components/HomeCreditsIcon.vue';
  import HomeCreditsTextAbout from '@/features/mhdle/components/HomeCreditsTextAbout.vue';
  import HomeCreditsTextContributions from '@/features/mhdle/components/HomeCreditsTextContributions.vue';
  import HomeCreditsTextDevelopment from '@/features/mhdle/components/HomeCreditsTextDevelopment.vue';
  import HomeDiscordIcon from '@/features/mhdle/components/HomeDiscordIcon.vue';
  import HomeTwitchIcon from '@/features/mhdle/components/HomeTwitchIcon.vue';

  const dialog = useTemplateRef('dialog');
</script>

<template>
  <AppDialog ref="dialog" class="h-[50%] w-[60%]" color="#cbd5e1">
    <template #to-open>
      <div class="flex items-center gap-4">
        <HomeCreditsIcon @click="dialog?.show" />
        <HomeDiscordIcon />
        <HomeTwitchIcon />
      </div>
    </template>

    <div class="overflow-scroll p-12 font-[BagnardSans] text-slate-300">
      <HomeCreditsTextAbout />
      <HomeCreditsTextContributions />
      <HomeCreditsTextDevelopment />
    </div>
  </AppDialog>
</template>

<style scoped>
  ::-webkit-scrollbar {
    display: none;
  }
</style>
