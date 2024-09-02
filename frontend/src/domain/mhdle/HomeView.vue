<script setup lang="ts">
  import type { MHdleData, MHdleMode } from '@/types/mhdle.types';

  import { computed } from 'vue';

  import BaseButtonMode from '@/core/components/BaseButtonMode.vue';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import { useGameStore } from '@/stores/game';

  const store = useGameStore<MHdleData>();

  const modes = computed(() => store.data?.modes ?? []);

  function isDisabled(mode: MHdleMode): boolean {
    return mode !== 'classic';
  }
</script>

<template>
  <BaseLayout>
    <BaseButtonMode
      v-for="mode in modes"
      :key="mode"
      :mode="mode"
      :disabled="isDisabled(mode)"
    />
  </BaseLayout>
</template>
