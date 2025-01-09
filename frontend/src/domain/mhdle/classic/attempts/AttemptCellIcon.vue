<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import BaseAttemptCell from '@/domain/mhdle/classic/attempts/BaseAttemptCell.vue';

  defineProps<{ data: MHdleCharacter; index: number }>();
</script>

<template>
  <BaseAttemptCell class="border-slate-800 bg-slate-600" :index>
    <img class="m-auto h-full" :src="data.picture" />
  </BaseAttemptCell>
</template>
