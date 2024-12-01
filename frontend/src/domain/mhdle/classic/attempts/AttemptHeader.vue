<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  defineProps<{ header: string }>();

  const { game } = useCurrentGame();
</script>

<template>
  <div
    :class="[
      'bg-slate-800',
      'drop-shadow-[0_0_3px_black]',
      'font-[BluuNext]',
      'mb-3',
      'mx-1',
      'py-2',
      'rounded-lg',
      'text-slate-300',
    ]"
  >
    {{ $t(`${game}.${header}`) }}
  </div>
</template>
