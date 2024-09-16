<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  import Column from 'primevue/column';
  import DataTable from 'primevue/datatable';
  import { useI18n } from 'vue-i18n';

  import { useCurrentGame } from '@/core/composables/useCurrentGame';
  import AttemptCell from '@/domain/mhdle/components/AttemptCell.vue';
  import AttemptHeader from '@/domain/mhdle/components/AttemptHeader.vue';

  defineProps<{ characters: MHdleCharacter[] }>();

  const { game } = useCurrentGame();
  const { t } = useI18n();

  const translateOf = <T extends string>({
    field,
    data,
  }: {
    field: T;
    data: Record<T, string>;
  }): string => t(`${game.value}.${field}.${data[field]}`);

  const translateManyOf = <T extends string>({
    field,
    data,
  }: {
    field: T;
    data: Record<T, string[]>;
  }): string =>
    data[field]
      .map((element) => t(`${game.value}.${field}.${element}`))
      .join(', ');
</script>

<template>
  <DataTable
    :pt="{
      root: { class: 'mt-6' },
      tableContainer: { class: '!overflow-visible flex justify-center' },
      table: { class: 'table-fixed w-[70%]' },
    }"
    :value="characters"
  >
    <Column field="id">
      <template #header>
        <AttemptHeader header="id" />
      </template>
      <template #body="body">
        <AttemptCell :body="translateOf(body)" />
      </template>
    </Column>

    <Column field="picture">
      <template #header>
        <AttemptHeader header="picture" />
      </template>
      <template #body>
        <AttemptCell body="" />
      </template>
    </Column>

    <Column field="monster-type">
      <template #header>
        <AttemptHeader header="monster-type" />
      </template>
      <template #body="body">
        <AttemptCell :body="translateOf(body)" />
      </template>
    </Column>

    <Column field="elements">
      <template #header>
        <AttemptHeader header="elements" />
      </template>
      <template #body="body">
        <AttemptCell :body="translateManyOf(body)" />
      </template>
    </Column>

    <Column field="weaknesses">
      <template #header>
        <AttemptHeader header="weaknesses" />
      </template>
      <template #body="body">
        <AttemptCell :body="translateManyOf(body)" />
      </template>
    </Column>

    <Column field="ailments">
      <template #header>
        <AttemptHeader header="ailments" />
      </template>
      <template #body="body">
        <AttemptCell :body="translateManyOf(body)" />
      </template>
    </Column>

    <Column field="generation">
      <template #header>
        <AttemptHeader header="generation" />
      </template>
      <template #body="body">
        <AttemptCell :body="translateOf(body)" />
      </template>
    </Column>

    <Column field="is-subspecies">
      <template #header>
        <AttemptHeader header="is-subspecies" />
      </template>
      <template #body="body">
        <AttemptCell :body="translateOf(body)" />
      </template>
    </Column>
  </DataTable>
</template>
