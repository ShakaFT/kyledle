<script setup lang="ts">
  import BaseBackground from '@/core/components/BaseBackground.vue';
  import BaseLogo from '@/core/components/BaseLogo.vue';
</script>

<template>
  <BaseBackground>
    <div class="grid justify-center justify-items-center">
      <BaseLogo class="mb-10 mt-2" />
      <slot />
    </div>
  </BaseBackground>
</template>
