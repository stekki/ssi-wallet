class Character {
  final String name;
  Character(this.name);

  Character.fromMap(Map map) : name = map['name'];
}
