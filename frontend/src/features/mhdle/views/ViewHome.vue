<script setup lang="ts">
  import type { MHdleCharacter, MHdleMode } from '@/types/mhdle.types';

  import AppLayout from '@/features/core/layouts/AppLayout.vue';
  import HomeCreditsDialog from '@/features/mhdle/components/HomeCreditsDialog.vue';
  import HomeModeButton from '@/features/mhdle/components/HomeModeButton.vue';
  import { useGameStore } from '@/stores/useGameStore';

  const { modes } = useGameStore<MHdleCharacter, MHdleMode>();

  const isDisabledOf = (mode: MHdleMode): boolean => mode !== 'classic';
</script>

<template>
  <AppLayout>
    <HomeModeButton
      v-for="mode in modes"
      :key="mode"
      :disabled="isDisabledOf(mode)"
      :mode
    />
    <HomeCreditsDialog />
  </AppLayout>
</template>
