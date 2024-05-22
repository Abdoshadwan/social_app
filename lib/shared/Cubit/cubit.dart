import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cache/cache.dart';
import 'package:social_app/models/commentsmodel.dart';
import 'package:social_app/models/message.dart';
import 'package:social_app/models/postmodel.dart';
import 'package:social_app/models/usermodel.dart';
import 'package:social_app/modules/Chats.dart';
import 'package:social_app/modules/Feeds.dart';
import 'package:social_app/modules/Settings.dart';
import 'package:social_app/modules/Users.dart';
import 'package:social_app/shared/Cubit/states.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Social_Cubit extends Cubit<Social_States> {
  Social_Cubit() : super(InitialState());

  static Social_Cubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getuserdata() async {
    emit(GetUserLoadingState());
    await Cache_Helper.Init();
    uid = Cache_Helper.getsaved(key: 'uid') ?? 'null';
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      model = UserModel.fromjson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error: error.toString()));
      print(error.toString());
    });
  }

  int currentindex = 0;
  List<Widget> screens = [
    feeds_screen(),
    chat_screen(),
    user_screen(),
    settings_screen(),
  ];
  void CgScreens(int index) {
    currentindex = index;
    if (currentindex == 0) {
      emit(FeedsBottomNavState());
    }
    if (currentindex == 1) {
      emit(ChatBottomNavState());
      getallusers();
    }
    if (currentindex == 2) {
      emit(userBottomNavState());
    }
    if (currentindex == 3) {
      emit(SettingsBottomNavState());
    }
  }
  //******************************************* */
  // function that pick image to cover and person image

  File? profileimage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      profileimage = File(pickedfile.path);
      emit(PickedImageProfileState());
    } else {
      print('no image selected');
      emit(NotPickedImageProfileState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      coverImage = File(pickedfile.path);
      emit(PickedImageCoverState());
    } else {
      print('no image selected');
      emit(NotPickedImageCoverState());
    }
  }

//******************************************************************************************************* */
//update all data

  void updatedata(
      {required String name,
      required String phone,
      required String bio,
      String? image,
      String? cover}) async {
    if (coverImage != null && profileimage == null) {
      await FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
          .putFile(coverImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateuserdata(name: name, phone: phone, bio: bio, cover: value);
          print(value);
        }).catchError((error) {
          print(error.toString());
          emit(uploadcoverimageerrorState());
        });
        emit(uploadcoverimagesuccessState());
      }).catchError((error) {
        emit(uploadcoverimageerrorState());
        print(error.toString());
      });
    } else if (profileimage != null && coverImage == null) {
      await FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
          .putFile(profileimage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateuserdata(name: name, phone: phone, bio: bio, image: value);
          print(value);
        }).catchError((error) {
          print(error.toString());
          emit(uploadprofileimageerrorState());
        });
        emit(uploadprofileimagesuccessState());
      }).catchError((error) {
        emit(uploadprofileimageerrorState());
        print(error.toString());
      });
      print(profileimage!.path);
      print(Uri.file(profileimage!.path).pathSegments.last);
    } else if (coverImage != null && profileimage != null) {
      await FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
          .putFile(coverImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateuserdata(name: name, phone: phone, bio: bio, cover: value);
          print(value);
        }).catchError((error) {
          print(error.toString());
          emit(uploadcoverimageerrorState());
        });
        emit(uploadcoverimagesuccessState());
      }).catchError((error) {
        emit(uploadcoverimageerrorState());
        print(error.toString());
      });
      await FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
          .putFile(profileimage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateuserdata(name: name, phone: phone, bio: bio, image: value);
          print(value);
        }).catchError((error) {
          print(error.toString());
          emit(uploadprofileimageerrorState());
        });
        emit(uploadprofileimagesuccessState());
      }).catchError((error) {
        emit(uploadprofileimageerrorState());
        print(error.toString());
      });
      print(profileimage!.path);
      print(Uri.file(profileimage!.path).pathSegments.last);
    }
  }

  void updateuserdata(
      {required String name,
      required String phone,
      required String bio,
      String? image,
      String? cover}) {
    UserModel usermodel = UserModel(
        name: name,
        phone: phone,
        uid: uid,
        isverfied: false,
        bio: bio,
        cover: cover ?? model!.cover,
        image: image ?? model!.image,
        email: model!.email);
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel.uid)
        .update(usermodel.toMap())
        .then((value) {
      getuserdata();
    }).catchError((error) {
      emit(UpdateerrorState());
    });
  }

  File? postimage;
  Future<void> getPostimage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      postimage = File(pickedfile.path);
      emit(PickedImagePostState());
    } else {
      print('no image picked');
      emit(NotPickedImagePostState());
    }
  }

  void uploadpostimage({
    required String datetime,
    required String text,
  }) async {
    emit(createpostloadingState());
    await FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CreatePost(datetime: datetime, text: text, postimage: value);
      }).catchError((error) {
        print(error.toString());
        emit(createposterrorState());
      });
    }).catchError((error) {
      emit(createposterrorState());
      print(error.toString());
    });
  }

  void CreatePost(
      {required String datetime, required String text, String postimage = ''}) {
    emit(createpostloadingState());
    Postmodel postmodel = Postmodel(
        name: model!.name,
        uid: model!.uid,
        datetime: datetime,
        image: model!.image,
        text: text,
        postimage: postimage);
    FirebaseFirestore.instance
        .collection('posts')
        .add(postmodel.toMap())
        .then((value) {
      emit(createpostsuccessState());
    }).catchError((error) {
      emit(createposterrorState());
    });
  }

  void removepostimage() {
    postimage = null;
    emit(RemovepostimageState());
  }

  List<Postmodel> posts = [];
  List<String> posts_id = [];
  List<int> likes = [];
  List<Commentmodel> comments = [];

  void getcomments(String postid) async {
    emit(getcommentLoadingState());
    comments = [];
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(Commentmodel.fromjson(element.data()));
          emit(getcommentSuccessState());
          print(comments.length.toString());
        }).catchError((error) {});
      });
    }).catchError((error) {
      emit(getcommentErrorState());
    });
  }

  List<int> comm_count = [];

  void comment_count(String postid) async {
    comm_count = [];
    emit(getcommentcountLoadingState());
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .get()
        .then((value) {
      comm_count.add(value.docs.length);
      emit(getcommentcountSuccessState());
      print(comm_count.length);
    }).catchError((error) {
      emit(getcommentcountErrorState());
    });
  }

  List<int> comments_count = [];

  void getposts() {
    posts = [];
    emit(getPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('datetime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        posts_id.add(element.id);
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);

          posts.add(Postmodel.fromjson(element.data()));
        }).catchError((error) {});
        element.reference.collection('comments').get().then((value) {
          comments_count.add(value.docs.length);
          print(element.id);
          emit(getcommentcountSuccessState());
        }).catchError((error) {});
      });

      emit(getPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getPostErrorState());
    });
  }

  void likepost(String postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('likes')
        .doc(model?.uid)
        .set({'like': true}).then((value) {
      emit(likePostSuccessState());
    }).catchError((error) {
      emit(likePostErrorState());
    });
  }

  void Createcomment(
      {required String datetime,
      required String postid,
      required String comment,
      required String image}) {
    emit(createcommentLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .doc(model?.uid)
        .set({
      'name': model!.name,
      'uid': uid,
      'image': image,
      'datetime': datetime,
      'comment': comment
    }).then((value) {
      emit(createcommentSuccessState());
    }).catchError((error) {
      emit(createcommentErrorState());
    });
  }

  List<UserModel> allusers = [];
  void getallusers() {
    allusers = [];

    emit(GetallUserLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] != model?.uid)
          allusers.add(UserModel.fromjson(element.data()));
      });

      emit(GetallUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetallUserErrorState(error));
    });
  }

  void sendmessage(
      {required String recieverid,
      required String datetime,
      required String text,
      String sendimage = ''}) {
    Messagemodel messagemodel = Messagemodel(
        senderid: model!.uid,
        recieverid: recieverid,
        datetime: datetime,
        text: text,
        image: sendimage);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uid)
        .collection('chats')
        .doc(recieverid)
        .collection('messages')
        .add(messagemodel.toMap())
        .then((value) {
      emit(sendmessageSuccessState());
    }).catchError((error) {
      sendmessageerrorState();
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverid)
        .collection('chats')
        .doc(model?.uid)
        .collection('messages')
        .add(messagemodel.toMap())
        .then((value) {
      emit(sendmessageSuccessState());
    }).catchError((error) {
      sendmessageerrorState();
    });
  }

  List<Messagemodel> messages = [];
  void getmessages({
    required String recieverid,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uid)
        .collection('chats')
        .doc(recieverid)
        .collection('messages')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(Messagemodel.fromjson(element.data()));
      });
      emit(getmessagesuccessState());
    });
  }

  File? sendimage;
  Future<void> getsendimage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      sendimage = File(pickedfile.path);
      emit(pickedsendimagesuccessState());
    } else {
      print('no image picked');
      emit(pickedsendimageeerrorState());
    }
  }

  void uploadsendimage(
      {required String datetime,
      required String text,
      required String recieverid}) async {
    emit(uploadsendimageLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child('messages/${Uri.file(sendimage!.path).pathSegments.last}')
        .putFile(sendimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendmessage(
            recieverid: recieverid,
            datetime: datetime,
            text: text,
            sendimage: value);
      }).catchError((error) {
        print(error.toString());
        emit(uploadsendimageSuccessState());
      });
    }).catchError((error) {
      emit(uploadsendimageErrorState());
      print(error.toString());
    });
  }
}
