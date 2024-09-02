import { computed } from 'vue';
import { useRoute } from 'vue-router';

export const useGameId = () => {
  const route = useRoute();

  return {
    gameId: computed(() => route.path.split('/')[1]),
  };
};
