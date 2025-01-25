import { useFetch } from '@vueuse/core';
import { defineStore, storeToRefs } from 'pinia';
import { computed, ref } from 'vue';

import { useGameRoute } from '@/features/core/composables/game';

export const useGameStore = <T, U>() => {
  const { game } = useGameRoute();

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
    const isAnimationEnabled = ref(true);

    return { data, characters, modes, isAnimationEnabled };
  });

  return storeToRefs(useDataStore());
};
