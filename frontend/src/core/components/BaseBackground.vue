<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();

  const url = new URL(
    `/src/assets/images/${game.value}/background.webp`,
    import.meta.url,
  ).href;
</script>

<template>
  <div
    class="h-screen"
    :style="{ background: `url(${url}) center/cover no-repeat, #0e141c` }"
  >
    <slot />
  </div>
</template>
