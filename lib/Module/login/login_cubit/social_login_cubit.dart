import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasol/Module/login/login_cubit/social_login_states.dart';
import 'package:twasol/shared/components/constants.dart';
import 'package:twasol/shared/network/local/cache_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingStates());
    print('in userLogin');

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
          print('==========================');
      CacheHelper.saveData(key: 'email', value: value.user!.email);
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      uId = value.user!.uid;
      print(value.user!.uid);
      emit(SocialLoginSuccessStates(value.user!.uid));
    });
  }

}