import type { Ref } from 'vue';

import { watchDebounced } from '@vueuse/core';
import { computed, ref } from 'vue';

import { useCharacters } from '@/stores/composables/useCharacters';
import { useTarget } from '@/stores/composables/useTarget';

export const useAttempts = <T extends object & { id: string }>() => {
  const { characters } = useCharacters<T>();
  const { target } = useTarget<T>();

  const attempts = ref([]) as Ref<T[]>;
  const leftovers = computed(() => characters.value.filter(isNotAttemptedOf));
  const isVictory = ref(false);

  const attemptOf = (character: T) => attempts.value.unshift(character);

  const isNotAttemptedOf = (character: T): boolean =>
    !attempts.value.find((attempt) => attempt.id === character.id);

  const isNowTargetFound = (): boolean =>
    !!attempts.value.find((attempt) => attempt.id === target.value.id);

  watchDebounced(
    attempts.value,
    () => {
      isVictory.value = isNowTargetFound();
    },
    { debounce: 3500 },
  );

  return {
    attempts,
    leftovers,
    isVictory,
    attemptOf,
  };
};
