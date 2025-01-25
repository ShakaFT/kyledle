<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();
</script>

<template>
  <RouterLink :to="`/${game}`">
    <button>
      <img
        class="drop-shadow-[0_-30px_20px_#1e293b] invert duration-200 hover:scale-105"
        :src="`/${game}_logo.png`"
        width="380"
      />
    </button>
  </RouterLink>
</template>
