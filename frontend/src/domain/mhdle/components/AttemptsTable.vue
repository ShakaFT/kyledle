<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import Column from 'primevue/column';
  import DataTable from 'primevue/datatable';

  import AttemptCellGroup from '@/domain/mhdle/components/AttemptCellGroup.vue';
  import AttemptCellUnit from '@/domain/mhdle/components/AttemptCellUnit.vue';
  import AttemptHeader from '@/domain/mhdle/components/AttemptHeader.vue';

  defineProps<{ attempts: MHdleCharacter[] }>();
</script>

<template>
  <DataTable
    :pt="{
      root: { class: 'mt-6' },
      tableContainer: { class: '!overflow-visible flex justify-center' },
      table: { class: 'table-fixed w-[70%]' },
    }"
    :value="attempts"
  >
    <Column field="id">
      <template #header>
        <AttemptHeader header="id" />
      </template>
      <template #body="{ data }">
        <AttemptCellUnit :data="data" field="id" />
      </template>
    </Column>

    <Column field="monster-type">
      <template #header>
        <AttemptHeader header="monster-type" />
      </template>
      <template #body="{ data }">
        <AttemptCellUnit :data="data" field="monster-type" />
      </template>
    </Column>

    <Column field="elements">
      <template #header>
        <AttemptHeader header="elements" />
      </template>
      <template #body="{ data }">
        <AttemptCellGroup :data="data" field="elements" />
      </template>
    </Column>

    <Column field="weaknesses">
      <template #header>
        <AttemptHeader header="weaknesses" />
      </template>
      <template #body="{ data }">
        <AttemptCellGroup :data="data" field="weaknesses" />
      </template>
    </Column>

    <Column field="ailments">
      <template #header>
        <AttemptHeader header="ailments" />
      </template>
      <template #body="{ data }">
        <AttemptCellGroup :data="data" field="ailments" />
      </template>
    </Column>

    <Column field="generation">
      <template #header>
        <AttemptHeader header="generation" />
      </template>
      <template #body="{ data }">
        <AttemptCellUnit :data="data" field="generation" />
      </template>
    </Column>

    <Column field="is-subspecies">
      <template #header>
        <AttemptHeader header="is-subspecies" />
      </template>
      <template #body="{ data }">
        <AttemptCellUnit :data="data" field="is-subspecies" />
      </template>
    </Column>
  </DataTable>
</template>
