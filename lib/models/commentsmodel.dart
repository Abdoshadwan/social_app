class Commentmodel {
  String name = '';
  late String uid;
  late String image;
  late String datetime;
  late String comment;

  Commentmodel(
      {required this.name,
      required this.uid,
      required this.datetime,
      this.image = '',
      required this.comment});
  Commentmodel.fromjson(Map<String, dynamic>? json) {
    name = json?['name'];
    uid = json?['uid'];
    image = json?['image'];
    datetime = json?['datetime'];
    comment = json?['comment'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'datetime': datetime,
      'comment': comment
    };
  }
}
