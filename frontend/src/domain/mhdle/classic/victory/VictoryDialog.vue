<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { refDebounced } from '@vueuse/core';

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
        <button
          class="text-xl text-transparent opacity-85 hover:animate-jump hover:animate-duration-500 hover:animate-once"
          style="text-shadow: 0 0 0 #4ade80"
          @click="isVisible = false"
        >
          ✖️
        </button>
      </div>

      <div class="text-center font-[BluuNext] text-green-400">
        <h1 class="text-5xl">{{ $t('mhdle.ui.victory.title') }}</h1>
        <p class="text-xl">
          {{ $t('mhdle.ui.victory.sentence', { x: attempts.length }) }}
        </p>
      </div>
    </div>
  </dialog>
</template>
