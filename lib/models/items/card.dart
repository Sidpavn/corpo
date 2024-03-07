
class CardItem{

  String? name;
  String? desc;

  CardItem({
    this.name,
    this.desc,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) => CardItem(
    name: json["name"],
    desc: json["desc"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "desc": desc,
  };

}