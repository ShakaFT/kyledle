<script setup lang="ts">
  import type { SelectableCharacter } from '@/domain/mhdle/classic/search/SearchOption.vue';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { refAutoReset } from '@vueuse/core';
  import AutoComplete from 'primevue/autocomplete';
  import { ref } from 'vue';
  import { useI18n } from 'vue-i18n';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import HintsIcon from '@/domain/mhdle/classic/hints/HintsIcon.vue';
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
  <div class="relative">
    <AutoComplete
      v-model="searchedCharacter"
      :complete-on-focus="selection.length > 0"
      :delay="0"
      :disabled="isDisabled || hasWon"
      :empty-search-message="' '"
      :placeholder="`「 ${$t('mhdle.search')} 」`"
      :pt="{
        overlay: {
          class: [
            'backdrop-blur-lg',
            'backdrop-brightness-125',
            'bg-slate-300',
            'cursor-pointer',
            'drop-shadow-lg',
            'font-[YoungSerif]',
            'mix-blend-multiply',
            'mt-1',
            'overflow-auto',
            'rounded-lg',
            'text-center',
            'text-xl',
          ],
        },
        pcInputText: {
          root: {
            class: [
              'backdrop-blur-lg',
              'backdrop-brightness-125',
              'bg-slate-300',
              'caret-slate-500',
              'drop-shadow-lg',
              'duration-300',
              'focus:duration-200',
              'focus:ring-[0.42px]',
              'focus:ring-slate-600',
              'focus:transition',
              'font-[YoungSerif]',
              'h-12',
              'mix-blend-multiply',
              'outline-none',
              'placeholder:font-[BluuNext]',
              'placeholder:text-slate-400',
              'rounded-lg',
              'text-center',
              'text-xl',
              'w-80',
            ],
            maxlength: 42,
          },
        },
      }"
      :scroll-height="`${Math.min(selection.length, 4) * 64}px`"
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
    <HintsIcon />
  </div>
</template>
