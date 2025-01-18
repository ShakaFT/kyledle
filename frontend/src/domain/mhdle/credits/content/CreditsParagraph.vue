<script setup lang="ts">
  type TranslationArgs =
    | {
        slot: string;
        tag: 'a';
        href: string;
        term: string;
      }
    | {
        slot: string;
        tag: 'span';
        term: string;
      };

  defineProps<{
    keypath: string;
    args?: Array<TranslationArgs>;
    isLast?: boolean;
  }>();
</script>

<template>
  <div :class="isLast ? 'mt-5' : 'my-5'">
    <i18n-t v-if="args" :keypath :scope="`global`" tag="p">
      <template v-for="translation in args" #[translation.slot]>
        <template v-if="translation.tag === 'a'">
          <a
            :key="translation.slot"
            class="italic transition duration-300 hover:text-red-700"
            :href="translation.href"
            target="_blank"
          >
            {{ `${translation.term}` }}
          </a>
        </template>

        <template v-if="translation.tag === 'span'">
          <span :key="translation.slot" class="italic">
            {{ `${translation.term}` }}
          </span>
        </template>
      </template>
    </i18n-t>

    <p v-else>{{ $t(`${keypath}`) }}</p>
  </div>
</template>
