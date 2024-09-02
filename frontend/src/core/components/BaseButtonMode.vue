<script setup lang="ts">
  import { computed } from 'vue';

  import { useGameFromUrl } from '@/core/composables/useGameFromUrl';

  const props = withDefaults(
    defineProps<{ mode: string; disabled?: boolean }>(),
    { disabled: false },
  );

  const { game } = useGameFromUrl();

  const link = computed(() => `/${game.value}/${props.mode}`);
</script>

<template>
  <RouterLink :to="link">
    <button class="button" :class="{ disabled }" type="button">
      {{ $t(`${game}.mode.${mode}`) }}
    </button>
  </RouterLink>
</template>

<style scoped lang="postcss">
  .button {
    @apply m-2 w-52 rounded-lg bg-black p-2 font-[BluuNext] text-4xl text-white mix-blend-multiply backdrop-blur-md backdrop-brightness-125 transition duration-300 ease-out;
  }

  .disabled {
    @apply opacity-50;
  }

  :not(.disabled).button:hover {
    @apply bg-gray-800 transition duration-300 ease-out;
  }
</style>
