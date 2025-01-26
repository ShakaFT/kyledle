<script setup lang="ts">
  import { onClickOutside, onKeyStroke } from '@vueuse/core';
  import { ref, useTemplateRef } from 'vue';

  import AppDialogButtonClose from '@/features/core/components/AppDialogButtonClose.vue';

  defineOptions({ inheritAttrs: false });
  defineProps<{ color: string }>();

  const isOpen = ref(false);
  const dialog = useTemplateRef('dialog');

  const show = () => (isOpen.value = true);
  const close = () => (isOpen.value = false);

  onClickOutside(dialog, close);
  onKeyStroke('Escape', () => {
    if (isOpen.value) close();
  });

  defineExpose({ show, close });
</script>

<template>
  <slot name="to-open" />
  <div class="absolute inset-0" :class="{ 'pointer-events-none': !isOpen }">
    <div
      ref="dialog"
      v-bind="$attrs"
      class="absolute inset-0 flex place-self-center justify-self-center rounded-lg bg-slate-800 transition-opacity duration-300"
      :class="
        isOpen
          ? 'pointer-events-auto opacity-100 drop-shadow-[0_0_3px_black]'
          : 'pointer-events-none opacity-0'
      "
    >
      <div class="absolute top-1 right-2">
        <AppDialogButtonClose :color @click="close" />
      </div>

      <slot />
    </div>
  </div>
</template>
