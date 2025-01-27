<script setup lang="ts">
  const src = new URL(`/src/assets/images/twitch.svg`, import.meta.url).href;
</script>

<template>
  <a
    class="mt-3 drop-shadow-[0_0_5px_#1e293b] duration-200 hover:scale-105"
    href="https://twitch.tv/kylekilleur"
    target="_blank"
  >
    <img class="h-[50px] drop-shadow-[0_0_10px_#1e293b]" :src />
  </a>
</template>
