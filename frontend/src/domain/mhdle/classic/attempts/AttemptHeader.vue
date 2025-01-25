<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  defineProps<{ header: string }>();

  const { game } = useCurrentGame();
</script>

<template>
  <div
    class="mx-1 mb-3 rounded-lg bg-slate-800 py-2 font-[BagnardSans] text-slate-300 drop-shadow-[0_0_3px_black]"
  >
    {{ $t(`${game}.${header}`) }}
  </div>
</template>
