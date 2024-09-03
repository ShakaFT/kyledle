<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { computed, ref, toValue } from 'vue';

  import { useCharacters } from '@/core/composables/useCharacters';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import SearchMonsterSelect from '@/domain/mhdle/components/SearchMonsterSelect.vue';

  const { characters } = useCharacters<MHdleCharacter>();

  const attemptedMonsters = ref<MHdleCharacter[]>([]);
  const availableMonsters = computed(() =>
    toValue(characters).filter(
      (monster) =>
        !toValue(attemptedMonsters)
          .map((attempted) => attempted.id)
          .includes(monster.id),
    ),
  );

  function attemptMonsterOf(monster: MHdleCharacter) {
    attemptedMonsters.value.push(monster);
  }
</script>

<template>
  <BaseLayout>
    <SearchMonsterSelect
      :monsters="availableMonsters"
      @attempt="attemptMonsterOf"
    />
    {{ attemptedMonsters }}
  </BaseLayout>
</template>
