import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasol/Module/auth/register/register_cubit/social_register_states.dart';
import 'package:twasol/model/user_model.dart';
import 'package:twasol/shared/components/constants.dart';
import 'package:twasol/shared/cubit/social_cubit.dart';
import 'package:twasol/shared/network/local/cache_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  //Register

  Future userRegister({
    required BuildContext context,
    required String userName,
    required String? phone,
    required String email,
    required String password,
    required String vPassword,
  }) async {
    emit(SocialRegisterLoadingStates());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {

      userCreate(
        context: context,
        userName: userName,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      CacheHelper.saveData(key: 'uId', value: value.user!.uid).then((value) {
        value
            ? debugPrint('uId saved in Cache Memory Successfully')
            : debugPrint('Failed save uId in Cache Memory');
      });
      uId = value.user!.uid;
      token = value.credential!.token;

      emit(SocialRegisterSuccessStates());
    }).catchError((error) {
      emit(SocialRegisterErrorStates(error.toString()));
    });
  }

  // Cloud FireStore Create

  Future<void> userCreate({
    required BuildContext context,
    required String userName,
    required String email,
    required String? phone,
    required String uId,
  }) async {
    emit(SocialRegisterLoadingStates());

    UserModel userModel = UserModel(
      userName: userName,
      email: email,
      phone: phone!,
      uId: uId,
      imgCover:
          'https://i.kym-cdn.com/entries/icons/original/000/034/213/cover2.jpg',
      image:
          'https://us.123rf.com/450wm/fizkes/fizkes2007/fizkes200701793/152407909-profile-picture-of-smiling-young-caucasian-man-in-glasses-show-optimism-positive-and-motivation-head.jpg?ver=6',
      bio: 'bio..',
      isEmailVerified: false,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {

      FirebaseMessaging.instance.subscribeToTopic('users');
      SocialCubit.get(context).getFcmToken();
      emit(SocialCreateUserSuccessStates());
    }).catchError((error) {
      emit(SocialCreateUserErrorStates(error.toString()));
    });
  }
}
