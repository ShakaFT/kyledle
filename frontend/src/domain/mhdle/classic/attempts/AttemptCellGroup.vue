<script setup lang="ts">
  import type { PickMatching } from '@/types/core.types';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import AttemptCell from '@/domain/mhdle/classic/attempts/AttemptCell.vue';

  type GroupKeys<T> = keyof PickMatching<T, unknown[]>;

  const { field, data } = defineProps<{
    field: GroupKeys<MHdleCharacter>;
    data: MHdleCharacter;
    index: number;
  }>();

  const { game } = useCurrentGame();

  const isRightMatchingOf = (target: MHdleCharacter): boolean =>
    data[field].every((value) => comparisonOf(value, target));

  const isWrongMatchingOf = (target: MHdleCharacter): boolean =>
    !data[field].some((value) => comparisonOf(value, target));

  const comparisonOf = (value: unknown, target: MHdleCharacter) =>
    typeof value !== 'string'
      ? // @ts-expect-error - check on ArrayWithPictureLink
        target[field].includes(value.id)
      : // @ts-expect-error - check on string
        target[field].includes(value);

  const translationOf = (unit: unknown) =>
    typeof unit !== 'string'
      ? // @ts-expect-error - check on ArrayWithPictureLink
        unit.id
      : unit;
</script>

<template>
  <AttemptCell
    :index
    :is-right="isRightMatchingOf"
    :is-wrong="isWrongMatchingOf"
  >
    {{
      data[field]
        .map((unit) => $t(`${game}.${field}.${translationOf(unit)}`))
        .join(', ')
    }}
  </AttemptCell>
</template>
