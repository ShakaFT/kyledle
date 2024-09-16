<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  defineProps<{ header: string }>();

  const { gameId } = useCurrentGame();
</script>

<template>
  <div
    :class="[
      /* layout */
      'bg-slate-800',
      'mb-3',
      'mx-1',
      'py-2',
      'rounded-lg',
      /* typography */
      'font-[BluuNext]',
      'text-slate-300',
      /* misc */
      'drop-shadow-[0_0_3px_#e0d9ca]',
    ]"
  >
    {{ $t(`${gameId}.${header}`) }}
  </div>
</template>
