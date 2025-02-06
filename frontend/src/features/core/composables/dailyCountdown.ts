import {
  addDay,
  addSecond,
  dayStart,
  diffSeconds,
  format,
} from '@formkit/tempo';
import { useCountdown } from '@vueuse/core';
import { computed } from 'vue';

export const useDailyCountdown = () => {
  const now = new Date();
  const midnight = dayStart(addDay(now));

  const diffInSeconds = diffSeconds(midnight, now, 'floor');

  const { remaining } = useCountdown(diffInSeconds, { immediate: true });

  return {
    countdown: computed(() =>
      format(addSecond(midnight, remaining.value), { time: 'medium' }),
    ),
  };
};
