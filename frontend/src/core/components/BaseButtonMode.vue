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
        /* animation */
        'duration-500',
        {
          [[
            'hover:bg-gray-800',
            'hover:duration-200',
            'hover:ease-out',
            'hover:transition',
          ].join(' ')]: !disabled,
        },
        /* layout */
        'bg-black',
        'p-2',
        'rounded-lg',
        'w-52',
        /* misc */
        'backdrop-blur-md',
        'backdrop-brightness-125',
        'mix-blend-multiply',
        { ['opacity-50']: disabled },
        /* typography */
        'font-[BluuNext]',
        'text-4xl',
        'text-white',
      ]"
      type="button"
    >
      {{ $t(`${game}.mode.${mode}`) }}
    </button>
  </RouterLink>
</template>
