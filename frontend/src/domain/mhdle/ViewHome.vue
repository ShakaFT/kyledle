<script setup lang="ts">
  import type { MHdleMode } from '@/types/mhdle.types';

  import BaseButtonMode from '@/core/components/BaseButtonMode.vue';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import { useModes } from '@/stores/composables/useModes';

  const { modes } = useModes<MHdleMode>();

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
  </BaseLayout>
</template>
