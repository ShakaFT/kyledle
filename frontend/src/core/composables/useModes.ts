import { computed } from 'vue';

import { useGameStore } from '@/stores/useGameStore';

export const useModes = <T extends string>() => {
  const store = useGameStore<{
    characters: unknown[];
    modes: T[];
  }>();

  return {
    modes: computed(() => store.modes),
  };
};
