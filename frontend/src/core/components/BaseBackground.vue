<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();

  const background = `url(/${game.value}_background.webp) center/cover no-repeat, #0e141c`;
</script>

<template>
  <div class="h-screen" :style="{ background }">
    <slot />
  </div>
</template>
