<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import Column from 'primevue/column';
  import DataTable from 'primevue/datatable';

  import AttemptCellGroup from '@/domain/mhdle/classic/attempts/AttemptCellGroup.vue';
  import AttemptCellIcon from '@/domain/mhdle/classic/attempts/AttemptCellIcon.vue';
  import AttemptCellUnit from '@/domain/mhdle/classic/attempts/AttemptCellUnit.vue';
  import AttemptHeader from '@/domain/mhdle/classic/attempts/AttemptHeader.vue';
  import { useClassicStore } from '@/stores/useClassicStore';

  const { attempts } = useClassicStore<MHdleCharacter>();
</script>

<template>
  <DataTable
    v-if="attempts.length > 0"
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
      <template #body="{ data, field, index }">
        <AttemptCellIcon :key="`${data.id}-${field}`" :data :index />
      </template>
    </Column>

    <Column field="monster-type">
      <template #header>
        <AttemptHeader header="monster-type" />
      </template>
      <template #body="{ data, field, index }">
        <AttemptCellUnit
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
        <AttemptHeader header="elements" />
      </template>
      <template #body="{ data, field, index }">
        <AttemptCellGroup
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
        <AttemptHeader header="weaknesses" />
      </template>
      <template #body="{ data, field, index }">
        <AttemptCellGroup
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
        <AttemptHeader header="ailments" />
      </template>
      <template #body="{ data, field, index }">
        <AttemptCellGroup
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
        <AttemptHeader header="generation" />
      </template>
      <template #body="{ data, field, index }">
        <AttemptCellUnit
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
        <AttemptHeader header="is-subspecies" />
      </template>
      <template #body="{ data, field, index }">
        <AttemptCellUnit
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
