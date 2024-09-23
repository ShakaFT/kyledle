<script setup lang="ts">
  import type { PickMatching } from '@/types/core.types';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import AttemptCell from '@/domain/mhdle/components/AttemptCell.vue';

  type GroupKeys<T> = keyof PickMatching<T, string[]>;

  const { field, data } = defineProps<{
    field: GroupKeys<MHdleCharacter>;
    data: MHdleCharacter;
    index: number;
  }>();

  const { game } = useCurrentGame();

  const isRightMatchingOf = (target: MHdleCharacter): boolean =>
    data[field].every((value) => target[field].includes(value));

  const isWrongMatchingOf = (target: MHdleCharacter): boolean =>
    !data[field].some((value) => target[field].includes(value));
</script>

<template>
  <AttemptCell
    :index="index"
    :is-right="isRightMatchingOf"
    :is-wrong="isWrongMatchingOf"
  >
    {{ data[field].map((unit) => $t(`${game}.${field}.${unit}`)).join(', ') }}
  </AttemptCell>
</template>
