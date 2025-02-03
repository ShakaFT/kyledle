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
    :to="`/${game}/${mode}`"
  >
    <button
      class="w-52 rounded-lg bg-slate-800 p-2 font-[BluuNext] text-4xl text-slate-300 drop-shadow-[0_0_3px_#1e293b]"
      :class="{ 'opacity-50': disabled }"
      type="button"
    >
      {{ $t(`${game}.mode.${mode}`) }}
    </button>

    <div
      v-if="disabled"
      class="pointer-events-none absolute -top-1.5 -right-3.5 h-fit w-fit rotate-[15deg] rounded-lg bg-slate-800"
    >
      <span class="p-1.5 font-[YoungSerif] text-slate-500">
        {{ $t('core.development.soon') }}
      </span>
    </div>
  </RouterLink>
</template>
