abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

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
  final String uId ;

  SocialLoginSuccessStates(this.uId);

}

class SocialRegisterInitialStates extends SocialLoginStates {}


class SocialCreateUserSuccessStates extends SocialLoginStates {}

class SocialCreateUserErrorStates extends SocialLoginStates {
  final String error;

  SocialCreateUserErrorStates(this.error);

}
