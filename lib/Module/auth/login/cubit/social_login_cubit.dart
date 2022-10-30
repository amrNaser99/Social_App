import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasol/Module/auth/login/cubit/social_login_states.dart';
import 'package:twasol/shared/components/constants.dart';
import 'package:twasol/shared/network/local/cache_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingStates());
    debugPrint('in userLogin');

    auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      debugPrint('==========================');
      CacheHelper.saveData(key: 'email', value: value.user!.email).then((value) {
        debugPrint('email Cached Successfully');
      }).catchError((error) {
        debugPrint(error);
      });
      CacheHelper.saveData(key: 'uId', value: value.user!.uid).then((value) {
        debugPrint('uId Cached Successfully');
      }).catchError((error) {
        debugPrint(error);
      });
      uId = value.user!.uid;
      debugPrint(value.user!.uid);

      emit(SocialLoginSuccessStates(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorStates(error.toString()));
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    emit(SocialSignInWithGoogleSuccessStates());
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
