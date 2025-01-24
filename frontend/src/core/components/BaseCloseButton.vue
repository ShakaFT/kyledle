<script setup lang="ts">
  defineProps<{ color: string }>();

  const icon = '✖️';
</script>

<template>
  <button
    class="hover:animate-jump hover:animate-duration-500 hover:animate-once cursor-pointer text-xl text-transparent opacity-85"
    :style="`text-shadow: 0 0 0 ${color}`"
  >
    {{ icon }}
  </button>
</template>
