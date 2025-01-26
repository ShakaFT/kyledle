<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { watchDebounced } from '@vueuse/core';
  import { useTemplateRef } from 'vue';

  import AppDialog from '@/features/core/components/AppDialog.vue';
  import { useClassicStore } from '@/stores/useClassicStore';
  import { useGameStore } from '@/stores/useGameStore';

  const { isAnimationEnabled } = useGameStore();
  const { attempts, hasWon } = useClassicStore<MHdleCharacter>();

  const dialog = useTemplateRef('dialog');

  watchDebounced(
    hasWon,
    (_hasWon) => {
      if (_hasWon && isAnimationEnabled.value) {
        dialog.value?.show();
      }
    },
    { debounce: 3500 },
  );

  watchDebounced(
    hasWon,
    (_hasWon) => {
      if (_hasWon && !isAnimationEnabled.value) {
        dialog.value?.show();
      }
    },
    { debounce: 100, immediate: true },
  );
</script>

<template>
  <AppDialog
    ref="dialog"
    :class="Math.random() < 0.5 ? `-rotate-3` : `rotate-3`"
    color="#4ade80"
  >
    <div class="p-12 text-center text-green-400">
      <h1 class="font-[YoungSerif] text-5xl">
        {{ $t('mhdle.victory') }}
      </h1>
      <p class="font-[BagnardSans] text-xl">
        {{ $t('mhdle.victory.description', { x: attempts.length }) }}
      </p>
    </div>
  </AppDialog>
</template>
