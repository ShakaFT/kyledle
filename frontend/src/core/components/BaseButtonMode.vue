<script setup lang="ts">
  import { useCurrentGame } from '@/core/composables/useCurrentGame';

  withDefaults(defineProps<{ mode: string; disabled?: boolean }>(), {
    disabled: false,
  });

  const { gameId } = useCurrentGame();
</script>

<template>
  <button
    :class="[
      /* animation */
      'duration-500',
      {
        [[
          /* hover states */
          'hover:bg-gray-800',
          /* animation */
          'hover:duration-200',
          'hover:ease-out',
          'hover:transition',
        ].join(' ')]: !disabled,
      },
      /* layout */
      'bg-black',
      'm-2',
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
    <RouterLink :to="`/${gameId}/${mode}`">
      {{ $t(`${gameId}.mode.${mode}`) }}
    </RouterLink>
  </button>
</template>
