abstract class SocialStates {}


class SocialInitialStateState extends SocialStates{}

class SocialChangeNavBarState extends SocialStates{}


class SocialLoadingHomeDataState extends SocialStates{}
class SocialHomeDataSuccessState extends SocialStates{}
class SocialHomeDataErrorState extends SocialStates{
  final String error;
  SocialHomeDataErrorState(this.error);
}

class SocialLoadingCategoriesState extends SocialStates{}
class SocialCategoriesSuccessState extends SocialStates{}
class SocialCategoriesErrorState extends SocialStates{
  final String error;
  SocialCategoriesErrorState(this.error);
}
class SocialChangeFavouriteSuccessState extends SocialStates{

}
class SocialChangeFavouriteErrorState extends SocialStates{
  final String error;

  SocialChangeFavouriteErrorState(this.error);
}
class SocialLoadingFavouriteState extends SocialStates{}

class SocialFavouriteSuccessState extends SocialStates{
}
class SocialGetFavouritesSuccessState extends SocialStates{

}

class SocialGetFavouritesErrorState extends SocialStates{
  final String error;

  SocialGetFavouritesErrorState(this.error);
}

class SocialLoadingUserDataState extends SocialStates{}

class SocialUserDataSuccessState extends SocialStates{


}
class SocialUserDataErrorState extends SocialStates{
  final String error;

  SocialUserDataErrorState(this.error);

}

