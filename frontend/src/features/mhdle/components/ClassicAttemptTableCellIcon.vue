<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import AppTableCell from '@/features/core/components/AppTableCell.vue';

  defineProps<{ data: MHdleCharacter; index: number }>();
</script>

<template>
  <AppTableCell class="border-slate-800 bg-slate-600" :index>
    <img class="m-auto h-full" :src="data.picture" />
  </AppTableCell>
</template>
