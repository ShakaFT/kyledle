<script setup lang="ts">
  defineProps<{ count: number; open: boolean }>();
</script>

<template>
  <dialog :open>
    <div
      class="fixed inset-0 flex h-screen -rotate-3 flex-col items-center justify-center"
    >
      <div
        :class="[
          'animate-duration-300',
          'animate-jump-in',
          'bg-slate-800',
          'drop-shadow-lg',
          'p-9',
          'rounded-lg',
          'text-center',
        ]"
      >
        <h1 class="font-[BluuNext] text-5xl text-green-400">Bravo !</h1>
        <p class="font-[BluuNext] text-xl text-green-400">
          Vous avez trouvé le monstre du jour en {{ count }} tentative(s).
        </p>
      </div>
    </div>
  </dialog>
</template>
