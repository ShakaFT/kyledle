<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useTarget } from '@/stores/composables/useTarget';

  defineProps<{
    index: number;
    isRight: (target: MHdleCharacter) => boolean;
    isWrong: (target: MHdleCharacter) => boolean;
  }>();

  const { target } = useTarget<MHdleCharacter>();
</script>

<template>
  <div
    :class="[
      /* animation */
      { 'animate-fade-right animate-duration-300': index === 0 },
      /* layout */
      'bg-slate-300',
      'border-[1px]',
      'content-center',
      'h-16',
      'm-1',
      'rounded-lg',
      isRight(target)
        ? ['!bg-green-600', 'border-green-800']
        : isWrong(target)
          ? ['!bg-red-600', 'border-red-800']
          : ['!bg-yellow-600', 'border-yellow-800'],
      /* typography */
      'font-[BluuNext]',
      'text-center',
      'text-sm',
      /* misc */
      'drop-shadow-lg',
    ]"
  >
    <slot />
  </div>
</template>
