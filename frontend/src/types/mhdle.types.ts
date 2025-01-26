export type MHdleMode = 'classic' | 'denomination' | 'shape' | 'soundtrack';

export interface MHdleCharacter {
  ailments: ArrayWithPictureLink;
  'average-size': number;
  colors: string[];
  elements: ArrayWithPictureLink;
  generation: string;
  id: string;
  'is-subspecies': boolean;
  'monster-type': string;
  picture: string;
  weaknesses: ArrayWithPictureLink;
}

export type ArrayWithPictureLink = Array<{
  id: string;
  picture: string;
}>;

export type MHdleHint = 'average-size' | 'colors';
