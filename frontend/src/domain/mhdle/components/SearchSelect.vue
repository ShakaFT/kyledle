<script setup lang="ts">
  import type { SelectableCharacter } from '@/domain/mhdle/components/SearchOption.vue';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import AutoComplete from 'primevue/autocomplete';
  import { ref } from 'vue';
  import { useI18n } from 'vue-i18n';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import SearchOption from '@/domain/mhdle/components/SearchOption.vue';

  const props = defineProps<{ characters: MHdleCharacter[] }>();
  const emit = defineEmits<{ select: [character: MHdleCharacter] }>();

  const { t } = useI18n();
  const { game } = useCurrentGame();

  const selection = ref<SelectableCharacter[]>([]);
  const searchedCharacter = ref('');

  const startingTermsOf = (translation: string): string[] =>
    translation
      .split(/(?<=[\s-'])/g) // delimiters: space, hyphen, apostrophe
      .map((term, i, terms) =>
        term.concat(...terms.slice(i + 1, terms.length)).toLowerCase(),
      );

  const searchOf = (rawText: string) => {
    const text = rawText.trim().toLowerCase();

    selection.value = props.characters.reduce<SelectableCharacter[]>(
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
            'caret-transparent',
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
      <SearchOption :option="option" />
    </template>
  </AutoComplete>
</template>
