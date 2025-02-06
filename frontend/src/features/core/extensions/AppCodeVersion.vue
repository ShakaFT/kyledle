<script setup lang="ts">
  import AppCode from '@/features/core/components/AppCode.vue';

  const appVersion = APP_VERSION;
</script>

<template>
  <AppCode>
    {{ appVersion }}
  </AppCode>
</template>
