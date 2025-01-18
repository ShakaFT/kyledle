<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { refDebounced } from '@vueuse/core';

  import BaseCloseButton from '@/core/components/BaseCloseButton.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { attempts, hasWon } = useClassicStore<MHdleCharacter>();

  const isVisible = refDebounced(hasWon, 3500);
</script>

<template>
  <dialog
    v-if="isVisible"
    :class="`inset-0 flex ${Math.random() < 0.5 ? `-rotate-3` : `rotate-3`} animate-jump-in rounded-lg bg-slate-800 drop-shadow-lg animate-add animate-duration-300`"
  >
    <div class="p-9">
      <div class="absolute right-2 top-1">
        <BaseCloseButton color="#4ade80" @click="isVisible = false" />
      </div>

      <div class="text-center text-green-400">
        <h1 class="font-[YoungSerif] text-5xl">
          {{ $t('mhdle.ui.victory.title') }}
        </h1>
        <p class="font-[BagnardSans] text-xl">
          {{ $t('mhdle.ui.victory.sentence', { x: attempts.length }) }}
        </p>
      </div>
    </div>
  </dialog>
</template>
