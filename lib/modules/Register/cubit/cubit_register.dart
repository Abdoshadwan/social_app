import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/usermodel.dart';
import 'package:social_app/modules/Register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(registerInitialsState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void Register_user({
    required String name,
    required String phone,
    required String email,
    required var password,
    String? image,
  }) {
    emit(registerLoadState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      usercreate(name: name, phone: phone, email: email, uid: value.user!.uid);
      print(value.user!.email);
    }).catchError((error) {
      emit(registercreateErrorState(error.toString()));
    });
  }

  void usercreate({
    required String name,
    required String phone,
    required String email,
    required String uid,
     
  }) {
    UserModel model =
        UserModel(email: email, name: name, phone: phone, uid: uid,isverfied: false,bio:'Write your bio ...' ,image:'https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg?w=740&t=st=1699875051~exp=1699875651~hmac=9a15061e647d3b0396ace910b9cd77338792ebe6d8fcfa4fde2e33ab1c02365b',cover: 'https://img.freepik.com/free-photo/positivity-life-motivation-passion-inspiration-word-graphic_53876-121018.jpg?w=740&t=st=1700140498~exp=1700141098~hmac=209eb61c38e926cb868c2f7517f23cf1bee869a3e9f2c9795378155531628b2b' );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(registercreateSuccessState(uid: uid));
    }).catchError((error) {
      emit(registercreateErrorState(error));
    });
  }
}
