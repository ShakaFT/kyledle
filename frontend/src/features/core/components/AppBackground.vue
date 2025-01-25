<script setup lang="ts">
  import { useGameRoute } from '@/features/core/composables/game';

  const { game } = useGameRoute();

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
