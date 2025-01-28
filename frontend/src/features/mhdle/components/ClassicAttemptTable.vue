<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import Column from 'primevue/column';
  import DataTable from 'primevue/datatable';

  import AppTableHeader from '@/features/core/components/AppTableHeader.vue';
  import ClassicAttemptTableCellGroup from '@/features/mhdle/components/ClassicAttemptTableCellGroup.vue';
  import ClassicAttemptTableCellIcon from '@/features/mhdle/components/ClassicAttemptTableCellIcon.vue';
  import ClassicAttemptTableCellUnit from '@/features/mhdle/components/ClassicAttemptTableCellUnit.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { attempts } = useClassicStore<MHdleCharacter>();
</script>

<template>
  <DataTable
    v-if="attempts.length > 0"
    :pt="{
      root: { class: 'mt-6' },
      tableContainer: { class: '!overflow-visible flex justify-center' },
      table: { class: 'table-fixed w-5xl' },
    }"
    :value="attempts"
  >
    <Column field="id">
      <template #header>
        <AppTableHeader header="id" />
      </template>
      <template #body="{ data, field, index }">
        <ClassicAttemptTableCellIcon
          :key="`${data.id}-${field}`"
          :data
          :index
        />
      </template>
    </Column>

    <Column field="monster-type">
      <template #header>
        <AppTableHeader header="monster-type" />
      </template>
      <template #body="{ data, field, index }">
        <ClassicAttemptTableCellUnit
          :key="`${data.id}-${field}`"
          class="animate-delay-[0.5s]"
          :data
          :field="field as 'monster-type'"
          :index
        />
      </template>
    </Column>

    <Column field="elements">
      <template #header>
        <AppTableHeader header="elements" />
      </template>
      <template #body="{ data, field, index }">
        <ClassicAttemptTableCellGroup
          :key="`${data.id}-${field}`"
          class="animate-delay-[1s]"
          :data
          :field="field as 'elements'"
          :index
        />
      </template>
    </Column>

    <Column field="weaknesses">
      <template #header>
        <AppTableHeader header="weaknesses" />
      </template>
      <template #body="{ data, field, index }">
        <ClassicAttemptTableCellGroup
          :key="`${data.id}-${field}`"
          class="animate-delay-[1.5s]"
          :data
          :field="field as 'weaknesses'"
          :index
        />
      </template>
    </Column>

    <Column field="ailments">
      <template #header>
        <AppTableHeader header="ailments" />
      </template>
      <template #body="{ data, field, index }">
        <ClassicAttemptTableCellGroup
          :key="`${data.id}-${field}`"
          class="animate-delay-[2s]"
          :data
          :field="field as 'ailments'"
          :index
        />
      </template>
    </Column>

    <Column field="generation">
      <template #header>
        <AppTableHeader header="generation" />
      </template>
      <template #body="{ data, field, index }">
        <ClassicAttemptTableCellUnit
          :key="`${data.id}-${field}`"
          class="animate-delay-[2.5s]"
          :data
          :field="field as 'generation'"
          :index
        />
      </template>
    </Column>

    <Column field="is-subspecies">
      <template #header>
        <AppTableHeader header="is-subspecies" />
      </template>
      <template #body="{ data, field, index }">
        <ClassicAttemptTableCellUnit
          :key="`${data.id}-${field}`"
          class="animate-delay-[3s]"
          :data
          :field="field as 'is-subspecies'"
          :index
        />
      </template>
    </Column>
  </DataTable>
</template>
