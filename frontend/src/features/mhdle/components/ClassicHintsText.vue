<script setup lang="ts" generic="T extends MHdleHint">
  import type { MHdleCharacter, MHdleHint } from '@/types/mhdle.types';

  import { useGameRoute } from '@/features/core/composables/game';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { valueOf } = defineProps<{
    isHidden: boolean;
    type: T;
    valueOf: (value: MHdleCharacter[T]) => string;
  }>();

  const { target } = useClassicStore<MHdleCharacter>();
  const { game } = useGameRoute();

  const formatOf = (type: T) => valueOf(target.value[type]);
</script>

<template>
  <p :class="isHidden ? 'opacity-30' : 'opacity-100'">
    <template v-if="isHidden">
      {{ $t(`${game}.${type}.locked-hint`) }}
    </template>
    <template v-else>
      {{ $t(`${game}.${type}`) }} : {{ formatOf(type) }}
    </template>
  </p>
</template>
