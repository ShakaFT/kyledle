<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import { useAttempts } from '@/core/composables/useAttempts';
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import AttemptsTable from '@/domain/mhdle/classic/attempts/AttemptsTable.vue';
  import SearchSelect from '@/domain/mhdle/classic/search/SearchSelect.vue';
  import VictoryDialog from '@/domain/mhdle/classic/victory/VictoryDialog.vue';

  const { attempts, leftovers, isVictory, attemptOf } =
    useAttempts<MHdleCharacter>();
</script>

<template>
  <BaseLayout>
    <SearchSelect :characters="leftovers" @select="attemptOf" />
    <AttemptsTable :attempts />

    <VictoryDialog :count="attempts.length" :open="isVictory" />
  </BaseLayout>
</template>
