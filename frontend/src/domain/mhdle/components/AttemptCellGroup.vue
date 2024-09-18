<script setup lang="ts">
  import type { PickMatching } from '@/types/core.types';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import AttemptCell from '@/domain/mhdle/components/AttemptCell.vue';

  type GroupKeys<T> = keyof PickMatching<T, string[]>;

  const props = defineProps<{
    field: GroupKeys<MHdleCharacter>;
    data: MHdleCharacter;
  }>();

  const { game } = useCurrentGame();

  const isPartialTargetGroupMatchingOf = (target: MHdleCharacter): boolean =>
    props.data[props.field].some((value) =>
      target[props.field].includes(value),
    );

  const isFullTargetGroupMatchingOf = (target: MHdleCharacter): boolean =>
    props.data[props.field].every((value) =>
      target[props.field].includes(value),
    );
</script>

<template>
  <AttemptCell
    :is-close="isPartialTargetGroupMatchingOf"
    :is-exact="isFullTargetGroupMatchingOf"
  >
    {{ data[field].map((unit) => $t(`${game}.${field}.${unit}`)).join(', ') }}
  </AttemptCell>
</template>
