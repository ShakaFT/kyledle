import type { Ref } from 'vue';

import { useFetch } from '@vueuse/core';
import { defineStore, storeToRefs } from 'pinia';
import { computed, ref } from 'vue';

import { useCurrentGame } from '@/core/composables/useCurrentGame';
import { useCurrentMode } from '@/core/composables/useCurrentMode';
import { useGameStore } from '@/stores/useGameStore';

export const useClassicStore = <
  T extends object & { id: string },
  U extends string = string,
>() => {
  const { characters } = useGameStore<T, U>();

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

    const attempts = ref<T[]>([]) as Ref<T[]>;
    const leftovers = computed(() => characters.value.filter(isLeftoverOf));
    const target = computed(() => data.value?.target ?? <T>{});

    function attemptOf(character: T) {
      attempts.value.unshift(character);
    }

    function isLeftoverOf(character: T): boolean {
      return !attempts.value.find((attempt) => attempt.id === character.id);
    }

    return { data, attempts, leftovers, target, attemptOf, isLeftoverOf };
  });

  const dataStore = useDataStore();

  return {
    ...storeToRefs(dataStore),
    attemptOf: dataStore.attemptOf,
  };
};
