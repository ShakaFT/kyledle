<script setup lang="ts">
  defineProps<{ color: string }>();
</script>

<template>
  <svg
    class="hover:animate-jump hover:animate-duration-500 size-5 cursor-pointer opacity-85"
    :stroke="color"
    stroke-width="3"
    viewBox="0 0 24 24"
    xmlns="http://www.w3.org/2000/svg"
  >
    <path d="M6 18 18 6M6 6l12 12" />
  </svg>
</template>
