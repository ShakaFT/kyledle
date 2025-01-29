<script setup lang="ts">
  import type { PickMatching } from '@/types/core.types';
  import type {
    ArrayWithPictureLink,
    MHdleCharacter,
  } from '@/types/mhdle.types';

  import { useGameRoute } from '@/features/core/composables/game';
  import ClassicAttemptTableCell from '@/features/mhdle/components/ClassicAttemptTableCell.vue';

  type GroupKeys<T> = keyof PickMatching<T, ArrayWithPictureLink>;

  const { field, attempt } = defineProps<{
    field: GroupKeys<MHdleCharacter>;
    attempt: MHdleCharacter;
    index: number;
  }>();

  const { game } = useGameRoute();

  const isRightMatchingOf = (target: MHdleCharacter): boolean => {
    const attemptGroup = attempt[field];
    const targetGroup = target[field];

    return (
      attemptGroup.every((value) =>
        targetGroup.map((unit) => unit.id).includes(value.id),
      ) &&
      targetGroup.every((value) =>
        attemptGroup.map((unit) => unit.id).includes(value.id),
      )
    );
  };

  const isWrongMatchingOf = (target: MHdleCharacter): boolean =>
    !attempt[field].some((value) =>
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
      attempt[field].map((unit) => $t(`${game}.${field}.${unit.id}`)).join(', ')
    }}
  </ClassicAttemptTableCell>
</template>
