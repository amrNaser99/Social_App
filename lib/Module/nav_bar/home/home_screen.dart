import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twasol/model/post_model.dart';
import '../../../shared/cubit/social_cubit.dart';
import '../../../shared/cubit/social_states.dart';
import '../../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = BlocProvider.of(context);
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    return SmartRefresher(
      controller: _refreshController,
      physics: BouncingScrollPhysics(),
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1000));
        // if failed,use refreshFailed()
        SocialCubit.get(context).get_Posts();
        _refreshController.refreshCompleted();
      },
      child: Builder(
        builder: (BuildContext context) {
          cubit.getDataUser();
          cubit.get_Posts();

          return BlocConsumer<SocialCubit, SocialStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, state) {
              print('=================================');
              print('posts.length ${cubit.posts.length}');
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
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                        context,
                        cubit.posts[index],
                        index,
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

// var model = SocialCubit
//     .get(context)
//     .userModel;
// return Column(
//   children: [
//     if(!FirebaseAuth.instance.currentUser!.emailVerified)
//       Container(
//         color: Colors.amber.withOpacity(.6),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: SizedBox(
//             height: 50,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Icon(Icons.info_outline),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 const Expanded(
//                   child: Text(
//                     'Please Verify Your Account',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       FirebaseAuth.instance.currentUser
//                           ?.sendEmailVerification()
//                           .then((value) {
//                             showToast(message: 'Check Your Mail');
//                       })
//                           .catchError((error) {
//
//                       });
//                     },
//                     child: Text(
//                       'SEND',
//                       style: TextStyle(
//                         color: primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ))
//               ],
//             ),
//           ),
//         ),
//       ),
//
//
//
//   ],
// );
