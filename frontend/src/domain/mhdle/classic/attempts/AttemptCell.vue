<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useClassicStore } from '@/stores/useClassicStore';

  defineProps<{
    index: number;
    isRight: (target: MHdleCharacter) => boolean;
    isWrong: (target: MHdleCharacter) => boolean;
  }>();

  const { target } = useClassicStore<MHdleCharacter>();
</script>

<template>
  <div
    :class="[
      'bg-slate-300',
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
      isRight(target)
        ? ['!bg-green-600', 'border-green-800']
        : isWrong(target)
          ? ['!bg-red-600', 'border-red-800']
          : ['!bg-yellow-600', 'border-yellow-800'],
    ]"
  >
    <slot />
  </div>
</template>
