class DBFlower {
  int id;
  int count;
  DBFlower(this.count, this.id);
  DBFlower.fromDbMap(Map<String, dynamic> map)
      : id = map['id'],
        count = map['count'];

  Map<String, dynamic> toDbMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['count'] = count;
    return map;
  }
}
