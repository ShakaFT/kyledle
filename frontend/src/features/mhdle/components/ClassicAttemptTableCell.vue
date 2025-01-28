<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import AppTableCell from '@/features/core/components/AppTableCell.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  defineProps<{
    index: number;
    isRight: (target: MHdleCharacter) => boolean;
    isWrong: (target: MHdleCharacter) => boolean;
  }>();

  const { target } = useClassicStore<MHdleCharacter>();
</script>

<template>
  <AppTableCell
    :class="
      isRight(target)
        ? 'border-green-800 bg-green-600'
        : isWrong(target)
          ? 'border-red-800 bg-red-600'
          : 'border-yellow-800 bg-yellow-600'
    "
    :index
  >
    <slot />
  </AppTableCell>
</template>
