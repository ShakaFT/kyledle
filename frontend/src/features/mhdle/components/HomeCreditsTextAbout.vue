<script setup lang="ts">
  import AppParagraph from '@/features/core/components/AppParagraph.vue';
  import AppTitle from '@/features/core/components/AppTitle.vue';
</script>

<template>
  <AppTitle class="mb-6" keypath="mhdle.credits.about" />

  <AppParagraph keypath="mhdle.credits.about.description1" />
  <AppParagraph keypath="mhdle.credits.about.description2" />
  <AppParagraph
    :args="[
      {
        slot: 'link',
        tag: 'a',
        href: 'https://www.monsterhunter.com/',
        term: `${$t('mhdle.credits.about.description3.link')}`,
      },
    ]"
    keypath="mhdle.credits.about.description3"
  />
</template>
