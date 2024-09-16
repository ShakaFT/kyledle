import { useFetch, watchOnce } from '@vueuse/core';
import { defineStore } from 'pinia';
import { ref } from 'vue';

import { useCurrentGame } from '@/core/composables/useCurrentGame';
import { useCurrentMode } from '@/core/composables/useCurrentMode';

export const useModeStore = <T extends string>() => {
  const { game } = useCurrentGame();
  const { mode } = useCurrentMode();

  const defineGenericStore = defineStore(mode.value, () => {
    const target = ref<T>();

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

    watchOnce(data, () => {
      if (data.value) {
        target.value = data.value.target;
      }
    });

    return { target };
  });

  return defineGenericStore();
};
