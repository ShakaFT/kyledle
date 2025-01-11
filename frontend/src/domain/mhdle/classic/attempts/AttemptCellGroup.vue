<script setup lang="ts">
  import type { PickMatching } from '@/types/core.types';
  import type {
    ArrayWithPictureLink,
    MHdleCharacter,
  } from '@/types/mhdle.types';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import AttemptCell from '@/domain/mhdle/classic/attempts/AttemptCell.vue';

  type GroupKeys<T> = keyof PickMatching<T, ArrayWithPictureLink>;

  const { field, data } = defineProps<{
    field: GroupKeys<MHdleCharacter>;
    data: MHdleCharacter;
    index: number;
  }>();

  const { game } = useCurrentGame();

  const isRightMatchingOf = (target: MHdleCharacter): boolean =>
    data[field].every((value) =>
      target[field].map((unit) => unit.id).includes(value.id),
    );

  const isWrongMatchingOf = (target: MHdleCharacter): boolean =>
    !data[field].some((value) =>
      target[field].map((unit) => unit.id).includes(value.id),
    );
</script>

<template>
  <AttemptCell
    :index
    :is-right="isRightMatchingOf"
    :is-wrong="isWrongMatchingOf"
  >
    {{
      data[field].map((unit) => $t(`${game}.${field}.${unit.id}`)).join(', ')
    }}
  </AttemptCell>
</template>
