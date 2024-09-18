<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useModeStore } from '@/stores/useModeStore';

  defineProps<{
    isClose?: (target: MHdleCharacter) => boolean;
    isExact: (target: MHdleCharacter) => boolean;
  }>();

  const { target } = useModeStore<{ target: MHdleCharacter }>();
</script>

<template>
  <div
    :class="[
      /* layout */
      'bg-slate-300',
      'border-[1px]',
      'border-slate-800',
      'content-center',
      'h-16',
      'm-1',
      'rounded-lg',
      isExact(target)
        ? '!bg-green-600'
        : isClose?.(target)
          ? '!bg-yellow-600'
          : '!bg-red-600',
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
