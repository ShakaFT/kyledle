<script setup lang="ts">
  import type { MHdleMode } from '@/types/mhdle.types';

  import BaseButtonMode from '@/core/components/BaseButtonMode.vue';
  import { useModes } from '@/core/composables/useModes';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';

  const { modes } = useModes<MHdleMode>();

  const isDisabled = (mode: MHdleMode): boolean => mode !== 'classic';
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
