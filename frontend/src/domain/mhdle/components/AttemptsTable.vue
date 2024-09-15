<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import Column from 'primevue/column';
  import DataTable from 'primevue/datatable';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  defineProps<{ characters: MHdleCharacter[] }>();

  const { gameId } = useCurrentGame();

  //TODO: fetch columns from backend
  const columns = [
    'id',
    'picture',
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
    :pt="{
      root: {
        class: 'mt-6',
      },
      tableContainer: {
        class: '!overflow-visible flex justify-center',
      },
      table: {
        class: 'table-fixed w-[70%]',
      },
    }"
    :value="characters"
  >
    <Column v-for="column in columns" :key="column" :field="column">
      <template #header>
        <div
          :class="[
            /* layout */
            'bg-slate-800',
            'mb-3',
            'mx-1',
            'py-2',
            'rounded-lg',
            /* typography */
            'font-[BluuNext]',
            'text-slate-300',
            /* misc */
            'drop-shadow-[0_0_3px_#e0d9ca]',
          ]"
        >
          {{ $t(`${gameId}.${column}`) }}
        </div>
      </template>
      <template #body="{ data }">
        <div
          :class="[
            /* layout */
            'bg-slate-300',
            'border-[1px]',
            'border-slate-800',
            'content-center',
            'h-16',
            'm-1',
            'rounded-lg',
            /* typography */
            'font-[BluuNext]',
            'text-center',
            'text-sm',
            /* misc */
            'drop-shadow-lg',
          ]"
        >
          {{
            Array.isArray(data[column])
              ? data[column]
                  .map((element) => $t(`${gameId}.${column}.${element}`))
                  .join('')
              : column === 'picture'
                ? ''
                : $t(`${gameId}.${column}.${data[column]}`)
          }}
        </div>
      </template>
    </Column>
  </DataTable>
</template>
