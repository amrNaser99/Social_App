import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Module/login/social_login_cubit/social_login_states.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialStates());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingStates());
    print('in userLogin ');

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value)
    {
      CacheHelper.saveData(key: 'email', value: value.user!.email);
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      token = value.credential!.token.toString() ;
      print(value.credential!.token);
      print(value.user!.uid);
    });
  }
}
