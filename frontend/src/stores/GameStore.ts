import { useFetch } from '@vueuse/core';
import { defineStore } from 'pinia';
import { computed } from 'vue';

import { useCurrentGame } from '@/core/composables/useCurrentGame';

const useGameStore = <
  T extends { characters: unknown[]; modes: string[] },
>() => {
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
      .json<T>();

    return { data };
  });

  return useDataStore();
};

export const useCharacters = <T>() => {
  const store = useGameStore<{
    characters: T[];
    modes: string[];
  }>();

  return {
    characters: computed(() => store.data?.characters ?? <Array<T>>[]),
  };
};

export const useModes = <T extends string>() => {
  const store = useGameStore<{
    characters: unknown[];
    modes: T[];
  }>();

  return {
    modes: computed(() => store.data?.modes ?? <Array<T>>[]),
  };
};
