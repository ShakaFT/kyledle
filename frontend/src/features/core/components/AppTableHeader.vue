<script setup lang="ts">
  import { useGameRoute } from '@/features/core/composables/game';

  defineProps<{ header: string }>();

  const { game } = useGameRoute();
</script>

<template>
  <div
    class="mx-1 mb-3 rounded-lg bg-slate-800 py-2 font-[BagnardSans] font-medium tracking-[.01em] text-slate-300 drop-shadow-[0_0_3px_black]"
    style="-webkit-text-stroke: 0.01em"
  >
    {{ $t(`${game}.${header}`) }}
  </div>
</template>
