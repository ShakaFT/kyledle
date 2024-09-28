import type { ComputedRef } from 'vue';

import { computed } from 'vue';

import { useGameStore } from '@/stores/useGameStore';

export const useModes = <T extends string>() => {
  const store = useGameStore<object, T>();

  return {
    modes: <ComputedRef<T[]>>computed(() => store.data?.modes ?? []),
  };
};
