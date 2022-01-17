abstract class RegisterStates {}

class SocialRegisterInitialStates extends RegisterStates {}

class SocialRegisterLoadingStates extends RegisterStates {}

class SocialRegisterSuccessStates extends RegisterStates {}

class SocialRegisterErrorStates extends RegisterStates {
  final String error;

  SocialRegisterErrorStates(this.error);
}
class SocialCreateUserSuccessStates extends RegisterStates {}

class SocialCreateUserErrorStates extends RegisterStates {
  final String error;

  SocialCreateUserErrorStates(this.error);

}
