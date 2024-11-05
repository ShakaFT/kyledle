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
        'backdrop-blur-md',
        'backdrop-brightness-125',
        'bg-black',
        'duration-500',
        'font-[BluuNext]',
        'mix-blend-multiply',
        'p-2',
        'rounded-lg',
        'text-4xl',
        'text-white',
        'w-52',
        disabled ? 'opacity-50' : 'hover:bg-red-800 hover:ease-out',
        Math.random() < 0.5 ? `hover:-rotate-2` : `hover:rotate-2`,
      ]"
      type="button"
    >
      {{ $t(`${game}.mode.${mode}`) }}
    </button>
  </RouterLink>
</template>
