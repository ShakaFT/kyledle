import { useFetch } from '@vueuse/core';
import { defineStore } from 'pinia';
import { computed } from 'vue';

import { useCurrentGame } from '@/core/composables/useCurrentGame';
import { useCurrentMode } from '@/core/composables/useCurrentMode';

const useModeStore = <T>() => {
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

export const useTarget = <T extends object>() => {
  const store = useModeStore<T>();

  return {
    target: computed(() => store.data?.target ?? <T>{}),
  };
};
