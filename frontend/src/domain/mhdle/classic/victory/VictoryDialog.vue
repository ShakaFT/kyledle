<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { watchDebounced } from '@vueuse/core';
  import { useTemplateRef } from 'vue';

  import BaseDialog from '@/core/components/BaseDialog.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { attempts, hasWon } = useClassicStore<MHdleCharacter>();

  const dialog = useTemplateRef('dialog');

  watchDebounced(hasWon, () => dialog.value?.dialog?.showModal(), {
    debounce: 3500,
  });
</script>

<template>
  <BaseDialog
    ref="dialog"
    :class="Math.random() < 0.5 ? `-rotate-3` : `rotate-3`"
    color="#4ade80"
  >
    <div class="p-12 text-center text-green-400">
      <h1 class="font-[YoungSerif] text-5xl">
        {{ $t('mhdle.victory') }}
      </h1>
      <p class="font-[BagnardSans] text-xl">
        {{ $t('mhdle.victory.description', { x: attempts.length }) }}
      </p>
    </div>
  </BaseDialog>
</template>
