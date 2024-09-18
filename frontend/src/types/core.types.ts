export type PickMatching<T, V> = {
  [K in keyof T as T[K] extends V ? K : never]: T[K];
};

export type OmitMatching<T, V> = {
  [K in keyof T as T[K] extends V ? never : K]: T[K];
};
