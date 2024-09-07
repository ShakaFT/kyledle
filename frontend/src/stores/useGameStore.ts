import { useFetch, watchOnce } from '@vueuse/core';
import { defineStore } from 'pinia';
import { ref } from 'vue';

import { useGameId } from '@/core/composables/useGameId';

export const useGameStore = <
  T extends {
    characters: unknown[];
    modes: string[];
  },
>() => {
  const { gameId } = useGameId();

  const defineGenericStore = defineStore(gameId.value, () => {
    const characters = ref<T['characters']>([]);
    const modes = ref<T['modes']>([]);

    const { data } = useFetch(
      `${import.meta.env.VITE_API_URL}/config/${gameId.value}`,
      {
        headers: {
          Authorization: import.meta.env.VITE_API_KEY,
        },
      },
    )
      .get()
      .json<T>();

    watchOnce(data, () => {
      if (data.value) {
        characters.value = data.value.characters;
        modes.value = data.value.modes;
      }
    });

    return { characters, modes };
  });

  return defineGenericStore();
};
