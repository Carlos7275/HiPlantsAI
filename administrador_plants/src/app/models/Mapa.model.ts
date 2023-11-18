export interface Mapa {
  id: number
  id_planta: number
  zona: string
  latitud: number
  longitud: number
  url_imagen: string
  estatus: number
  created_at: string
  info_plantas: InfoPlantas
}

export interface InformacionPlanta {
  id: number
  nombre_planta: string
  nombre_cientifico: string
  toxicidad: any
  año: number
  familia: string
  nombres_comunes: NombresComunes
  distribucion: Distribucion
  colores: any
  humedad_atmosferica?: string
  cantidad_luz: string
  meses_crecimiento: any
  genero: string
  estatus: number
  id_planta: number
  zona: string
  latitud: number
  longitud: number
  url_imagen: string
  created_at: string
}

export interface InfoPlantas {
  id: number
  nombre_planta: string
  nombre_cientifico: string
  toxicidad: any
  año: number
  familia: string
  nombres_comunes: NombresComunes
  distribucion: Distribucion
  colores: any
  humedad_atmosferica?: string
  cantidad_luz: string
  meses_crecimiento: any
  genero: string
  estatus: string
}

export interface NombresComunes {
  dan?: string[]
  eng: string[]
  tur?: string[]
  deu: string[]
  spa: string[]
  ita?: string[]
  heb?: string[]
  fra: string[]
  swa: string[]
  por: string[]
  ell?: string[]
  hun?: string[]
  ces?: string[]
  swe: string[]
  nld?: string[]
  sme?: string[]
  cym?: string[]
  en: string[]
  af: string[]
  sq: string[]
  am: string[]
  ar: string[]
  hy: string[]
  az: string[]
  eu: string[]
  be: string[]
  bn: string[]
  bs?: string[]
  br: string[]
  bg: string[]
  my: string[]
  ca: string[]
  zh: string[]
  cv: string[]
  kw?: string[]
  hr: string[]
  cs: string[]
  da: string[]
  nl: string[]
  eo: string[]
  et: string[]
  fi: string[]
  fr: string[]
  gl: string[]
  ka: string[]
  de: string[]
  el: string[]
  ha: string[]
  he: string[]
  hi: string[]
  hu: string[]
  io: string[]
  id: string[]
  ie?: string[]
  ga: string[]
  it: string[]
  ja?: string[]
  jv: string[]
  ko: string[]
  ku: string[]
  lv: string[]
  lt: string[]
  lb: string[]
  mk: string[]
  mg: string[]
  ms: string[]
  ml: string[]
  mr: string[]
  mn: string[]
  nv: string[]
  ne: string[]
  se?: string[]
  no: string[]
  oc?: string[]
  os?: string[]
  pa: string[]
  ps: string[]
  fa: string[]
  pl: string[]
  pt: string[]
  "pt-br": string[]
  qu: string[]
  ro: string[]
  ru: string[]
  sc?: string[]
  gd?: string[]
  sr: string[]
  sn?: string[]
  sd: string[]
  sk: string[]
  es: string[]
  su: string[]
  sw: string[]
  sv: string[]
  tl: string[]
  "zh-tw": string[]
  ta: string[]
  tt: string[]
  te: string[]
  th: string[]
  bo: string[]
  tr: string[]
  ug?: string[]
  uk: string[]
  ur: string[]
  vi: string[]
  cy: string[]
  msa?: string[]
  ak?: string[]
  bi?: string[]
  dv?: string[]
  fj?: string[]
  gn?: string[]
  gu?: string[]
  ht?: string[]
  is?: string[]
  ig?: string[]
  ia?: string[]
  kn?: string[]
  kk?: string[]
  km?: string[]
  lo?: string[]
  li?: string[]
  ln?: string[]
  mt?: string[]
  gv?: string[]
  mi?: string[]
  or?: string[]
  sa?: string[]
  si?: string[]
  so?: string[]
  ty?: string[]
  to?: string[]
  "zh-hant"?: string[]
  fy?: string[]
  wo?: string[]
  yi?: string[]
  yo?: string[]
}

export interface Distribucion {
  native: Native[]
  introduced: Introduced[]
}

export interface Native {
  id: number
  name: string
  slug: string
  tdwg_code: string
  tdwg_level: number
  species_count: number
  links: Links
}

export interface Links {
  self: string
  plants: string
  species: string
}

export interface Introduced {
  id: number
  name: string
  slug: string
  tdwg_code: string
  tdwg_level: number
  species_count: number
  links: Links2
}

export interface Links2 {
  self: string
  plants: string
  species: string
}
