import { useFetch } from '@vueuse/core';
import { defineStore, storeToRefs } from 'pinia';
import { computed } from 'vue';

import { useCurrentGame } from '@/core/composables/useCurrentGame';

export const useGameStore = <T, U>() => {
  const { game } = useCurrentGame();

  const useDataStore = defineStore(game.value, () => {
    const { data } = useFetch(
      `${import.meta.env.VITE_API_URL}/config/${game.value}`,
      {
        headers: {
          Authorization: import.meta.env.VITE_API_KEY,
        },
      },
    )
      .get()
      .json<{ characters: T[]; modes: U[] }>();

    const characters = computed(() => data.value?.characters ?? <T[]>[]);
    const modes = computed(() => data.value?.modes ?? <U[]>[]);

    return { data, characters, modes };
  });

  return storeToRefs(useDataStore());
};
