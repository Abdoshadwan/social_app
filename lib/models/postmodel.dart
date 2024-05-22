class Postmodel {
  String name = '';
  late String uid;
  late String image;
  late String datetime;
  late String postimage;
  late String text;

  Postmodel({
    required this.name,
    required this.uid,
    required this.datetime,
    this.postimage = '',
    this.text = '',
    this.image = '',
  });
  Postmodel.fromjson(Map<String, dynamic>? json) {
    name = json?['name'];
    uid = json?['uid'];
    image = json?['image'];
    datetime = json?['datetime'];
    text = json?['text'];
    postimage = json?['postimage'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'datetime': datetime,
      'text': text,
      'postimage': postimage
    };
  }
}
