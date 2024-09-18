import { computed } from 'vue';

import { useCharacters } from '@/core/composables/useCharacters';
import { useModeStore } from '@/stores/useModeStore';

export const useTarget = <T extends { id: string }>() => {
  const { characters } = useCharacters<T>();
  const store = useModeStore();

  return {
    target: computed(
      () => characters.value.find(({ id }) => id === store.target)!,
    ),
  };
};
