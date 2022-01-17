
abstract class SocialLoginStates {}

class SocialLoginInitialStates extends SocialLoginStates {}

class SocialLoginLoadingStates extends SocialLoginStates {}

class SocialLoginErrorStates extends SocialLoginStates {
  final String error;

  SocialLoginErrorStates(this.error);
}


class SocialRegisterLoadingStates extends SocialLoginStates {}

class SocialRegisterSuccessStates extends SocialLoginStates {

}

class SocialRegisterErrorStates extends SocialLoginStates {
  final String error;

  SocialRegisterErrorStates(this.error);

}

class SocialLoginSuccessStates extends SocialLoginStates {

}