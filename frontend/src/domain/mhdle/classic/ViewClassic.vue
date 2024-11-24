<script setup lang="ts">
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import AttemptsTable from '@/domain/mhdle/classic/attempts/AttemptsTable.vue';
  import HintsIcon from '@/domain/mhdle/classic/hints/HintsIcon.vue';
  import SearchSelect from '@/domain/mhdle/classic/search/SearchSelect.vue';
  import VictoryDialog from '@/domain/mhdle/classic/victory/VictoryDialog.vue';
</script>

<template>
  <BaseLayout>
    <div class="relative">
      <SearchSelect />
      <HintsIcon />
    </div>
    <AttemptsTable />
    <VictoryDialog />
  </BaseLayout>
</template>
