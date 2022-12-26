const kTitle = 'title';
const kBought = 'bought';

class ItemClass {
  final String title;
  final bool bought;

  ItemClass(this.title, this.bought);

  factory ItemClass.fromJson(Map<String, Object?> json) =>
      ItemClass(json[kTitle]! as String, json[kBought]! as bool);

  Map<String, Object?> toJson() => {kTitle: title, kBought: bought};
}
