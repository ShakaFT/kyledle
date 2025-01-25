<script setup lang="ts">
  import AppParagraph from '@/features/core/components/AppParagraph.vue';
  import AppTitle from '@/features/core/components/AppTitle.vue';
</script>

<template>
  <AppTitle class="my-6" keypath="mhdle.credits.contributions" />

  <AppParagraph
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
  <AppParagraph
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
  <AppParagraph
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
