import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasol/Module/nav_bar/post/post_screen.dart';
import 'package:twasol/shared/components/components.dart';
import 'package:twasol/shared/cubit/social_cubit.dart';
import 'package:twasol/shared/cubit/social_states.dart';
import 'package:twasol/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  static GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  const SocialLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if(state is SocialNewPostState)
        {
          NavigateTo(context, PostScreen());
        }
      },
      builder: (BuildContext context, state) {
        SocialCubit cubit = BlocProvider.of(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              cubit.appBarTitles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Notification,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconBroken.Search,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Upload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
            currentIndex: SocialCubit.get(context).currentIndex,
            onTap: (index) {
              SocialCubit.get(context).changeNavItems(index);
            },
          ),
        );
      },
    );
  }
}
