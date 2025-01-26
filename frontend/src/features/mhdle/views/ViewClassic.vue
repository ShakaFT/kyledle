<script setup lang="ts">
  import AppLayout from '@/features/core/layouts/AppLayout.vue';
  import ClassicAttemptTable from '@/features/mhdle/components/ClassicAttemptTable.vue';
  import ClassicHintsIcon from '@/features/mhdle/components/ClassicHintsIcon.vue';
  import ClassicSearchBar from '@/features/mhdle/components/ClassicSearchBar.vue';
  import ClassicVictoryDialog from '@/features/mhdle/components/ClassicVictoryDialog.vue';
  import { useGameStore } from '@/stores/useGameStore';

  const { isAnimationEnabled } = useGameStore();
</script>

<template>
  <AppLayout :stop-animation="() => (isAnimationEnabled = false)">
    <div class="relative">
      <ClassicSearchBar />
      <ClassicHintsIcon />
    </div>
    <ClassicAttemptTable />
    <ClassicVictoryDialog />
  </AppLayout>
</template>
