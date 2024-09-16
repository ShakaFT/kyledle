<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();
</script>

<template>
  <img
    class="drop-shadow-[0_-30px_20px_black] invert"
    :src="`/${game}_logo.png`"
    width="380"
  />
</template>
