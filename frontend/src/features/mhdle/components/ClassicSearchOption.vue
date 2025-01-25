<script setup lang="ts">
  import type { MHdleCharacter } from '@/types/mhdle.types';

  export interface SelectableCharacter {
    character: MHdleCharacter;
    translation: string;
    matchingAt: [number, number];
  }

  defineProps<{ option: SelectableCharacter }>();
</script>

<template>
  <div class="m-1 flex place-items-center gap-2">
    <img class="h-14 w-14" :src="option.character.picture" />
    <div>
      <span class="text-black/50">
        {{ option.translation.substring(0, option.matchingAt[0]) }}
      </span>
      <span>
        {{
          option.translation.substring(
            option.matchingAt[0],
            option.matchingAt[1],
          )
        }}
      </span>
      <span class="text-black/50">
        {{ option.translation.substring(option.matchingAt[1]) }}
      </span>
    </div>
  </div>
</template>
