<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();
</script>

<template>
  <RouterLink :to="`/${game}`">
    <button>
      <img
        :class="[
          /* animation */
          'duration-200',
          'hover:scale-105',
          /* misc */
          'cursor-pointer',
          'drop-shadow-[0_-30px_20px_black]',
          'invert',
        ]"
        :src="`/${game}_logo.png`"
        width="380"
      />
    </button>
  </RouterLink>
</template>
