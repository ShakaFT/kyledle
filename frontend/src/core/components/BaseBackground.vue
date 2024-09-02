<script setup lang="ts">
  import { computed, toValue } from 'vue';

  import { useGameId } from '@/core/composables/useGameId';

  const { gameId } = useGameId();

  const background = computed(
    () =>
      `url(/${toValue(gameId)}_background.png) center/cover no-repeat, black`,
  );
</script>

<template>
  <div class="h-screen" :style="{ background }">
    <slot />
  </div>
</template>
