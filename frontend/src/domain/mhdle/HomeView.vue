<script setup lang="ts">
  import type { MHdleData } from '@/types/mhdle.types';

  import { computed } from 'vue';

  import BaseButtonMode from '@/core/components/BaseButtonMode.vue';
  import { useGameFromUrl } from '@/core/composables/useGameFromUrl';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import { useGameStore } from '@/stores/game';

  const { game } = useGameFromUrl();
  const store = useGameStore<MHdleData>(game);

  const modes = computed(() => store.data?.modes ?? []);

  function isDisabled(mode: string): boolean {
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
