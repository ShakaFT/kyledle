<script setup lang="ts">
  import type { SelectableCharacter } from '@/features/mhdle/components/ClassicSearchOption.vue';
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { onClickOutside, refAutoReset } from '@vueuse/core';
  import { ref, useTemplateRef } from 'vue';
  import { useI18n } from 'vue-i18n';

  import { useDailyCountdown } from '@/features/core/composables/dailyCountdown';
  import { useGameRoute } from '@/features/core/composables/game';
  import ClassicSearchOption from '@/features/mhdle/components/ClassicSearchOption.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { leftovers, attemptOf, hasWon } = useClassicStore<MHdleCharacter>();

  const { t } = useI18n();
  const { game } = useGameRoute();
  const { countdown } = useDailyCountdown();

  const input = useTemplateRef('input');
  const isFocusActive = ref(false);

  const selection = ref<SelectableCharacter[]>([]);
  const search = ref('');
  const isDisabled = refAutoReset(false, 3500);

  const startingTermsOf = (translation: string): string[] =>
    translation
      .split(/(?<=[\s-'])/g) // delimiters: space, hyphen, apostrophe
      .map((term, i, terms) =>
        term.concat(...terms.slice(i + 1, terms.length)).toLowerCase(),
      );

  const searchOf = () => {
    if (search.value.length === 0) {
      return (selection.value = []);
    }

    const text = search.value.trim().toLowerCase();

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
    search.value = '';
    isDisabled.value = true;
  };

  onClickOutside(input, () => (isFocusActive.value = false));
</script>

<template>
  <div class="relative">
    <input
      ref="input"
      v-model="search"
      class="h-12 w-80 rounded-lg bg-slate-800 p-2 text-center font-[YoungSerif] text-xl text-slate-300 caret-slate-500 outline-hidden drop-shadow-[0_0_3px_#1e293b] placeholder:font-[BluuNext] placeholder:text-slate-600"
      :class="{
        'placeholder:font-[courier_,_monospace]': hasWon && !isDisabled,
      }"
      :disabled="isDisabled || hasWon"
      :maxlength="42"
      :placeholder="
        hasWon && !isDisabled
          ? `「 ${countdown} 」`
          : `「 ${$t('mhdle.search')} 」`
      "
      :spellcheck="false"
      @click="isFocusActive = true"
      @input="searchOf"
    />
    <div
      v-if="selection.length && isFocusActive"
      class="absolute z-10 mt-1 w-80 overflow-auto rounded-lg bg-slate-800 font-[YoungSerif] text-xl text-slate-300 drop-shadow-[0_0_3px_#1e293b]"
      :style="{ height: `${Math.min(selection.length, 4) * 64}px` }"
    >
      <ClassicSearchOption
        v-for="option in selection"
        :key="option.character.id"
        :option="option"
        @click="selectOf(option)"
      />
    </div>
  </div>
</template>

<style scoped>
  ::-webkit-scrollbar {
    display: none;
  }
</style>
