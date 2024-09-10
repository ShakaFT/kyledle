<script setup lang="ts">
  import { useGameId } from '@/core/composables/useGameId';

  const { gameId } = useGameId();
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
