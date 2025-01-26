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
  <div
    class="m-1 flex cursor-pointer place-items-center gap-2 rounded-md transition-colors duration-300 hover:bg-slate-700"
  >
    <img
      class="hover:animate-duration-500 hover:animate-wiggle hover:animate-infinite h-14 w-14"
      :src="option.character.picture"
    />
    <div>
      <span class="text-slate-500">
        {{ option.translation.substring(0, option.matchingAt[0]) }}
      </span>
      <span class="text-slate-300">
        {{
          option.translation.substring(
            option.matchingAt[0],
            option.matchingAt[1],
          )
        }}
      </span>
      <span class="text-slate-500">
        {{ option.translation.substring(option.matchingAt[1]) }}
      </span>
    </div>
  </div>
</template>
