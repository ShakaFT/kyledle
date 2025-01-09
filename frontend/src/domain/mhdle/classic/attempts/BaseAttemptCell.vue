<script setup lang="ts">
  defineProps<{ index: number }>();
</script>

<template>
  <div
    :class="[
      'border-[1px]',
      'content-center',
      'drop-shadow-lg',
      'font-[BluuNext]',
      'h-16',
      'm-1',
      'rounded-lg',
      'text-center',
      'text-sm',
      { 'animate-fade-right animate-duration-300': index === 0 },
    ]"
  >
    <slot />
  </div>
</template>
