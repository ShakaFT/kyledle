import { toValue, useFetch } from '@vueuse/core';
import { defineStore } from 'pinia';

import { useGameId } from '@/core/composables/useGameId';

export const useGameStore = <T>() => {
  const { gameId } = useGameId();

  const defineGenericStore = defineStore(toValue(gameId), () => {
    const { data } = useFetch(
      `${import.meta.env.VITE_API_URL}/config/${toValue(gameId)}`,
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

  return defineGenericStore();
};
