<script setup lang="ts">
  import { useGameId } from '@/core/composables/useGameId';

  const { gameId } = useGameId();
</script>

<template>
  <img
    class="drop-shadow-[0_-30px_20px_black] invert"
    :src="`/${gameId}_logo.png`"
    width="380"
  />
</template>
