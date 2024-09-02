<script setup lang="ts">
  import type { MHdleCharacter, MHdleData } from '@/types/mhdle.types';
  import type {
    AutoCompleteCompleteEvent,
    AutoCompleteOptionSelectEvent,
  } from 'primevue/autocomplete';

  import AutoComplete from 'primevue/autocomplete';
  import { computed, ref } from 'vue';
  import { useI18n } from 'vue-i18n';

  import { useGameFromUrl } from '@/core/composables/useGameFromUrl';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import { useGameStore } from '@/stores/game';

  const { t } = useI18n();
  const { game } = useGameFromUrl();
  const store = useGameStore<MHdleData>(game);

  const monsters = computed(() => store.data?.characters ?? []);

  const searchedMonster = ref();
  const selection = ref<MHdleCharacter[]>([]);
  const selectedMonster = ref<MHdleCharacter>();

  function translateMonsterOf(monsterId: string) {
    return t(`${game.value}.id.${monsterId}`);
  }

  function optionLabelOf({ id }: MHdleCharacter) {
    return translateMonsterOf(id);
  }

  function searchMonsterOf(event: AutoCompleteCompleteEvent) {
    selection.value = monsters.value.filter(({ id }) =>
      translateMonsterOf(id)
        .toLowerCase()
        .startsWith(event.query.toLowerCase()),
    );
  }

  function selectMonsterOf(event: AutoCompleteOptionSelectEvent) {
    searchedMonster.value = '';
    selectedMonster.value = event.value;
  }
</script>

<template>
  <BaseLayout>
    <AutoComplete
      v-model="searchedMonster"
      :empty-search-message="' '"
      :option-label="optionLabelOf"
      :suggestions="selection"
      @complete="searchMonsterOf"
      @option-select="selectMonsterOf"
    />
    {{ selectedMonster }}
  </BaseLayout>
</template>
