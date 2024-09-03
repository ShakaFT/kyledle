<script setup lang="ts">
  import { useGameId } from '@/core/composables/useGameId';

  const props = withDefaults(
    defineProps<{ mode: string; disabled?: boolean }>(),
    { disabled: false },
  );

  const { gameId } = useGameId();
</script>

<template>
  <RouterLink :to="`/${gameId}/${props.mode}`">
    <button
      :class="[
        /* layout */
        'm-2',
        'p-2',
        /* border */
        'rounded-lg',
        'w-52',
        /* typography */
        'font-[BluuNext]',
        'text-4xl',
        'text-white',
        /* effects */
        'backdrop-blur-md',
        'backdrop-brightness-125',
        'bg-black',
        'mix-blend-multiply',
        /* animation */
        'duration-300',
        'ease-out',
        'transition',
        /* interaction */
        {
          [[
            'hover:bg-gray-800',
            'hover:duration-300',
            'hover:ease-out',
            'hover:transition',
          ].join(' ')]: !disabled,
        },
        /* disabled */
        { ['opacity-50']: disabled },
      ]"
      type="button"
    >
      {{ $t(`${gameId}.mode.${mode}`) }}
    </button>
  </RouterLink>
</template>
