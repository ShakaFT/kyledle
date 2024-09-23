import { computed } from 'vue';
import { useRoute } from 'vue-router';

export const useCurrentGame = () => {
  const route = useRoute();

  return {
    game: computed(() => route.path.split('/')[1]),
  };
};
