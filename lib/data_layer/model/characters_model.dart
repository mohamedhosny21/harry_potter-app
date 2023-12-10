class CharactersModel {
  int? id;
  String? character;
  String? nickname;
  bool? hogwartsStudent;
  String? hogwartsHouse;
  String? interpretedBy;
  List<dynamic>? child;
  String? image;

  CharactersModel(
      {required this.id,
      required this.character,
      required this.nickname,
      required this.hogwartsStudent,
      required this.hogwartsHouse,
      required this.interpretedBy,
      required this.child,
      required this.image});

  CharactersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    character = json['character'];
    nickname = json['nickname'];
    hogwartsStudent = json['hogwartsStudent'];
    hogwartsHouse = json['hogwartsHouse'];
    interpretedBy = json['interpretedBy'];
    child = json['child'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['character'] = character;
    data['nickname'] = nickname;
    data['hogwartsStudent'] = hogwartsStudent;
    data['hogwartsHouse'] = hogwartsHouse;
    data['interpretedBy'] = interpretedBy;
    data['child'] = child;
    data['image'] = image;
    return data;
  }
}
