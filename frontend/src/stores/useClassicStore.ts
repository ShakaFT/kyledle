import type { Ref } from 'vue';

import { useFetch, useLocalStorage, watchOnce } from '@vueuse/core';
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
      .json<{ target: T; timestamp: number }>();

    const attempts = ref<T[]>([]) as Ref<T[]>;
    const leftovers = computed(() => characters.value.filter(isLeftoverOf));
    const target = computed(() => data.value?.target ?? <T>{});
    const hasWon = computed(
      () =>
        !!attempts.value.find((character) => character.id === target.value.id),
    );

    function attemptOf(character: T) {
      attempts.value.unshift(character);

      const storage = useLocalStorage(`${game.value}/${mode.value}`, {
        attempts: <T[]>[],
      });

      storage.value.attempts = attempts.value;
    }

    function isLeftoverOf(character: T): boolean {
      return !attempts.value.find((attempt) => attempt.id === character.id);
    }

    watchOnce(data, (data) => {
      if (!data) return;

      const serverDay = new Date(data.timestamp * 1000).toDateString();

      const storage = useLocalStorage(`${game.value}/${mode.value}`, {
        attempts: [],
        serverDay,
      });

      if (storage.value.serverDay === serverDay)
        return (attempts.value = storage.value.attempts);

      storage.value.attempts = [];
      storage.value.serverDay = serverDay;
    });

    return {
      data,
      attempts,
      leftovers,
      target,
      hasWon,
      attemptOf,
      isLeftoverOf,
    };
  });

  const store = useDataStore();

  return {
    ...storeToRefs(store),
    attemptOf: store.attemptOf,
  };
};
