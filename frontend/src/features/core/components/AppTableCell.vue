<script setup lang="ts">
  import { useGameStore } from '@/stores/useGameStore';

  defineProps<{ index: number }>();

  const { isAnimationEnabled } = useGameStore();
</script>

<template>
  <div
    class="m-1 h-16 content-center rounded-lg border-[1px] text-center font-[BagnardSans] text-sm drop-shadow-lg"
    :class="{
      'animate-fade-right animate-duration-300':
        isAnimationEnabled && index === 0,
    }"
  >
    <slot />
  </div>
</template>
