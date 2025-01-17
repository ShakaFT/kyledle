<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();
</script>

<template>
  <button class="drop-shadow-[0_0_5px_#bfa4a6]">
    <img
      class="mt-3 h-14 cursor-pointer drop-shadow-[0_0_5px_#bfa4a6] duration-200 hover:scale-105"
      :src="`/${game}_credits.svg`"
    />
  </button>
</template>
