<script setup lang="ts">
  import { ref } from 'vue';

  import CreditsIcon from '@/domain/mhdle/credits/CreditsIcon.vue';

  const isVisible = ref(false);
</script>

<template>
  <CreditsIcon @click="isVisible = true" />
  <dialog
    v-if="isVisible"
    class="inset-0 flex h-[50%] w-[60%] animate-fade rounded-lg bg-slate-800 drop-shadow-lg animate-duration-300"
  >
    <div class="absolute right-2 top-1">
      <button
        class="text-xl text-transparent opacity-85 hover:animate-jump hover:animate-duration-500 hover:animate-once"
        style="text-shadow: 0 0 0 #cbd5e1"
        @click="isVisible = false"
      >
        ✖️
      </button>
    </div>

    <div class="overflow-scroll p-12 font-[BagnardSans] text-slate-300">
      <!-- About -->
      <h1 class="mb-6 font-[YoungSerif] text-4xl">
        {{ $t('mhdle.credits.about') }}
      </h1>

      <p>
        {{ $t('mhdle.credits.about.description1') }}
      </p>

      <p class="mt-5">
        {{ $t('mhdle.credits.about.description2') }}
      </p>

      <i18n-t
        class="mt-5"
        keypath="mhdle.credits.about.description3"
        scope="global"
        tag="p"
      >
        <template #link>
          <a
            class="italic transition duration-300 hover:text-red-700"
            href="https://www.monsterhunter.com/"
            target="_blank"
          >
            {{ $t('mhdle.credits.about.description3.link') }}
          </a>
        </template>
      </i18n-t>

      <p class="mt-5">
        {{ $t('mhdle.credits.about.description4') }}
      </p>

      <!-- Contributions -->
      <h1 class="my-6 font-[YoungSerif] text-4xl">
        {{ $t('mhdle.credits.contributions') }}
      </h1>

      <i18n-t
        keypath="mhdle.credits.contributions.description1"
        scope="global"
        tag="p"
      >
        <template #link1>
          <a
            class="italic transition duration-300 hover:text-red-700"
            href="https://monsterhunter.fandom.com/wiki/Monster_Hunter_Wiki"
            target="_blank"
          >
            {{ 'Monster Hunter Wiki' }}
          </a>
        </template>
        <template #link2>
          <a
            class="italic transition duration-300 hover:text-red-700"
            href="https://mogapedia.fandom.com/fr/wiki/Monster_Hunter_Wiki"
            target="_blank"
          >
            {{ 'Mogapédia' }}
          </a>
        </template>
        <template #link3>
          <a
            class="italic transition duration-300 hover:text-red-700"
            href="https://mhworld.kiranico.com/fr"
            target="_blank"
          >
            {{ 'Kiranico' }}
          </a>
        </template>
        <template #link4>
          <a
            class="italic transition duration-300 hover:text-red-700"
            href="https://monsterbuddy.app/"
            target="_blank"
          >
            {{ 'Monster Buddy' }}
          </a>
        </template>
      </i18n-t>

      <i18n-t
        class="mt-5"
        keypath="mhdle.credits.contributions.description2"
        scope="global"
        tag="p"
      >
        <template #contributor1>
          <a
            class="italic transition duration-300 hover:text-red-700"
            href="https://www.patreon.com/c/abbbbbbk"
            target="_blank"
          >
            {{ 'abbbbbbk' }}
          </a>
        </template>
      </i18n-t>

      <i18n-t
        class="mt-5"
        keypath="mhdle.credits.contributions.description3"
        scope="global"
        tag="p"
      >
        <template #contributor2>
          <span class="italic">
            {{ 'Oceaniz96' }}
          </span>
        </template>
        <template #contributor3>
          <span class="italic">
            {{ 'PostCoitalSensations' }}
          </span>
        </template>
      </i18n-t>

      <!-- Development -->
      <div class="my-6 flex place-items-center gap-4">
        <h1 class="font-[YoungSerif] text-4xl">
          {{ $t('mhdle.credits.development') }}
        </h1>
        <code
          class="mt-[5px] rounded-[4px] bg-slate-900 px-1 font-[courier_,_monospace] text-base text-slate-500"
        >
          {{ 'v2.0.0' }}
        </code>
      </div>

      <i18n-t
        keypath="mhdle.credits.development.description"
        scope="global"
        tag="p"
      >
        <template #developer1>
          <a
            class="italic transition duration-300 hover:text-red-700"
            href="https://github.com/Nonudian"
            target="_blank"
          >
            {{ 'nonudian' }}
          </a>
        </template>
        <template #developer2>
          <a
            class="italic transition duration-300 hover:text-red-700"
            href="https://github.com/ShakaFT"
            target="_blank"
          >
            {{ 'shakaft' }}
          </a>
        </template>
      </i18n-t>
    </div>
  </dialog>
</template>

<style scoped>
  ::-webkit-scrollbar {
    width: 0px;
  }
</style>
