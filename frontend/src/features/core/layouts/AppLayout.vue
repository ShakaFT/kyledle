<script setup lang="ts">
  import AppBackground from '@/features/core/components/AppBackground.vue';
  import AppLogo from '@/features/core/components/AppLogo.vue';

  defineProps<{ stopAnimation?: () => void }>();
</script>

<template>
  <AppBackground class="overflow-scroll">
    <div class="my-10 grid justify-center justify-items-center">
      <AppLogo class="mb-10" @click="stopAnimation?.()" />
      <slot />
    </div>
  </AppBackground>
</template>
