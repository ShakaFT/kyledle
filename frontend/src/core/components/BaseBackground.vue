<script setup lang="ts">
  import { computed } from 'vue';

  import { useGameFromUrl } from '@/core/composables/useGameFromUrl';

  const { game } = useGameFromUrl();

  const background = computed(
    () => `url(/${game.value}_background.png) center/cover no-repeat, black`,
  );
</script>

<template>
  <div class="h-screen" :style="{ background }">
    <slot />
  </div>
</template>
