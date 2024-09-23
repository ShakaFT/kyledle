import { computed } from 'vue';
import { useRoute } from 'vue-router';

export const useCurrentMode = () => {
  const route = useRoute();

  return {
    mode: computed(() => route.path.split('/')[2]),
  };
};
