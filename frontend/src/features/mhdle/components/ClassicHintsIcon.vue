<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useElementHover } from '@vueuse/core';
  import { ref, useTemplateRef, watch } from 'vue';

  import { useGameRoute } from '@/features/core/composables/game';
  import { useModeRoute } from '@/features/core/composables/mode';
  import ClassicHintsTooltip from '@/features/mhdle/components/ClassicHintsTooltip.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { game } = useGameRoute();
  const { mode } = useModeRoute();

  const { attempts, hasWon } = useClassicStore<MHdleCharacter>();

  const hoverable = useTemplateRef('hoverable');
  const isHovered = useElementHover(hoverable);

  const classes = ref('drop-shadow-[0_0_10px_black]');

  watch(
    attempts,
    () => {
      if (
        !hasWon.value &&
        (attempts.value.length === 5 || attempts.value.length === 10)
      )
        classes.value =
          'drop-shadow-[0_0_10px_springgreen,0_0_5px_springgreen] duration-1000 ease-out delay-[3.5s]';
    },
    { deep: true },
  );

  watch(isHovered, () => {
    if (isHovered.value)
      classes.value = 'drop-shadow-[0_0_10px_black] duration-500';
  });

  const src = new URL(
    `/src/assets/images/${game.value}/${mode.value}/hints.svg`,
    import.meta.url,
  ).href;
</script>

<template>
  <img
    ref="hoverable"
    class="absolute top-0 -right-[58px] w-[50px]"
    :class="classes"
    :src
  />
  <ClassicHintsTooltip :class="isHovered ? 'opacity-100' : 'opacity-0'" />
</template>
