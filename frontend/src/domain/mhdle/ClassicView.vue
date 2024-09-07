<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { computed, ref } from 'vue';

  import { useCharacters } from '@/core/composables/useCharacters';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import SearchCharacterSelect from '@/domain/mhdle/components/SearchCharacterSelect.vue';

  const { characters } = useCharacters<MHdleCharacter>();

  const availableCharacters = computed(() =>
    characters.value.filter(isNotAttempted),
  );
  const attemptedCharacters = ref<MHdleCharacter[]>([]);

  const isNotAttempted = (character: MHdleCharacter) =>
    !attemptedCharacters.value
      .map((attempted) => attempted.id)
      .includes(character.id);

  const attemptOf = (character: MHdleCharacter) =>
    attemptedCharacters.value.push(character);
</script>

<template>
  <BaseLayout>
    <SearchCharacterSelect
      :characters="availableCharacters"
      @select="attemptOf"
    />
  </BaseLayout>
</template>
