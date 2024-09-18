<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { computed, ref } from 'vue';

  import { useCharacters } from '@/core/composables/useCharacters';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import AttemptsTable from '@/domain/mhdle/components/AttemptsTable.vue';
  import SearchSelect from '@/domain/mhdle/components/SearchSelect.vue';
  import { useModeStore } from '@/stores/useModeStore';

  const { characters } = useCharacters<MHdleCharacter>();
  useModeStore();

  const leftovers = computed(() => characters.value.filter(isNotAttempted));
  const attempts = ref<MHdleCharacter[]>([]);

  const isNotAttempted = (character: MHdleCharacter): boolean =>
    !attempts.value.map((attempt) => attempt.id).includes(character.id);

  const attemptOf = (character: MHdleCharacter) =>
    attempts.value.unshift(character);
</script>

<template>
  <BaseLayout>
    <SearchSelect :characters="leftovers" @select="attemptOf" />
    <AttemptsTable :attempts="attempts" />
  </BaseLayout>
</template>
