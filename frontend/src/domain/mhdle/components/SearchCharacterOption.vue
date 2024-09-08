<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  export interface SelectableCharacter {
    character: MHdleCharacter;
    translation: string;
    matchingAt: number[];
  }

  defineProps<{ option: SelectableCharacter }>();
</script>

<template>
  <span class="text-black/50">
    {{ option.translation.substring(0, option.matchingAt[0]) }}
  </span>
  <span>
    {{
      option.translation.substring(option.matchingAt[0], option.matchingAt[1])
    }}
  </span>
  <span class="text-black/50">
    {{ option.translation.substring(option.matchingAt[1]) }}
  </span>
</template>
