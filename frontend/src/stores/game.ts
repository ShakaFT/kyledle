import type { Ref } from 'vue';

import { toValue, useFetch } from '@vueuse/core';
import { defineStore } from 'pinia';

export const useGameStore = <T>(game: Ref<string>) => {
  const defineGenericStore = defineStore(toValue(game), () => {
    const { data } = useFetch(
      `${import.meta.env.VITE_API_URL}/config/${toValue(game)}`,
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
