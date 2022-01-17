import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Module/register/register_cubit/register_states.dart';
import 'package:social_app/model/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(SocialRegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String userName,
    required String? phone,
    required String email,
    required String password,
    required String vPassword,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        userName: userName,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      emit(SocialRegisterSuccessStates());
    }).catchError((error) {
      emit(SocialRegisterErrorStates(error.toString()));
    });
  }

  void userCreate({
    required String userName,
    required String email,
    required String? phone,
    required String uId,
  }) {
    emit(SocialRegisterLoadingStates());

    UserModel userModel = UserModel(
      userName,
      email,
      phone!,
      uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessStates());
    }).catchError((error) {
      emit(SocialCreateUserErrorStates(error.toString()));
    });
  }
}
