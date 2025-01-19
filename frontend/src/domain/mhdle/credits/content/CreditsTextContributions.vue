<script setup lang="ts">
  import CreditsParagraph from '@/domain/mhdle/credits/content/CreditsParagraph.vue';
  import CreditsTitle from '@/domain/mhdle/credits/content/CreditsTitle.vue';
</script>

<template>
  <CreditsTitle class="my-6" keypath="mhdle.credits.contributions" />

  <CreditsParagraph
    :args="[
      {
        slot: 'link1',
        tag: 'a',
        href: 'https://monsterhunter.fandom.com/wiki/Monster_Hunter_Wiki',
        term: 'Monster Hunter Wiki',
      },
      {
        slot: 'link2',
        tag: 'a',
        href: 'https://mogapedia.fandom.com/fr/wiki/Monster_Hunter_Wiki',
        term: 'Mogapédia',
      },
      {
        slot: 'link3',
        tag: 'a',
        href: 'https://mhworld.kiranico.com/fr',
        term: 'Kiranico',
      },
      {
        slot: 'link4',
        tag: 'a',
        href: 'https://monsterbuddy.app/',
        term: 'Monster Buddy',
      },
    ]"
    keypath="mhdle.credits.contributions.description1"
  />
  <CreditsParagraph
    :args="[
      {
        slot: 'contributor1',
        tag: 'a',
        href: 'https://www.patreon.com/c/abbbbbbk',
        term: 'abbbbbbk',
      },
    ]"
    keypath="mhdle.credits.contributions.description2"
  />
  <CreditsParagraph
    :args="[
      {
        slot: 'contributor2',
        tag: 'span',
        term: 'Oceaniz96',
      },
      {
        slot: 'contributor3',
        tag: 'span',
        term: 'PostCoitalSensations',
      },
    ]"
    keypath="mhdle.credits.contributions.description3"
  />
</template>
