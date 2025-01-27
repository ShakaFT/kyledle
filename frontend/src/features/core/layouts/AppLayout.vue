<script setup lang="ts">
  import AppBackground from '@/features/core/components/AppBackground.vue';
  import AppLogo from '@/features/core/components/AppLogo.vue';

  defineProps<{ stopAnimation?: () => void }>();
</script>

<template>
  <AppBackground class="overflow-y-scroll">
    <div class="grid justify-center justify-items-center py-10">
      <AppLogo class="mb-10" @click="stopAnimation?.()" />
      <slot />
    </div>
  </AppBackground>
</template>
