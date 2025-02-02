<script setup lang="ts">
  import AppParagraph from '@/features/core/components/AppParagraph.vue';
  import AppTitle from '@/features/core/components/AppTitle.vue';
  import AppCodeVersion from '@/features/core/extensions/AppCodeVersion.vue';
</script>

<template>
  <div class="my-6 flex place-items-center gap-4">
    <AppTitle keypath="mhdle.credits.development" />
    <AppCodeVersion />
  </div>

  <AppParagraph
    :args="[
      {
        slot: 'developer1',
        tag: 'a',
        href: 'https://github.com/Nonudian',
        term: 'nonudian',
      },
      {
        slot: 'developer2',
        tag: 'a',
        href: 'https://github.com/ShakaFT',
        term: 'shakaft',
      },
    ]"
    keypath="mhdle.credits.development.description1"
  />
  <AppParagraph is-last keypath="mhdle.credits.development.description2" />
</template>
