<script setup lang="ts">
  import { useGameRoute } from '@/features/core/composables/game';

  const { disabled = false } = defineProps<{
    mode: string;
    disabled?: boolean;
  }>();

  const { game } = useGameRoute();
</script>

<template>
  <RouterLink
    class="relative m-2 duration-300 will-change-transform hover:scale-105"
    :to="!disabled ? `/${game}/${mode}` : ''"
  >
    <button
      class="w-52 rounded-lg bg-slate-800 p-2 font-[BluuNext] text-4xl text-slate-300 drop-shadow-[0_0_3px_#1e293b]"
      :class="{ 'opacity-50': disabled }"
      type="button"
    >
      {{ !disabled ? $t(`${game}.mode.${mode}`) : '🚧' }}
    </button>
  </RouterLink>
</template>
