<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import AutoComplete from 'primevue/autocomplete';
  import { computed, ref } from 'vue';
  import { useI18n } from 'vue-i18n';

  import { useGameId } from '@/core/composables/useGameId';

  interface SelectableCharacter {
    character: MHdleCharacter;
    translation: string;
    matchingIndex: number;
  }

  const props = defineProps<{ characters: MHdleCharacter[] }>();
  const emit = defineEmits<{ select: [character: MHdleCharacter] }>();

  const { t } = useI18n();
  const { gameId } = useGameId();

  const selectableCharacters = computed<SelectableCharacter[]>(() =>
    props.characters.map((character) => ({
      character,
      translation: t(`${gameId.value}.id.${character.id}`),
      matchingIndex: -1,
    })),
  );
  const selection = ref<SelectableCharacter[]>([]);
  const searchedCharacter = ref('');

  const searchOf = (text: string) => {
    const matchingCharacters = selectableCharacters.value.filter(
      ({ translation }) =>
        translation.toLowerCase().startsWith(text.toLowerCase()),
    );

    selection.value = matchingCharacters;
  };

  const selectOf = ({ character }: SelectableCharacter) => {
    emit('select', character);

    selection.value = [];
    searchedCharacter.value = '';
  };
</script>

<template>
  <AutoComplete
    v-model="searchedCharacter"
    :complete-on-focus="selection.length > 0"
    :empty-search-message="' '"
    :input-class="[
      /* animation */
      'duration-300',
      'focus:duration-200',
      'focus:transition',
      /* focus states */
      'focus:ring-[0.42px]',
      'focus:ring-slate-600',
      'outline-none',
      /* layout */
      'bg-slate-300',
      'h-12',
      'rounded-lg',
      'w-80',
      /* misc */
      'backdrop-blur-lg',
      'backdrop-brightness-125',
      'caret-transparent',
      'drop-shadow-lg',
      'mix-blend-multiply',
      /* typography */
      'font-[BluuNext]',
      'placeholder:text-center',
      'placeholder:text-slate-400',
      'text-center',
      'text-xl',
    ]"
    option-label="translation"
    :overlay-class="[
      /* layout */
      'bg-slate-300',
      'mt-1',
      'overflow-auto',
      'rounded-lg',
      /* typography */
      'font-[BluuNext]',
      'text-center',
      'text-xl',
      /* misc */
      'cursor-pointer',
      'backdrop-blur-lg',
      'backdrop-brightness-125',
      'drop-shadow-lg',
      'mix-blend-multiply',
    ]"
    :placeholder="`「 ${$t('mhdle.ui.search-character')} 」`"
    :scroll-height="`${Math.min(selection.length, 4) * 28}px`"
    :spellcheck="false"
    :suggestions="selection"
    @clear="selection = []"
    @complete="searchOf($event.query)"
    @option-select="selectOf($event.value)"
  />
</template>
