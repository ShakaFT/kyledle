<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { watchDebounced } from '@vueuse/core';
  import { computed, ref } from 'vue';

  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import AttemptsTable from '@/domain/mhdle/components/AttemptsTable.vue';
  import SearchSelect from '@/domain/mhdle/components/SearchSelect.vue';
  import VictoryDialog from '@/domain/mhdle/components/VictoryDialog.vue';
  import { useCharacters } from '@/stores/GameStore';
  import { useTarget } from '@/stores/ModeStore';

  const { characters } = useCharacters<MHdleCharacter>();
  const { target } = useTarget<MHdleCharacter>();

  const leftovers = computed(() => characters.value.filter(isNotAttempted));
  const attempts = ref<MHdleCharacter[]>([]);
  const isTargetFound = ref(false);

  const isNotAttempted = (character: MHdleCharacter): boolean =>
    !attempts.value.map((attempt) => attempt.id).includes(character.id);

  const attemptOf = (character: MHdleCharacter) =>
    attempts.value.unshift(character);

  watchDebounced(
    attempts.value,
    () => {
      isTargetFound.value = !!attempts.value.find(
        (attempt) => attempt.id === target.value.id,
      );
    },
    { debounce: 3500 },
  );
</script>

<template>
  <BaseLayout>
    <SearchSelect :characters="leftovers" @select="attemptOf" />
    <AttemptsTable :attempts />
    <VictoryDialog :count="attempts.length" :open="isTargetFound" />
  </BaseLayout>
</template>
