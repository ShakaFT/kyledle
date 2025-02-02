<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { watchDebounced } from '@vueuse/core';
  import { useTemplateRef } from 'vue';

  import AppCode from '@/features/core/components/AppCode.vue';
  import AppDialog from '@/features/core/components/AppDialog.vue';
  import AppTitle from '@/features/core/components/AppTitle.vue';
  import { useDailyCountdown } from '@/features/core/composables/dailyCountdown';
  import { useGameRoute } from '@/features/core/composables/game';
  import { useClassicStore } from '@/stores/useClassicStore';
  import { useGameStore } from '@/stores/useGameStore';

  const { game } = useGameRoute();
  const { isAnimationEnabled } = useGameStore();
  const { attempts, hasWon, target } = useClassicStore<MHdleCharacter>();

  const dialog = useTemplateRef('dialog');
  const { countdown } = useDailyCountdown();

  watchDebounced(
    hasWon,
    (_hasWon) => {
      if (_hasWon && isAnimationEnabled.value) {
        dialog.value?.show();
      }
    },
    { debounce: 3500 },
  );

  watchDebounced(
    hasWon,
    (_hasWon) => {
      if (_hasWon && !isAnimationEnabled.value) {
        dialog.value?.show();
      }
    },
    { debounce: 100, immediate: true },
  );
</script>

<template>
  <AppDialog
    ref="dialog"
    class="text-slate-300"
    :class="Math.random() < 0.5 ? `-rotate-3` : `rotate-3`"
  >
    <div class="p-12 text-center">
      <AppTitle class="text-5xl text-slate-300" keypath="mhdle.victory" />

      <div class="my-3">
        <img class="m-auto h-20" :src="target.picture" />
        <p class="font-[YoungSerif] text-xl text-slate-400">
          【 {{ $t(`${game}.id.${target.id}`) }} 】
        </p>
      </div>

      <i18n-t
        class="font-[BagnardSans] text-xl"
        :keypath="`${game}.victory.description1`"
        scope="global"
        tag="p"
      >
        <template #count>
          <code class="font-[courier_,_monospace] text-2xl text-amber-400">
            {{ attempts.length }}
          </code>
        </template>
      </i18n-t>

      <i18n-t
        class="mt-4 font-[BagnardSans] text-lg text-slate-500"
        :keypath="`${game}.victory.description2`"
        scope="global"
        tag="p"
      >
        <template #countdown>
          <AppCode>{{ countdown }}</AppCode>
        </template>
      </i18n-t>
    </div>
  </AppDialog>
</template>
