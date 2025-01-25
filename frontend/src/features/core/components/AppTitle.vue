<script setup lang="ts">
  defineProps<{ keypath: string }>();
</script>

<template>
  <h1 class="font-[YoungSerif] text-4xl">{{ $t(`${keypath}`) }}</h1>
</template>
