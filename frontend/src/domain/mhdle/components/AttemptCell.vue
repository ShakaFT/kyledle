<script setup lang="ts">
  defineProps<{ body: string }>();
</script>

<template>
  <div
    :class="[
      /* layout */
      'bg-slate-300',
      'border-[1px]',
      'border-slate-800',
      'content-center',
      'h-16',
      'm-1',
      'rounded-lg',
      /* typography */
      'font-[BluuNext]',
      'text-center',
      'text-sm',
      /* misc */
      'drop-shadow-lg',
    ]"
  >
    {{ body }}
  </div>
</template>
