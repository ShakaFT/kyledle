<script setup lang="ts">
  import type { MHdleCharacter, MHdleData } from '@/types/mhdle.types';

  import { computed, ref, toValue } from 'vue';

  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import SearchMonsterSelect from '@/domain/mhdle/components/SearchMonsterSelect.vue';
  import { useGameStore } from '@/stores/game';

  const store = useGameStore<MHdleData>();

  const attemptedMonsters = ref<MHdleCharacter[]>([]);
  const availableMonsters = computed(
    () =>
      store.data?.characters.filter(
        (monster) =>
          !toValue(attemptedMonsters)
            .map((attempted) => attempted.id)
            .includes(monster.id),
      ) ?? [],
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
