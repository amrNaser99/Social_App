import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Module/nav_bar/chats/chats_screen.dart';
import 'package:social_app/Module/nav_bar/home/feeds_screen.dart';
import 'package:social_app/Module/nav_bar/setting/setting_screen.dart';
import 'package:social_app/Module/nav_bar/users/users_screen.dart';
import 'package:social_app/shared/cubit/social_states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStateState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens =
  [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];

  void changeNavItems(int index)
  {
    currentIndex = index ;
    emit(SocialChangeNavBarState());
  }

}
