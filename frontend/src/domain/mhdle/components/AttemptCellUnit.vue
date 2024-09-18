<script setup lang="ts">
  import type { OmitMatching } from '@/types/core.types';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import AttemptCell from '@/domain/mhdle/components/AttemptCell.vue';

  type UnitKeys<T> = keyof OmitMatching<T, string[]>;

  const props = defineProps<{
    field: UnitKeys<MHdleCharacter>;
    data: MHdleCharacter;
  }>();

  const { game } = useCurrentGame();

  const isTargetUnitMatchingOf = (target: MHdleCharacter): boolean =>
    props.data[props.field] === target[props.field];
</script>

<template>
  <AttemptCell :is-exact="isTargetUnitMatchingOf">
    {{ $t(`${game}.${field}.${data[field]}`) }}
  </AttemptCell>
</template>
