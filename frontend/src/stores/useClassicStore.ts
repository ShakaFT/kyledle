import { useFetch } from '@vueuse/core';
import { defineStore } from 'pinia';

import { useCurrentGame } from '@/core/composables/useCurrentGame';
import { useCurrentMode } from '@/core/composables/useCurrentMode';

export const useClassicStore = <T>() => {
  const { game } = useCurrentGame();
  const { mode } = useCurrentMode();

  const useDataStore = defineStore(`${game.value}/${mode.value}`, () => {
    const { data } = useFetch(
      `${import.meta.env.VITE_API_URL}/config/${game.value}/${mode.value}`,
      {
        headers: {
          Authorization: import.meta.env.VITE_API_KEY,
        },
      },
    )
      .get()
      .json<{ target: T }>();

    return { data };
  });

  return useDataStore();
};
