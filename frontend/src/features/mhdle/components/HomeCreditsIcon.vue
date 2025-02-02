<script setup lang="ts">
  import { useGameRoute } from '@/features/core/composables/game';

  const { game } = useGameRoute();

  const src = new URL(
    `/src/assets/images/${game.value}/credits.svg`,
    import.meta.url,
  ).href;
</script>

<template>
  <button
    class="mt-3 outline-hidden drop-shadow-[0_0_5px_#1e293b] duration-200 hover:scale-105"
  >
    <img class="h-14 drop-shadow-[0_0_10px_#1e293b]" :src />
  </button>
</template>
