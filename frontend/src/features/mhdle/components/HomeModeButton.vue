<script setup lang="ts">
  import { useGameRoute } from '@/features/core/composables/game';

  const { disabled = false } = defineProps<{
    mode: string;
    disabled?: boolean;
  }>();

  const { game } = useGameRoute();
</script>

<template>
  <RouterLink class="m-2" :to="`/${game}/${mode}`">
    <button
      class="w-52 rounded-lg bg-slate-800 p-2 font-[BluuNext] text-4xl text-slate-300 mix-blend-hard-light drop-shadow-[0_0_3px_#1e293b] backdrop-blur-xl duration-300 hover:scale-105"
      :class="{ 'opacity-30': disabled }"
      type="button"
    >
      {{ $t(`${game}.mode.${mode}`) }}
    </button>
  </RouterLink>
</template>
