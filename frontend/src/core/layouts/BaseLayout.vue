<script setup lang="ts">
  import BaseBackground from '@/core/components/BaseBackground.vue';
  import BaseLogo from '@/core/components/BaseLogo.vue';
</script>

<template>
  <BaseBackground class="overflow-scroll">
    <div class="my-10 grid justify-center justify-items-center">
      <BaseLogo class="mb-10" />
      <slot />
    </div>
  </BaseBackground>
</template>
