import type { ComputedRef } from 'vue';

import { computed } from 'vue';

import { useGameStore } from '@/stores/useGameStore';

export const useCharacters = <T extends object>() => {
  const store = useGameStore<T, string>();

  return {
    characters: <ComputedRef<T[]>>computed(() => store.data?.characters ?? []),
  };
};
