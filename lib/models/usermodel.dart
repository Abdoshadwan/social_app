class UserModel {
  late String email;
  String name = '';
  late String phone;
  late String uid;
  late String image;
  late String cover;
  late String bio;
  late bool isverfied;

  UserModel(
      {this.email = '',
      required this.name,
      required this.phone,
      required this.uid,
      this.image = '',
      this.cover = '',
      this.bio = '',
      this.isverfied = false});
  UserModel.fromjson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    uid = json?['uid'];
    isverfied = json?['isverfied'];
    image = json?['image'];
    cover = json?['cover'];
    bio = json?['bio'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isverfied': isverfied,
    };
  }
}
