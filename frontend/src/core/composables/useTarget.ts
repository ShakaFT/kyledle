import { computed } from 'vue';

import { useModeStore } from '@/stores/useModeStore';

export const useTarget = <T extends string>() => {
  const store = useModeStore<T>();

  return {
    target: computed(() => store.target),
  };
};
