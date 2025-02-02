<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useElementHover } from '@vueuse/core';
  import { useTemplateRef } from 'vue';

  import AppTableCell from '@/features/core/components/AppTableCell.vue';
  import { useGameRoute } from '@/features/core/composables/game';

  defineProps<{ attempt: MHdleCharacter; index: number }>();

  const { game } = useGameRoute();

  const hoverable = useTemplateRef('hoverable');
  const isHovered = useElementHover(hoverable);
</script>

<template>
  <AppTableCell class="border-slate-800 bg-slate-600" :index>
    <img
      ref="hoverable"
      class="m-auto h-full transition-opacity duration-300 ease-in-out"
      :class="{ 'opacity-0': isHovered }"
      :src="attempt.picture"
    />
    <div
      class="pointer-events-none absolute inset-0 flex items-center justify-center p-2 opacity-0 transition-opacity duration-300 ease-in-out"
      :class="{ 'opacity-100': isHovered }"
    >
      <span class="font-[YoungSerif] text-base/5 text-slate-400">
        {{ $t(`${game}.id.${attempt.id}`).replace(/-/g, '&#8209;') }}
      </span>
    </div>
  </AppTableCell>
</template>
