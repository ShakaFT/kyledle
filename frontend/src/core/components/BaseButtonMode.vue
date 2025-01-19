<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  const { disabled = false } = defineProps<{
    mode: string;
    disabled?: boolean;
  }>();

  const { game } = useCurrentGame();
</script>

<template>
  <RouterLink class="m-2" :to="`/${game}/${mode}`">
    <button
      :class="[
        'backdrop-blur-xl',
        'bg-slate-800',
        'drop-shadow-[0_0_3px_#1e293b]',
        'duration-300',
        'font-[BluuNext]',
        'hover:scale-105',
        'mix-blend-hard-light',
        'p-2',
        'rounded-lg',
        'text-4xl',
        'text-slate-300',
        'w-52',
        disabled ? 'opacity-30' : 'hover:ease-out',
      ]"
      type="button"
    >
      {{ $t(`${game}.mode.${mode}`) }}
    </button>
  </RouterLink>
</template>
