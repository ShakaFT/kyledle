<script setup lang="ts">
  import type { SelectableCharacter } from '@/domain/mhdle/classic/search/SearchOption.vue';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { refAutoReset } from '@vueuse/core';
  import AutoComplete from 'primevue/autocomplete';
  import { ref } from 'vue';
  import { useI18n } from 'vue-i18n';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import SearchOption from '@/domain/mhdle/classic/search/SearchOption.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { leftovers, attemptOf, hasWon } = useClassicStore<MHdleCharacter>();

  const { t } = useI18n();
  const { game } = useCurrentGame();

  const selection = ref<SelectableCharacter[]>([]);
  const searchedCharacter = ref('');
  const isDisabled = refAutoReset(false, 3500);

  const startingTermsOf = (translation: string): string[] =>
    translation
      .split(/(?<=[\s-'])/g) // delimiters: space, hyphen, apostrophe
      .map((term, i, terms) =>
        term.concat(...terms.slice(i + 1, terms.length)).toLowerCase(),
      );

  const searchOf = (rawText: string) => {
    const text = rawText.trim().toLowerCase();

    selection.value = leftovers.value.reduce<SelectableCharacter[]>(
      (characters, character) => {
        const translation = t(`${game.value}.id.${character.id}`);

        const matchingTerm = startingTermsOf(translation).find((term) =>
          term.startsWith(text),
        );

        if (matchingTerm) {
          const startingAt = translation.length - matchingTerm.length;

          characters.push({
            character,
            translation,
            matchingAt: [startingAt, startingAt + text.length],
          });
        }

        return characters.sort((a, b) =>
          a.translation.localeCompare(b.translation),
        );
      },
      [],
    );
  };

  const selectOf = ({ character }: SelectableCharacter) => {
    attemptOf(character);
    selection.value = [];
    searchedCharacter.value = '';
    isDisabled.value = true;
  };
</script>

<template>
  <AutoComplete
    v-model="searchedCharacter"
    :complete-on-focus="selection.length > 0"
    :delay="0"
    :disabled="isDisabled || hasWon"
    :empty-search-message="' '"
    :placeholder="`「 ${$t('mhdle.ui.search-character')} 」`"
    :pt="{
      overlay: {
        class: [
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
          'backdrop-blur-lg',
          'backdrop-brightness-125',
          'cursor-pointer',
          'drop-shadow-lg',
          'mix-blend-multiply',
        ],
      },
      pcInput: {
        root: {
          class: [
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
            'caret-slate-500',
            'drop-shadow-lg',
            'mix-blend-multiply',
            /* typography */
            'font-[BluuNext]',
            'placeholder:text-slate-400',
            'text-center',
            'text-xl',
          ],
          maxlength: 42,
        },
      },
    }"
    :scroll-height="`${Math.min(selection.length, 4) * 28}px`"
    :spellcheck="false"
    :suggestions="selection"
    @clear="selection = []"
    @complete="searchOf($event.query)"
    @option-select="selectOf($event.value)"
  >
    <template #option="{ option }">
      <SearchOption :option />
    </template>
  </AutoComplete>
</template>
