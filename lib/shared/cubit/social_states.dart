abstract class SocialStates {}


class SocialInitialState extends SocialStates{}

class SocialChangeNavBarState extends SocialStates{}
class SocialNewPostState extends SocialStates{}


class SocialGetUserDataLoadingStates extends SocialStates {}



class SocialGetUserDataSuccessStates extends SocialStates {

}

class SocialGetUserDataErrorStates extends SocialStates {
  final String error;

  SocialGetUserDataErrorStates(this.error);
}
class SocialProfileImageSuccessStates extends SocialStates {}

class SocialProfileImageErrorStates extends SocialStates {}
class SocialCoverImageSuccessStates extends SocialStates {}

class SocialCoverImageErrorStates extends SocialStates {}