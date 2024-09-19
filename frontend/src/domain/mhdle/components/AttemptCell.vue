<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useTarget } from '@/stores/ModeStore';

  defineProps<{
    isRight: (target: MHdleCharacter) => boolean;
    isWrong: (target: MHdleCharacter) => boolean;
  }>();

  const { target } = useTarget<MHdleCharacter>();
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
      isRight(target)
        ? '!bg-green-600'
        : isWrong(target)
          ? '!bg-red-600'
          : '!bg-yellow-600',
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
