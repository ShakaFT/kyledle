<script setup lang="ts">
  defineProps<{ color: string }>();

  const icon = '✖️';
</script>

<template>
  <button
    class="hover:animate-jump hover:animate-duration-500 hover:animate-once text-xl text-transparent opacity-85 outline-hidden"
    :style="`text-shadow: 0 0 0 ${color}`"
  >
    {{ icon }}
  </button>
</template>
