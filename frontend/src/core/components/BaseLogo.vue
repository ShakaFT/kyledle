<script setup lang="ts">
  import { computed, toValue } from 'vue';

  import { useGameId } from '@/core/composables/useGameId';

  const { gameId } = useGameId();

  const logo = computed(() => `/${toValue(gameId)}_logo.png`);
</script>

<template>
  <img
    class="drop-shadow-[0_-30px_20px_black] invert"
    :src="logo"
    width="380"
  />
</template>
