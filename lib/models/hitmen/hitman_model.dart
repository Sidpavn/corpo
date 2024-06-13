class Hitman {
  String name;
  String architype;
  List<String> skills;
  List<String> quirks;
  String rank;
  Map<String, dynamic> attributes;

  Hitman({
    required this.name,
    required this.architype,
    required this.skills,
    required this.quirks,
    required this.rank,
    required this.attributes,
  });

  factory Hitman.fromJson(Map<String, dynamic> json) {
    return Hitman(
      name: json['name'],
      architype: json['architype'],
      skills: List<String>.from(json['skills']),
      quirks: List<String>.from(json['quirks']),
      rank: json['rank'],
      attributes: json['attributes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'architype': architype,
      'skills': skills,
      'quirks': quirks,
      'rank': rank,
      'attributes': attributes,
    };
  }
}

class HitmanArchitype {
  String name;
  List<String> skills;

  HitmanArchitype({
    required this.name,
    required this.skills,
  });

  factory HitmanArchitype.fromJson(Map<String, dynamic> json) {
    return HitmanArchitype(
      name: json['name'],
      skills: List<String>.from(json['skills']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'skills': skills,
    };
  }
}

class HitmanSkills {
  String? name;
  List<Attributes>? attributes;
  String? archetype;

  HitmanSkills({this.name, this.attributes, this.archetype});

  HitmanSkills.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    archetype = json['archetype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['archetype'] = this.archetype;
    return data;
  }
}

class Attributes {
  int? STR;
  int? STL;
  int? HCK;
  int? INT;
  int? CMB;
  int? AGI;
  int? PER;
  int? END;

  Attributes({this.STR, this.STL, this.HCK, this.INT, this.CMB, this.AGI, this.PER, this.END});

  Attributes.fromJson(Map<String, dynamic> json) {
    STR = json['STR'] ?? null;
    STL = json['STL'] ?? null;
    HCK = json['HCK'] ?? null;
    INT = json['INT'] ?? null;
    CMB = json['CMB'] ?? null;
    AGI = json['AGI'] ?? null;
    PER = json['PER'] ?? null;
    END = json['END'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(data['STR'] != null){  data['STR'] = this.STR; }
    if(data['STL'] != null){  data['STL'] = this.STL; }
    if(data['HCK'] != null){  data['HCK'] = this.HCK; }
    if(data['INT'] != null){  data['INT'] = this.INT; }
    if(data['CMB'] != null){  data['CMB'] = this.CMB; }
    if(data['AGI'] != null){  data['AGI'] = this.AGI; }
    if(data['PER'] != null){  data['PER'] = this.PER; }
    if(data['END'] != null){  data['END'] = this.END; }
    return data;
  }
}


