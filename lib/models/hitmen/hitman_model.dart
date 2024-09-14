import 'package:corpo/common/enums/enums.dart';

class Hitman {
  String name;
  String architype;
  List<String> skills;
  List<String> quirks;
  String rank;
  Map<String, dynamic> attributes;
  int slots;
  int stress;
  int maxStress;

  Hitman({
    required this.name,
    required this.architype,
    required this.skills,
    required this.quirks,
    required this.rank,
    required this.attributes,
    required this.slots,
    required this.stress,
    required this.maxStress,
  });

  factory Hitman.fromJson(Map<String, dynamic> json) {
    return Hitman(
      name: json['name'],
      architype: json['architype'],
      skills: List<String>.from(json['skills']),
      quirks: List<String>.from(json['quirks']),
      rank: json['rank'],
      attributes: json['attributes'],
      slots: json['slots'],
      stress: json['stress'],
      maxStress: json['maxStress'],
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
      'slots': slots,
      'stress': stress,
      'maxStress': maxStress,
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
  int? LKY;
  int? PER;
  int? CHR;

  Attributes({this.STR, this.STL, this.HCK, this.INT, this.CMB, this.LKY, this.PER, this.CHR});

  Attributes.fromJson(Map<String, dynamic> json) {
    STR = json['STR'] ?? null;
    STL = json['STL'] ?? null;
    HCK = json['HCK'] ?? null;
    INT = json['INT'] ?? null;
    CMB = json['CMB'] ?? null;
    LKY = json['LKY'] ?? null;
    PER = json['PER'] ?? null;
    CHR = json['CHR'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(data['STR'] != null){  data['STR'] = this.STR; }
    if(data['STL'] != null){  data['STL'] = this.STL; }
    if(data['HCK'] != null){  data['HCK'] = this.HCK; }
    if(data['INT'] != null){  data['INT'] = this.INT; }
    if(data['CMB'] != null){  data['CMB'] = this.CMB; }
    if(data['LKY'] != null){  data['LKY'] = this.LKY; }
    if(data['PER'] != null){  data['PER'] = this.PER; }
    if(data['CHR'] != null){  data['CHR'] = this.CHR; }
    return data;
  }
}


