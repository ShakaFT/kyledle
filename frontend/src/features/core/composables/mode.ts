import { computed } from 'vue';
import { useRoute } from 'vue-router';

export const useModeRoute = () => {
  const route = useRoute();

  return {
    mode: computed(() => route.path.split('/')[2]),
  };
};
