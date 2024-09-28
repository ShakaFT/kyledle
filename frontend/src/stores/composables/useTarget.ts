import type { ComputedRef } from 'vue';

import { computed } from 'vue';

import { useClassicStore } from '@/stores/useClassicStore';

export const useTarget = <T extends object>() => {
  const store = useClassicStore<T>();

  return {
    target: <ComputedRef<T>>computed(() => store.data?.target ?? {}),
  };
};
