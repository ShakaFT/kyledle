<script setup lang="ts">
  import AppParagraph from '@/features/core/components/AppParagraph.vue';
  import AppTitle from '@/features/core/components/AppTitle.vue';
</script>

<template>
  <div class="my-6 flex place-items-center gap-4">
    <AppTitle keypath="mhdle.credits.development" />
    <code
      class="mt-[5px] rounded-[4px] bg-slate-900 px-1 font-[courier_,_monospace] text-base text-slate-500"
    >
      {{ 'v2.0.0' }}
    </code>
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
  <AppParagraph keypath="mhdle.credits.development.description2" />
  <AppParagraph is-last keypath="mhdle.credits.development.description3" />
</template>
