<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { watchDebounced } from '@vueuse/core';
  import { ref } from 'vue';

  import { useClassicStore } from '@/stores/useClassicStore';

  const { attempts, target } = useClassicStore<MHdleCharacter>();

  const isVictory = ref(false);

  watchDebounced(
    attempts.value,
    (characters) => {
      isVictory.value = !!characters.find(
        (character) => character.id === target.value.id,
      );
    },
    { debounce: 3500 },
  );
</script>

<template>
  <dialog :open="isVictory">
    <div
      class="fixed inset-0 flex h-screen -rotate-3 flex-col items-center justify-center"
    >
      <div
        :class="[
          'animate-duration-300',
          'animate-jump-in',
          'bg-slate-800',
          'drop-shadow-lg',
          'p-9',
          'rounded-lg',
          'text-center',
        ]"
      >
        <h1 class="font-[BluuNext] text-5xl text-green-400">Bravo !</h1>
        <p class="font-[BluuNext] text-xl text-green-400">
          Vous avez trouvé le monstre du jour en
          {{ attempts.length }} tentative(s).
        </p>
      </div>
    </div>
  </dialog>
</template>
