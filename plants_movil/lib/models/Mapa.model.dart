class Mapa {
  int? id;
  int? idPlanta;
  String? zona;
  double? latitud;
  double? longitud;
  String? urlImagen;
  int? estatus;
  String? createdAt;
  InfoPlantas? infoPlantas;

  Mapa(
      {this.id,
      this.idPlanta,
      this.zona,
      this.latitud,
      this.longitud,
      this.urlImagen,
      this.estatus,
      this.createdAt,
      this.infoPlantas});

  Mapa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPlanta = json['id_planta'];
    zona = json['zona'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    urlImagen = json['url_imagen'];
    estatus = json['estatus'];
    createdAt = json['created_at'];
    infoPlantas = json['info_plantas'] != null
        ? new InfoPlantas.fromJson(json['info_plantas'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_planta'] = this.idPlanta;
    data['zona'] = this.zona;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['url_imagen'] = this.urlImagen;
    data['estatus'] = this.estatus;
    data['created_at'] = this.createdAt;
    if (this.infoPlantas != null) {
      data['info_plantas'] = this.infoPlantas!.toJson();
    }
    return data;
  }
}

class InfoPlantas {
  int? id;
  String? nombrePlanta;
  String? nombreCientifico;
  String? urlImagen;
  Null toxicidad;
  bool? comestible;
  bool? vegetable;
  int? aO;
  String? familia;
  List<String>? colores;
  String? humedadAtmosferica;
  String? cantidadLuz;
  Null? mesesCrecimiento;
  String? genero;
  String? estatus;
  String? createdAt;

  InfoPlantas(
      {this.id,
      this.nombrePlanta,
      this.nombreCientifico,
      this.urlImagen,
      this.toxicidad,
      this.comestible,
      this.vegetable,
      this.aO,
      this.familia,
      this.colores,
      this.humedadAtmosferica,
      this.cantidadLuz,
      this.mesesCrecimiento,
      this.genero,
      this.estatus,
      this.createdAt});

  InfoPlantas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombrePlanta = json['nombre_planta'];
    nombreCientifico = json['nombre_cientifico'];
    urlImagen = json['url_imagen'];
    toxicidad = json['toxicidad'];
    comestible = json['comestible'];
    vegetable = json['vegetable'];
    aO = json['año'];
    familia = json['familia'];
    humedadAtmosferica = json['humedad_atmosferica'];
    cantidadLuz = json['cantidad_luz'];
    genero = json['genero'];
    estatus = json['estatus'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre_planta'] = this.nombrePlanta;
    data['nombre_cientifico'] = this.nombreCientifico;
    data['url_imagen'] = this.urlImagen;
    data['toxicidad'] = this.toxicidad;
    data['comestible'] = this.comestible;
    data['vegetable'] = this.vegetable;
    data['año'] = this.aO;
    data['familia'] = this.familia;
    data['colores'] = this.colores;
    data['humedad_atmosferica'] = this.humedadAtmosferica;
    data['cantidad_luz'] = this.cantidadLuz;
    data['meses_crecimiento'] = this.mesesCrecimiento;
    data['genero'] = this.genero;
    data['estatus'] = this.estatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class NombresComunes {
  List<String>? eng;
  List<String>? nld;
  List<String>? dan;
  List<String>? deu;
  List<String>? por;
  List<String>? spa;
  List<String>? swe;
  List<String>? lav;
  List<String>? ces;
  List<String>? fra;
  List<String>? nob;
  List<String>? nno;
  List<String>? fin;
  List<String>? cym;
  List<String>? en;
  List<String>? af;
  List<String>? ar;
  List<String>? hy;
  List<String>? az;
  List<String>? ba;
  List<String>? eu;
  List<String>? be;
  List<String>? bs;
  List<String>? bg;
  List<String>? ca;
  List<String>? zh;
  List<String>? kw;
  List<String>? hr;
  List<String>? cs;
  List<String>? da;
  List<String>? nl;
  List<String>? eo;
  List<String>? et;
  List<String>? fi;
  List<String>? fr;
  List<String>? gl;
  List<String>? ka;
  List<String>? de;
  List<String>? el;
  List<String>? he;
  List<String>? hu;
  List<String>? it;
  List<String>? kk;
  List<String>? ko;
  List<String>? lv;
  List<String>? lt;
  List<String>? lb;
  List<String>? mk;
  List<String>? no;
  List<String>? nb;
  List<String>? nn;
  List<String>? ps;
  List<String>? fa;
  List<String>? pl;
  List<String>? pt;
  List<String>? ro;
  List<String>? ru;
  List<String>? sr;
  List<String>? sk;
  List<String>? es;
  List<String>? sv;
  List<String>? tt;
  List<String>? th;
  List<String>? tr;
  List<String>? uk;
  List<String>? vi;
  List<String>? cy;

  NombresComunes(
      {this.eng,
      this.nld,
      this.dan,
      this.deu,
      this.por,
      this.spa,
      this.swe,
      this.lav,
      this.ces,
      this.fra,
      this.nob,
      this.nno,
      this.fin,
      this.cym,
      this.en,
      this.af,
      this.ar,
      this.hy,
      this.az,
      this.ba,
      this.eu,
      this.be,
      this.bs,
      this.bg,
      this.ca,
      this.zh,
      this.kw,
      this.hr,
      this.cs,
      this.da,
      this.nl,
      this.eo,
      this.et,
      this.fi,
      this.fr,
      this.gl,
      this.ka,
      this.de,
      this.el,
      this.he,
      this.hu,
      this.it,
      this.kk,
      this.ko,
      this.lv,
      this.lt,
      this.lb,
      this.mk,
      this.no,
      this.nb,
      this.nn,
      this.ps,
      this.fa,
      this.pl,
      this.pt,
      this.ro,
      this.ru,
      this.sr,
      this.sk,
      this.es,
      this.sv,
      this.tt,
      this.th,
      this.tr,
      this.uk,
      this.vi,
      this.cy});

  NombresComunes.fromJson(Map<String, dynamic> json) {
    eng = json['eng'].cast<String>();
    nld = json['nld'].cast<String>();
    dan = json['dan'].cast<String>();
    deu = json['deu'].cast<String>();
    por = json['por'].cast<String>();
    spa = json['spa'].cast<String>();
    swe = json['swe'].cast<String>();
    lav = json['lav'].cast<String>();
    ces = json['ces'].cast<String>();
    fra = json['fra'].cast<String>();
    nob = json['nob'].cast<String>();
    nno = json['nno'].cast<String>();
    fin = json['fin'].cast<String>();
    cym = json['cym'].cast<String>();
    en = json['en'].cast<String>();
    af = json['af'].cast<String>();
    ar = json['ar'].cast<String>();
    hy = json['hy'].cast<String>();
    az = json['az'].cast<String>();
    ba = json['ba'].cast<String>();
    eu = json['eu'].cast<String>();
    be = json['be'].cast<String>();
    bs = json['bs'].cast<String>();
    bg = json['bg'].cast<String>();
    ca = json['ca'].cast<String>();
    zh = json['zh'].cast<String>();
    kw = json['kw'].cast<String>();
    hr = json['hr'].cast<String>();
    cs = json['cs'].cast<String>();
    da = json['da'].cast<String>();
    nl = json['nl'].cast<String>();
    eo = json['eo'].cast<String>();
    et = json['et'].cast<String>();
    fi = json['fi'].cast<String>();
    fr = json['fr'].cast<String>();
    gl = json['gl'].cast<String>();
    ka = json['ka'].cast<String>();
    de = json['de'].cast<String>();
    el = json['el'].cast<String>();
    he = json['he'].cast<String>();
    hu = json['hu'].cast<String>();
    it = json['it'].cast<String>();
    kk = json['kk'].cast<String>();
    ko = json['ko'].cast<String>();
    lv = json['lv'].cast<String>();
    lt = json['lt'].cast<String>();
    lb = json['lb'].cast<String>();
    mk = json['mk'].cast<String>();
    no = json['no'].cast<String>();
    nb = json['nb'].cast<String>();
    nn = json['nn'].cast<String>();
    ps = json['ps'].cast<String>();
    fa = json['fa'].cast<String>();
    pl = json['pl'].cast<String>();
    pt = json['pt'].cast<String>();
    ro = json['ro'].cast<String>();
    ru = json['ru'].cast<String>();
    sr = json['sr'].cast<String>();
    sk = json['sk'].cast<String>();
    es = json['es'].cast<String>();
    sv = json['sv'].cast<String>();
    tt = json['tt'].cast<String>();
    th = json['th'].cast<String>();
    tr = json['tr'].cast<String>();
    uk = json['uk'].cast<String>();
    vi = json['vi'].cast<String>();
    cy = json['cy'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eng'] = this.eng;
    data['nld'] = this.nld;
    data['dan'] = this.dan;
    data['deu'] = this.deu;
    data['por'] = this.por;
    data['spa'] = this.spa;
    data['swe'] = this.swe;
    data['lav'] = this.lav;
    data['ces'] = this.ces;
    data['fra'] = this.fra;
    data['nob'] = this.nob;
    data['nno'] = this.nno;
    data['fin'] = this.fin;
    data['cym'] = this.cym;
    data['en'] = this.en;
    data['af'] = this.af;
    data['ar'] = this.ar;
    data['hy'] = this.hy;
    data['az'] = this.az;
    data['ba'] = this.ba;
    data['eu'] = this.eu;
    data['be'] = this.be;
    data['bs'] = this.bs;
    data['bg'] = this.bg;
    data['ca'] = this.ca;
    data['zh'] = this.zh;
    data['kw'] = this.kw;
    data['hr'] = this.hr;
    data['cs'] = this.cs;
    data['da'] = this.da;
    data['nl'] = this.nl;
    data['eo'] = this.eo;
    data['et'] = this.et;
    data['fi'] = this.fi;
    data['fr'] = this.fr;
    data['gl'] = this.gl;
    data['ka'] = this.ka;
    data['de'] = this.de;
    data['el'] = this.el;
    data['he'] = this.he;
    data['hu'] = this.hu;
    data['it'] = this.it;
    data['kk'] = this.kk;
    data['ko'] = this.ko;
    data['lv'] = this.lv;
    data['lt'] = this.lt;
    data['lb'] = this.lb;
    data['mk'] = this.mk;
    data['no'] = this.no;
    data['nb'] = this.nb;
    data['nn'] = this.nn;
    data['ps'] = this.ps;
    data['fa'] = this.fa;
    data['pl'] = this.pl;
    data['pt'] = this.pt;
    data['ro'] = this.ro;
    data['ru'] = this.ru;
    data['sr'] = this.sr;
    data['sk'] = this.sk;
    data['es'] = this.es;
    data['sv'] = this.sv;
    data['tt'] = this.tt;
    data['th'] = this.th;
    data['tr'] = this.tr;
    data['uk'] = this.uk;
    data['vi'] = this.vi;
    data['cy'] = this.cy;
    return data;
  }
}

class Distribucion {
  List<Native>? native;

  Distribucion({this.native});

  Distribucion.fromJson(Map<String, dynamic> json) {
    if (json['native'] != null) {
      native = <Native>[];
      json['native'].forEach((v) {
        native!.add(new Native.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.native != null) {
      data['native'] = this.native!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Native {
  int? id;
  String? name;
  String? slug;
  String? tdwgCode;
  int? tdwgLevel;
  int? speciesCount;
  Links? links;

  Native(
      {this.id,
      this.name,
      this.slug,
      this.tdwgCode,
      this.tdwgLevel,
      this.speciesCount,
      this.links});

  Native.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    tdwgCode = json['tdwg_code'];
    tdwgLevel = json['tdwg_level'];
    speciesCount = json['species_count'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['tdwg_code'] = this.tdwgCode;
    data['tdwg_level'] = this.tdwgLevel;
    data['species_count'] = this.speciesCount;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Links {
  String? self;
  String? plants;
  String? species;

  Links({this.self, this.plants, this.species});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    plants = json['plants'];
    species = json['species'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['plants'] = this.plants;
    data['species'] = this.species;
    return data;
  }
}
