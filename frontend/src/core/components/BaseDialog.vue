<script setup lang="ts">
  import { useTemplateRef } from 'vue';

  import BaseCloseButton from '@/core/components/BaseCloseButton.vue';

  defineOptions({ inheritAttrs: false });
  defineProps<{ color: string }>();

  const dialog = useTemplateRef('dialog');

  defineExpose({ dialog });
</script>

<template>
  <slot :dialog name="open" />
  <dialog
    v-bind="$attrs"
    ref="dialog"
    class="pointer-events-none flex place-self-center justify-self-center rounded-lg bg-slate-800 opacity-0 transition-opacity duration-300 backdrop:bg-transparent open:pointer-events-auto open:opacity-100 open:drop-shadow-[0_0_3px_black]"
  >
    <div class="absolute top-1 right-2">
      <BaseCloseButton :color @click="dialog?.close()" />
    </div>

    <slot />
  </dialog>
</template>
