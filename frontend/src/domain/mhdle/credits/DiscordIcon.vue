<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { game } = useCurrentGame();
</script>

<template>
  <a
    class="mt-3 drop-shadow-[0_0_5px_#1e293b] duration-200 hover:scale-105"
    href="https://discord.gg/a9dPB2HrNH"
    target="_blank"
  >
    <img
      class="h-[50px] drop-shadow-[0_0_10px_#1e293b]"
      :src="`/${game}_discord.svg`"
    />
  </a>
</template>
