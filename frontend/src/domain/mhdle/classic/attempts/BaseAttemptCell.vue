<script setup lang="ts">
  import { useGameStore } from '@/stores/useGameStore';

  defineProps<{ index: number }>();

  const { isAnimationEnabled } = useGameStore();
</script>

<template>
  <div
    :class="[
      'border-[1px]',
      'content-center',
      'drop-shadow-lg',
      'font-[BagnardSans]',
      'h-16',
      'm-1',
      'rounded-lg',
      'text-center',
      'text-sm',
      {
        'animate-fade-right animate-duration-300':
          isAnimationEnabled && index === 0,
      },
    ]"
  >
    <slot />
  </div>
</template>
