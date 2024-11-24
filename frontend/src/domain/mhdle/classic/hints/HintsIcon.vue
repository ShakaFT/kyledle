<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useElementHover } from '@vueuse/core';
  import { computed, ref, watch } from 'vue';
  import { useI18n } from 'vue-i18n';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import { useCurrentMode } from '@/core/composables/useCurrentMode';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { t } = useI18n();
  const { game } = useCurrentGame();
  const { mode } = useCurrentMode();

  const { attempts, target } = useClassicStore<MHdleCharacter>();

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

  const averageSize = computed(() => {
    const title = t(`${game.value}.average-size`);
    const value = target.value['average-size']?.toString().concat(' m');

    return `${title} : ${value}`;
  });

  const colors = computed(() => {
    const title = t(`${game.value}.colors`);
    const values = target.value['colors']
      ?.map((color) => t(`mhdle.colors.${color}`))
      .join(', ');

    return `${title} : ${values}`;
  });
</script>

<template>
  <div>
    <img
      ref="hoverable"
      class="absolute -right-[58px] top-0"
      :class="classes"
      :src="`/${game}_${mode}_hints.svg`"
      width="50"
    />

    <div
      class="absolute -right-[246px] -top-[6px] rounded-lg bg-slate-800 px-3 py-2 drop-shadow-[0_0_3px_black] transition-all duration-300 ease-in-out"
      :class="isHovered ? 'opacity-100' : 'opacity-0'"
    >
      <div class="flex flex-col gap-1 font-[BluuNext] text-sm text-slate-300">
        <p :class="attempts.length < 1 ? 'opacity-30' : 'opacity-100'">
          {{
            attempts.length < 1 ? $t(`${game}.hints.first-locked`) : averageSize
          }}
        </p>
        <p :class="attempts.length < 2 ? 'opacity-30' : 'opacity-100'">
          {{ attempts.length < 2 ? $t(`${game}.hints.second-locked`) : colors }}
        </p>
      </div>
    </div>
  </div>
</template>
