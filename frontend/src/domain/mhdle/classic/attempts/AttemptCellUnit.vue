<script setup lang="ts">
  import type { OmitMatching } from '@/types/core.types';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import AttemptCell from '@/domain/mhdle/classic/attempts/AttemptCell.vue';

  type UnitKeys<T> = keyof OmitMatching<T, string[]>;

  const { field, data } = defineProps<{
    field: UnitKeys<MHdleCharacter>;
    data: MHdleCharacter;
    index: number;
  }>();

  const { game } = useCurrentGame();

  const isRightMatchingOf = (target: MHdleCharacter): boolean =>
    data[field] === target[field];

  const isWrongMatchingOf = (target: MHdleCharacter): boolean =>
    data[field] !== target[field];
</script>

<template>
  <AttemptCell
    :index
    :is-right="isRightMatchingOf"
    :is-wrong="isWrongMatchingOf"
  >
    {{ $t(`${game}.${field}.${data[field]}`) }}
  </AttemptCell>
</template>
