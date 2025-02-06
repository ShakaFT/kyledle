<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useGameRoute } from '@/features/core/composables/game';
  import ClassicHintsText from '@/features/mhdle/components/ClassicHintsText.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { attempts, hasWon } = useClassicStore<MHdleCharacter>();
  const { game } = useGameRoute();
</script>

<template>
  <div
    class="pointer-events-none absolute -top-[6px] left-[386px] min-w-max rounded-lg bg-slate-800 px-3 py-2 drop-shadow-[0_0_3px_black] transition-all duration-300 ease-in-out"
  >
    <div class="flex flex-col gap-1 font-[BagnardSans] text-sm text-slate-300">
      <ClassicHintsText
        :is-hidden="!hasWon && attempts.length < 5"
        type="average-size"
        :value-of="(size) => size.toString().concat(' m')"
      />
      <ClassicHintsText
        :is-hidden="!hasWon && attempts.length < 10"
        type="colors"
        :value-of="
          (colors) =>
            colors.map((color) => $t(`${game}.colors.${color}`)).join(', ')
        "
      />
    </div>
  </div>
</template>
