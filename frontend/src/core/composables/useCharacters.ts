import { computed } from 'vue';

import { useGameStore } from '@/stores/useGameStore';

export const useCharacters = <T>() => {
  const store = useGameStore<{
    characters: T[];
    modes: string[];
  }>();

  return {
    characters: computed(() => store.characters),
  };
};
