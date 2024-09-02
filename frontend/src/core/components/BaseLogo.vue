<script setup lang="ts">
  import { computed } from 'vue';

  import { useGameFromUrl } from '@/core/composables/useGameFromUrl';

  const { game } = useGameFromUrl();

  const logo = computed(() => `/${game.value}_logo.png`);
</script>

<template>
  <img
    class="drop-shadow-[0_-30px_20px_black] invert"
    :src="logo"
    width="380"
  />
</template>
