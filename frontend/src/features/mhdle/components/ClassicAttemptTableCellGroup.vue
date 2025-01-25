<script setup lang="ts">
  import type { PickMatching } from '@/types/core.types';
  import type {
    ArrayWithPictureLink,
    MHdleCharacter,
  } from '@/types/mhdle.types';

  import { useGameRoute } from '@/features/core/composables/game';
  import ClassicAttemptTableCell from '@/features/mhdle/components/ClassicAttemptTableCell.vue';

  type GroupKeys<T> = keyof PickMatching<T, ArrayWithPictureLink>;

  const { field, data } = defineProps<{
    field: GroupKeys<MHdleCharacter>;
    data: MHdleCharacter;
    index: number;
  }>();

  const { game } = useGameRoute();

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
  <ClassicAttemptTableCell
    :index
    :is-right="isRightMatchingOf"
    :is-wrong="isWrongMatchingOf"
  >
    {{
      data[field].map((unit) => $t(`${game}.${field}.${unit.id}`)).join(', ')
    }}
  </ClassicAttemptTableCell>
</template>
