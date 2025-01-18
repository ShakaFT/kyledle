<script setup lang="ts">
  defineProps<{ color: string }>();

  const icon = '✖️';
</script>

<template>
  <button
    class="text-xl text-transparent opacity-85 hover:animate-jump hover:animate-duration-500 hover:animate-once"
    :style="`text-shadow: 0 0 0 ${color}`"
  >
    {{ icon }}
  </button>
</template>
