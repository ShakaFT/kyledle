<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();

  const src = new URL(
    `/src/assets/images/${game.value}/logo.png`,
    import.meta.url,
  ).href;
</script>

<template>
  <RouterLink :to="`/${game}`">
    <button type="button">
      <img
        class="drop-shadow-[0_-30px_20px_#1e293b] invert duration-200 hover:scale-105"
        :src
        width="380"
      />
    </button>
  </RouterLink>
</template>
