<script setup lang="ts">
  import CreditsParagraph from '@/domain/mhdle/credits/content/CreditsParagraph.vue';
  import CreditsTitle from '@/domain/mhdle/credits/content/CreditsTitle.vue';
</script>

<template>
  <CreditsTitle class="mb-6" keypath="mhdle.credits.about" />

  <CreditsParagraph keypath="mhdle.credits.about.description1" />
  <CreditsParagraph keypath="mhdle.credits.about.description2" />
  <CreditsParagraph
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
  <CreditsParagraph keypath="mhdle.credits.about.description4" />
</template>
