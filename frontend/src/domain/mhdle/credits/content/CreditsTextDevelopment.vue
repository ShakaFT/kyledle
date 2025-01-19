<script setup lang="ts">
  import CreditsParagraph from '@/domain/mhdle/credits/content/CreditsParagraph.vue';
  import CreditsTitle from '@/domain/mhdle/credits/content/CreditsTitle.vue';
</script>

<template>
  <div class="my-6 flex place-items-center gap-4">
    <CreditsTitle keypath="mhdle.credits.development" />
    <code
      class="mt-[5px] rounded-[4px] bg-slate-900 px-1 font-[courier_,_monospace] text-base text-slate-500"
    >
      {{ 'v2.0.0' }}
    </code>
  </div>

  <CreditsParagraph
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
    is-last
    keypath="mhdle.credits.development.description"
  />
</template>
