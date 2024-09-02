import type { GameDataOf } from '@/types/core.types';

export type MHdleData = GameDataOf<MHdleMode[], MHdleCharacter[]>;

export type MHdleMode = 'classic' | 'denomination' | 'shape' | 'soundtrack';

export interface MHdleCharacter {
  ailments: string[];
  'average-size': number;
  colors: string[];
  elements: string[];
  generation: string;
  id: string;
  'is-subspecies': boolean;
  'monster-type': string;
  picture: string;
  weaknesses: string[];
}
