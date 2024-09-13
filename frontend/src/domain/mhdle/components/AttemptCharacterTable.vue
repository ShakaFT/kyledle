<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import Column from 'primevue/column';
  import DataTable from 'primevue/datatable';

  import { useGameId } from '@/core/composables/useGameId';

  defineProps<{ characters: MHdleCharacter[] }>();

  const { gameId } = useGameId();

  //TODO: fetch columns from backend
  const columns = [
    'id',
    // 'picture',
    'monster-type',
    'elements',
    'weaknesses',
    'ailments',
    'generation',
    'is-subspecies',
  ];
</script>

<template>
  <DataTable
    :value="characters"
    :pt:table-container:class="['!overflow-visible', 'mt-6']"
  >
    <Column v-for="column in columns" :key="column" :field="column">
      <template #header>
        <div
          :class="[
            /* layout */
            'bg-slate-300',
            'mb-4',
            'mx-1',
            'px-4',
            'py-2',
            'rounded-lg',
            /* typography */
            'font-[BluuNext]',
            /* misc */
            'drop-shadow-lg',
          ]"
        >
          {{ $t(`${gameId}.${column}`) }}
        </div>
      </template>
    </Column>
  </DataTable>
</template>
