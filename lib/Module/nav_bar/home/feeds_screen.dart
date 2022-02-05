import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasol/model/post_model.dart';
import 'package:twasol/shared/cubit/social_cubit.dart';
import 'package:twasol/shared/cubit/social_states.dart';
import 'package:twasol/shared/styles/colors.dart';
import 'package:twasol/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO make feed screen stream builder and add snabshot listen
    return  BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: true,
          // SocialCubit.get(context).posts.isNotEmpty &&
          //     SocialCubit.get(context).userModel != null,
          builder: (context) {
            //TODO Email Verification
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
                      SocialCubit.get(context).posts[index],
                      index,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8.0,
                    ),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
    ;
  }

  Widget buildPostItem(context, PostModel model, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.userName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: mainColor,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  //TODO More
                  IconButton(
                    onPressed: () {
                      SocialCubit.get(context).deletePost(post: model);
                    },
                    icon: const Icon(
                      IconBroken.More_Circle,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              //Text Body
              if (model.text != null)
                const SizedBox(
                  height: 5,
                ),
              if (model.text != null)
                Text(
                  '${model.text}',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 14.0,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              // const SizedBox(height: 15.0,),
              // Tags
              // Padding(
              //   padding: const EdgeInsetsDirectional.only(top: 5.0),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Container(
              //           height: 25.0,
              //           child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: const Text(
              //               '#mobile_developmemt ',
              //               style: TextStyle(
              //                 color: Colors.blue,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 25.0,
              //           child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: const Text(
              //               '#Flutter ',
              //               style: TextStyle(
              //                 color: Colors.blue,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 25.0,
              //           child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: const Text(
              //               '#flutter ',
              //               style: TextStyle(
              //                 color: Colors.blue,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 25.0,
              //           child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: const Text(
              //               '#flutter ',
              //               style: TextStyle(
              //                 color: Colors.blue,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // post Image
              if (model.postImage != "")
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 10.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 140.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              // emojies bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                size: 20,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.More_Circle,
                                size: 20,
                                color: mainColor,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                //TODO
                                '${SocialCubit.get(context).comments[index]} Comments',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 5.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  //comment
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel!.image}',
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              height: 30.0,
                              child: TextFormField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write a comment...',
                                  hintStyle:
                                      Theme.of(context).textTheme.caption,
                                ),
                                onFieldSubmitted: (String value) {
                                  SocialCubit.get(context).commentPost(
                                      SocialCubit.get(context).postsId[index],
                                      commentController.text);
                                  commentController.clear();
                                  SocialCubit.get(context).getDataUser();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 20,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
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
