<script setup lang="ts">
  import type { SelectableCharacter } from '@/domain/mhdle/components/SearchCharacterOption.vue';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import AutoComplete from 'primevue/autocomplete';
  import { ref } from 'vue';
  import { useI18n } from 'vue-i18n';

  import { useGameId } from '@/core/composables/useGameId';
  import SearchCharacterOption from '@/domain/mhdle/components/SearchCharacterOption.vue';

  const props = defineProps<{ characters: MHdleCharacter[] }>();
  const emit = defineEmits<{ select: [character: MHdleCharacter] }>();

  const { t } = useI18n();
  const { gameId } = useGameId();

  const selection = ref<SelectableCharacter[]>([]);
  const searchedCharacter = ref('');

  const searchOf = (text: string) => {
    selection.value = props.characters
      .map((character) => {
        const translation = t(`${gameId.value}.id.${character.id}`);

        const matchingTerm = translation
          .split(/(?<=[\s-'])/g)
          .map((word, i, words) => {
            const term = word.concat(words.slice(i + 1, words.length).join(''));

            return {
              term,
              startingAt: translation.length - term.length,
            };
          })
          .find(({ term }) =>
            term.toLowerCase().startsWith(text.trim().toLowerCase()),
          );

        return {
          character,
          translation,
          matchingAt: matchingTerm
            ? [matchingTerm.startingAt, matchingTerm.startingAt + text.length]
            : [],
        };
      })
      .filter(({ matchingAt }) => matchingAt.length > 0)
      .sort((a, b) => a.translation.localeCompare(b.translation));
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
    :delay="0"
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
  >
    <template #option="{ option }">
      <SearchCharacterOption :option="option" />
    </template>
  </AutoComplete>
</template>
