<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useElementHover } from '@vueuse/core';
  import { ref, watch } from 'vue';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import { useCurrentMode } from '@/core/composables/useCurrentMode';
  import HintsTooltip from '@/domain/mhdle/classic/hints/HintsTooltip.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { game } = useCurrentGame();
  const { mode } = useCurrentMode();

  const { attempts } = useClassicStore<MHdleCharacter>();

  const hoverable = ref();
  const isHovered = useElementHover(hoverable);

  const classes = ref('drop-shadow-[0_0_10px_black]');

  watch(attempts.value, () => {
    if (attempts.value.length === 5 || attempts.value.length === 10)
      classes.value =
        'drop-shadow-[0_0_10px_springgreen] duration-1000 ease-out delay-[3.5s]';
  });

  watch(isHovered, () => {
    if (isHovered.value)
      classes.value = 'drop-shadow-[0_0_10px_black] duration-500';
  });
</script>

<template>
  <img
    ref="hoverable"
    class="absolute -right-[58px] top-0"
    :class="classes"
    :src="`/${game}_${mode}_hints.svg`"
    width="50"
  />
  <HintsTooltip :class="isHovered ? 'opacity-100' : 'opacity-0'" />
</template>
