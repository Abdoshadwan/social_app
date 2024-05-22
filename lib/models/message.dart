class Messagemodel {
  late String senderid;
  late String recieverid;
  late String datetime;
  late String text;
  late String image;

  Messagemodel(
      {required this.senderid,
      required this.recieverid,
      required this.datetime,
      required this.text,
      this.image = ''});
  Messagemodel.fromjson(Map<String, dynamic>? json) {
    senderid = json?['senderId'];
    recieverid = json?['recieverId'];
    datetime = json?['datetime'];
    text = json?['text'];
    image = json?['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderid,
      'recieverId': recieverid,
      'datetime': datetime,
      'text': text,
      'image': image,
    };
  }
}
