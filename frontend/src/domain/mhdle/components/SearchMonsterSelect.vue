<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';
  import type {
    AutoCompleteCompleteEvent,
    AutoCompleteOptionSelectEvent,
  } from 'primevue/autocomplete';

  import AutoComplete from 'primevue/autocomplete';
  import { ref, toValue } from 'vue';
  import { useI18n } from 'vue-i18n';

  import { useGameId } from '@/core/composables/useGameId';

  const props = defineProps<{ monsters: MHdleCharacter[] }>();
  const emit = defineEmits<{ attempt: [monster: MHdleCharacter] }>();

  const { t } = useI18n();
  const { gameId } = useGameId();

  const searchedMonster = ref();
  const selection = ref<MHdleCharacter[]>([]);

  function searchMonsterOf(event: AutoCompleteCompleteEvent) {
    selection.value = props.monsters.filter(({ id }) =>
      translateMonsterOf(id)
        .toLowerCase()
        .startsWith(event.query.toLowerCase()),
    );
  }

  function selectMonsterOf(event: AutoCompleteOptionSelectEvent) {
    emit('attempt', event.value);
    searchedMonster.value = '';
  }

  function optionLabelOf({ id }: MHdleCharacter) {
    return translateMonsterOf(id);
  }

  function translateMonsterOf(monsterId: string) {
    return t(`${toValue(gameId)}.id.${monsterId}`);
  }
</script>

<template>
  <AutoComplete
    v-model="searchedMonster"
    :empty-search-message="' '"
    :input-class="[
      /* animation */
      'duration-300',
      'focus:duration-200',
      'focus:transition',
      /* focus states */
      'focus:ring-1',
      'focus:ring-slate-500',
      'outline-none',
      /* layout */
      'bg-slate-300',
      'h-12',
      'rounded-md',
      'w-80',
      /* misc */
      'backdrop-blur-lg',
      'backdrop-brightness-125',
      'caret-transparent',
      'mix-blend-multiply',
      /* typography */
      'font-[BluuNext]',
      'placeholder:text-center',
      'placeholder:text-slate-400',
      'text-center',
      'text-xl',
    ]"
    :option-label="optionLabelOf"
    :placeholder="`「 ${$t('mhdle.ui.search-monster')} 」`"
    :spellcheck="false"
    :suggestions="selection"
    @complete="searchMonsterOf"
    @option-select="selectMonsterOf"
  />
</template>
