<script setup lang="ts">
  import { useGameRoute } from '@/features/core/composables/game';

  const { value = '' } = defineProps<{
    isCountdownOngoing: boolean;
    type: string;
    value: string;
  }>();

  const { game } = useGameRoute();
</script>

<template>
  <p :class="isCountdownOngoing ? 'opacity-30' : 'opacity-100'">
    <template v-if="isCountdownOngoing">
      {{ $t(`${game}.${type}.locked-hint`) }}
    </template>
    <template v-else> {{ $t(`${game}.${type}`) }} : {{ value }} </template>
  </p>
</template>
