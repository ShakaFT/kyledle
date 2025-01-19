<script setup lang="ts">
  import type { MHdleCharacter, MHdleMode } from '@/types/mhdle.types';

  import BaseButtonMode from '@/core/components/BaseButtonMode.vue';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import CreditsDialog from '@/domain/mhdle/credits/CreditsDialog.vue';
  import { useGameStore } from '@/stores/useGameStore';

  const { modes } = useGameStore<MHdleCharacter, MHdleMode>();

  const isDisabledOf = (mode: MHdleMode): boolean => mode !== 'classic';
</script>

<template>
  <BaseLayout>
    <BaseButtonMode
      v-for="mode in modes"
      :key="mode"
      :disabled="isDisabledOf(mode)"
      :mode
    />
    <CreditsDialog />
  </BaseLayout>
</template>
