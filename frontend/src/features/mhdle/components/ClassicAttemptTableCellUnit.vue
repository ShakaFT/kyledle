<script setup lang="ts">
  import type { OmitMatching } from '@/types/core.types';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useGameRoute } from '@/features/core/composables/game';
  import ClassicAttemptTableCell from '@/features/mhdle/components/ClassicAttemptTableCell.vue';

  type UnitKeys<T> = keyof OmitMatching<T, unknown[]>;

  const { field, data } = defineProps<{
    field: UnitKeys<MHdleCharacter>;
    data: MHdleCharacter;
    index: number;
  }>();

  const { game } = useGameRoute();

  const isRightMatchingOf = (target: MHdleCharacter): boolean =>
    data[field] === target[field];

  const isWrongMatchingOf = (target: MHdleCharacter): boolean =>
    data[field] !== target[field];
</script>

<template>
  <ClassicAttemptTableCell
    :index
    :is-right="isRightMatchingOf"
    :is-wrong="isWrongMatchingOf"
  >
    {{ $t(`${game}.${field}.${data[field]}`) }}
  </ClassicAttemptTableCell>
</template>
