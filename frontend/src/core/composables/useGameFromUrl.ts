import { computed } from 'vue';
import { useRoute } from 'vue-router';

export const useGameFromUrl = () => {
  const route = useRoute();

  return {
    game: computed(() => route.path.split('/')[1]),
  };
};
