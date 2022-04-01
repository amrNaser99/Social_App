import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twasol/shared/styles/icon_broken.dart';
import '../../../shared/cubit/social_cubit.dart';
import '../../../shared/cubit/social_states.dart';
import '../../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = BlocProvider.of(context);
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    return SmartRefresher(
      controller: _refreshController,
      physics: const BouncingScrollPhysics(),
      enablePullUp: true,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1000));
        // if failed,use refreshFailed()
        SocialCubit.get(context).getPosts();
        _refreshController.refreshCompleted();
      },
      child: Builder(
        builder: (BuildContext context) {
          cubit.getDataUser();
          cubit.getPosts();

          return BlocConsumer<SocialCubit, SocialStates>(
            listener: (BuildContext context, state) {
              if (state is SocialOpenLikeSheetStates) {
                showModalBottomSheet(
                    context: context,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    builder: (context) {
                      return Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            //black bar
                            Container(
                              alignment: AlignmentDirectional.center,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black54,
                              ),
                            ),
                            //user who like
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  IconBroken.Heart,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${SocialCubit.get(context).peopleReacted.length}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Text(
                                  'Likes',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildLikeListSheet(
                                        context: context,
                                        model: SocialCubit.get(context)
                                            .peopleReacted[index],
                                        index: index),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 1,
                                ),
                                itemCount: SocialCubit.get(context)
                                    .peopleReacted
                                    .length,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
              if (state is SocialOpenCommentSheetStates) {
                showModalBottomSheet(
                    context: context,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    builder: (context) {
                      return Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            //black bar
                            Container(
                              alignment: AlignmentDirectional.center,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black54,
                              ),
                            ),
                            //user who like
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  IconBroken.Message,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '${SocialCubit.get(context).peopleComments.length} Comments',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildCommentListSheet(
                                        context: context,
                                        model: SocialCubit.get(context)
                                            .peopleComments[index],
                                        index: index),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 1,
                                ),
                                itemCount: SocialCubit.get(context)
                                    .peopleComments
                                    .length,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
              if (state
                  is SocialVoiceRecorderWithBottomSheetWithBottomSheetLoadingStates) {
                showModalBottomSheet(
                    context: context,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    builder: (context) {
                      return Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            //black bar
                            Container(
                              alignment: AlignmentDirectional.center,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black54,
                              ),
                            ),
                            //user who like
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onLongPressStart: (lpd)
                                {
                                  SocialCubit.get(context).voiceStartRecord();
                                },
                                onLongPressEnd: (lpd)
                                {
                                  //TODO in voiceStopRecord
                                  SocialCubit.get(context).voiceStopRecord();
                                },
                                child: IconButton(
                                  iconSize: 20,
                                   icon: const Icon(IconBroken.Voice_2)
                                  , onPressed: () { print('asdakjhjjkokji93'); },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }

              if (state is SocialDeletePostSuccessStates) {
                showToast(message: 'Post Deleted Successfully');
              }
              if (state is SocialGetPostsDataSuccessStates) {
                SocialCubit.get(context).postsLoadedSuccessfully = true;
                print(
                    'postsLoadedSuccessfully ${SocialCubit.get(context).postsLoadedSuccessfully}');
              }
              if (state is SocialGetUserDataSuccessStates) {
                SocialCubit.get(context).userDataLoadedSuccessfully = true;
                print(
                    'userDataLoadedSuccessfully ${SocialCubit.get(context).userDataLoadedSuccessfully}');
              }
            },
            builder: (BuildContext context, state) {
              print('=================================');
              print('number of Posts is ${cubit.posts.length}');
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: const [
                          Image(
                            image: NetworkImage(
                                'https://t4.ftcdn.net/jpg/02/94/90/03/360_F_294900379_hmgg72pkQpLI6J8TxLyPqiOBNPmQ9RJh.jpg'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 190.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate With Friends',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (SocialCubit.get(context).postsLoadedSuccessfully ==
                            true &&
                        SocialCubit.get(context).userDataLoadedSuccessfully ==
                            true)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(
                          context,
                          cubit.posts[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8.0,
                        ),
                        itemCount: cubit.posts.length,
                      ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
