<script setup lang="ts">
  import BaseLayout from '@/core/layouts/BaseLayout.vue';
  import AttemptsTable from '@/domain/mhdle/classic/attempts/AttemptsTable.vue';
  import SearchSelect from '@/domain/mhdle/classic/search/SearchSelect.vue';
  import VictoryDialog from '@/domain/mhdle/classic/victory/VictoryDialog.vue';
</script>

<template>
  <BaseLayout>
    <SearchSelect />
    <AttemptsTable />
    <VictoryDialog />
  </BaseLayout>
</template>
