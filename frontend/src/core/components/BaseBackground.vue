<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { gameId } = useCurrentGame();
</script>

<template>
  <div
    class="h-screen"
    :style="{
      background: `url(/${gameId}_background.png) center/cover no-repeat, black`,
    }"
  >
    <slot />
  </div>
</template>
