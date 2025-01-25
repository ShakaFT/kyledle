<script setup lang="ts">
  import AppLayout from '@/features/core/layouts/AppLayout.vue';
  import ClassicAttemptTable from '@/features/mhdle/components/ClassicAttemptTable.vue';
  import ClassicSearchBar from '@/features/mhdle/components/ClassicSearchBar.vue';
  import ClassicVictoryDialog from '@/features/mhdle/components/ClassicVictoryDialog.vue';
  import { useGameStore } from '@/stores/useGameStore';

  const { isAnimationEnabled } = useGameStore();
</script>

<template>
  <AppLayout :stop-animation="() => (isAnimationEnabled = false)">
    <ClassicSearchBar />
    <ClassicAttemptTable />
    <ClassicVictoryDialog />
  </AppLayout>
</template>
