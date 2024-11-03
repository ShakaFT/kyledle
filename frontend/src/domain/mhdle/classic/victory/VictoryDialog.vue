<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { refDebounced } from '@vueuse/core';

  import { useClassicStore } from '@/stores/useClassicStore';

  const { attempts, hasWon } = useClassicStore<MHdleCharacter>();

  const isVisible = refDebounced(hasWon, 3500);

  const rotateRandomly = () => {
    const angle = Math.floor(Math.random() * 2) + 2;
    const sign = Math.random() < 0.5 ? '-' : '';

    return `${sign}rotate-${angle}`;
  };
</script>

<template>
  <dialog
    v-if="isVisible"
    :class="`inset-0 flex ${rotateRandomly()} animate-jump-in rounded-lg bg-slate-800 drop-shadow-lg animate-add animate-duration-300`"
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
        <h1 class="text-5xl">Bravo !</h1>
        <p class="text-xl">
          Vous avez trouvé le monstre du jour en
          {{ attempts.length }} tentative(s).
        </p>
      </div>
    </div>
  </dialog>
</template>
