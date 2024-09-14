class Mission {
  Name? name;
  List<Stages>? stages;

  Mission({this.name, this.stages});

  Mission.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    if (json['stages'] != null) {
      stages = <Stages>[];
      json['stages'].forEach((v) {
        stages!.add(new Stages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.stages != null) {
      data['stages'] = this.stages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Name {
  String? name;

  Name({this.name});

  Name.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Stages {
  String? name;
  List<String>? mission;

  Stages({this.name, this.mission});

  Stages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mission = json['mission'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mission'] = this.mission;
    return data;
  }
}
