import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasol/Module/nav_bar/post/post_screen.dart';
import 'package:twasol/shared/components/components.dart';
import 'package:twasol/shared/cubit/social_cubit.dart';
import '../shared/cubit/social_states.dart';
import '../shared/styles/icon_broken.dart';

class SocialLayout extends StatefulWidget {
  static GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  int initialIndex = 0;

  @override
  State<SocialLayout> createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout>
    with SingleTickerProviderStateMixin {
  // static late TabController tabController;
  // late int initialIndex;
  //
  // @override
  // void initState() {
  //   initialIndex = widget.initialIndex;
  //   tabController = TabController(length: 4, vsync: this);
  //   tabController.index = initialIndex;
  //   tabController.addListener(() => setState(() {}));
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (BuildContext context, state) {
          if (state is SocialNewPostState) {
            NavigateTo(context, PostScreen());
          }
        },
        builder: (BuildContext context, state) {
          SocialCubit cubit = BlocProvider.of(context);
          return Scaffold(
            key: SocialLayout.scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.appBarTitles[cubit.currentIndex],
              ),
              // bottom: TabBar(
              //   controller: tabController,
              //   labelColor: mainColor,
              //   tabs: SocialCubit.get(context).tabs,
              // ),
              actions: [

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconBroken.Notification,
                  ),
                ),
                IconButton(
                  onPressed: ()
                  {
                    SocialCubit.get(context).searchUsername(userName: 'mona_nasser');
                  },
                  icon: const Icon(
                    IconBroken.Search,
                  ),
                ),
              ],
            ),
            // tabController.index == 0
            //     ? AppBar(
            //         title: Text(
            //           cubit.appBarTitles[cubit.currentIndex],
            //         ),
            //         bottom: TabBar(
            //           labelColor: mainColor,
            //           tabs: SocialCubit.get(context).tabs,
            //         ),
            //         actions: [
            //           IconButton(
            //             onPressed: () {},
            //             icon: const Icon(
            //               IconBroken.Notification,
            //             ),
            //           ),
            //           IconButton(
            //             onPressed: () {},
            //             icon: const Icon(
            //               IconBroken.Search,
            //             ),
            //           ),
            //         ],
            //       )
            //     : AppBar(
            //         automaticallyImplyLeading: false,
            //         elevation: 8,
            //         title: TabBar(
            //           controller: tabController,
            //           labelColor: mainColor,
            //           tabs: SocialCubit.get(context).tabs,
            //           onTap: (index) {
            //             SocialCubit.get(context).changeNavItems(index);
            //           },
            //           indicatorColor: mainColor,
            //           unselectedLabelColor: Colors.grey,
            //         ),
            //       ),

            body: cubit.screens[cubit.currentIndex],
            // TabBarView(
            //   physics: RangeMaintainingScrollPhysics(),
            //   controller: tabController,
            //   children: SocialCubit.get(context).screens,
            // ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
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
    });
  }
}
