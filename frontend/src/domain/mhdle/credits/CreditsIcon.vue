<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();
</script>

<template>
  <button
    class="mt-3 drop-shadow-[0_0_5px_#1e293b] duration-200 hover:scale-105"
  >
    <img
      class="h-14 drop-shadow-[0_0_10px_#1e293b]"
      :src="`/${game}_guild.svg`"
    />
  </button>
</template>
