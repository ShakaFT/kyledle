<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();
</script>

<template>
  <div
    class="h-screen"
    :style="{
      background: `url(/${game}_background.png) center/cover no-repeat, black`,
    }"
  >
    <slot />
  </div>
</template>
