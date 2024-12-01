<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { computed } from 'vue';
  import { useI18n } from 'vue-i18n';

  import HintText from '@/domain/mhdle/classic/hints/HintText.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { attempts, target } = useClassicStore<MHdleCharacter>();

  const { t } = useI18n();

  const averageSize = computed(() =>
    target.value['average-size']?.toString().concat(' m'),
  );

  const colors = computed(() =>
    target.value['colors']
      ?.map((color) => t(`mhdle.colors.${color}`))
      .join(', '),
  );
</script>

<template>
  <div
    class="pointer-events-none absolute -top-[6px] left-[386px] min-w-max rounded-lg bg-slate-800 px-3 py-2 drop-shadow-[0_0_3px_black] transition-all duration-300 ease-in-out"
  >
    <div class="flex flex-col gap-1 font-[BluuNext] text-sm text-slate-300">
      <HintText
        :is-countdown-ongoing="attempts.length < 5"
        type="average-size"
        :value="averageSize"
      />
      <HintText
        :is-countdown-ongoing="attempts.length < 10"
        type="colors"
        :value="colors"
      />
    </div>
  </div>
</template>
