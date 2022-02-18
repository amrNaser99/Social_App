import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:twasol/shared/styles/colors.dart';
import 'package:twasol/shared/styles/icon_broken.dart';

import '../../Module/comments/comment_screen.dart';
import '../../Module/likes_screen.dart';
import '../../Module/nav_bar/chats/chat_details/chat_details_screen.dart';
import '../../model/post_model.dart';
import '../../model/user_model.dart';
import '../cubit/social_cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color? color,
  required String text,
  required void Function() function,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: function,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.indigo,
      ),
    );

void NavigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? labelText,
  String? hintText,
  required IconData prefixIcon,
  FormFieldValidator<String>? validate,
  IconData? suffixIcon,
  void Function(String)? onSubmitted,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function()? suffixPressed,
  bool isPassword = false,
  double radius = 10.0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixPressed,
              )
            : null,
      ),
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      onFieldSubmitted: onSubmitted,
    );

Widget defaultTextButton({
  required Function()? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
    );

void showToast({
  required String message,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        icon: const Icon(IconBroken.Arrow___Left_2),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 5.0,
      title: Text(title!),
      actions: actions,
    );

Widget buildListSItem(data, context, index) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(data.image!),
                  height: 120.0,
                  width: 120.0,
                ),
                if (data.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        height: 1.3,
                        fontSize: 18.0,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 5.0,
                        start: 5.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${data.price} LE',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: primaryColor,
                              height: 1.3,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (data.discount != 0)
                            Text(
                              '${data.oldPrice} LE',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  height: 1.3,
                                  fontSize: 10.0,
                                  decoration: TextDecoration.lineThrough),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildChatItem(context, UserModel model) => InkWell(
      onTap: () {
        NavigateTo(
            context,
            ChatDetailsScreen(
              userModel: model,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
              // AssetImage('assets/images/deafault.jpg'),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                '${model.userName}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );

Widget buildPostItem(
  context,
  PostModel model,
  index,
) =>
    Card(
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
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
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
                        // '${model.dateTime!}',
                        '${DateFormat.yMMMMEEEEd().format(DateTime.parse(model.dateTime!))}',
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
                    SocialCubit.get(context)
                        .deletePost(post: model, index: index);
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
                            //TODO Likes
                            Text(
                              // '0',
                              '${SocialCubit.get(context).peopleReacted.length} Likes',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: ()
                      {
                        NavigateTo(context, LikesScreen());
                      },
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
                              //TODO Comments
                              // '0 Comments',
                              '${model.nComments} Comments',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: ()
                      {
                        // NavigateTo(context, CommentScreen(model.postId));
                      },
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
                              //TODO Comments
                              // controller: SocialCubit.get(context)
                              //     .commentController[index],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write a comment...',
                                hintStyle: Theme.of(context).textTheme.caption,
                              ),
                              onFieldSubmitted: (String value) {
                                // SocialCubit.get(context).commentPost(
                                //     SocialCubit.get(context).postsId[index],
                                //     SocialCubit.get(context)
                                //         .commentController[index]
                                //         .text);
                                // SocialCubit.get(context)
                                //     .commentController[index]
                                //     .clear();
                                // SocialCubit.get(context).getDataUser();
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
                        .likePost(SocialCubit.get(context).posts[index].postId);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );

// Widget buildPostItem(context,PostModel model, index) => Card(
//   clipBehavior: Clip.antiAliasWithSaveLayer,
//   elevation: 5.0,
//   margin: const EdgeInsets.symmetric(
//     horizontal: 8.0,
//   ),
//   child: Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               radius: 25.0,
//               backgroundImage: NetworkImage(
//                 '${model.image}',
//               ),
//             ),
//             const SizedBox(
//               width: 15,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         '${model.userName}',
//                         style: Theme.of(context)
//                             .textTheme
//                             .subtitle1!
//                             .copyWith(
//                           fontWeight: FontWeight.bold,
//                           height: 1.4,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         Icons.check_circle,
//                         color: mainColor,
//                         size: 16.0,
//                       ),
//                     ],
//                   ),
//                   Text(
//                     '${model.dateTime!}',
//                     // '${DateFormat.yMMMMEEEEd().format(DateTime.parse(model.dateTime!))}',
//                     style: Theme.of(context).textTheme.caption!.copyWith(
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 15,
//             ),
//             //TODO More
//             IconButton(
//               onPressed: () {
//                 SocialCubit.get(context).deletePost(post: model, index: index);
//               },
//               icon: const Icon(
//                 IconBroken.More_Circle,
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 15.0,
//           ),
//           child: Container(
//             width: double.infinity,
//             height: 1.0,
//             color: Colors.grey[300],
//           ),
//         ),
//         //Text Body
//         if (model.text != null)
//           const SizedBox(
//             height: 5,
//           ),
//         if (model.text != null)
//           Text(
//             '${model.text}',
//             style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                 fontSize: 14.0,
//                 height: 1.3,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black),
//           ),
//         if (model.postImage != "")
//           Padding(
//             padding: const EdgeInsetsDirectional.only(
//               top: 10.0,
//             ),
//             child: Container(
//               width: double.infinity,
//               height: 140.0,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4.0),
//                 image: DecorationImage(
//                   image: NetworkImage(
//                     '${model.postImage}',
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//
//         // emojies bar
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: InkWell(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 5.0,
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           IconBroken.Heart,
//                           size: 20,
//                           color: Colors.red,
//                         ),
//                         const SizedBox(
//                           width: 5.0,
//                         ),
//                         Text(
//                           '${SocialCubit.get(context).likes[index]}',
//                           style: Theme.of(context).textTheme.caption,
//                         ),
//                       ],
//                     ),
//                   ),
//                   onTap: () {},
//                 ),
//               ),
//               Expanded(
//                 child: InkWell(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 5.0,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Icon(
//                           IconBroken.More_Circle,
//                           size: 20,
//                           color: mainColor,
//                         ),
//                         const SizedBox(
//                           width: 5.0,
//                         ),
//                         Text(
//                           //TODO
//                           '${SocialCubit.get(context).comments[index]} Comments',
//                           style: Theme.of(context).textTheme.caption,
//                         ),
//                       ],
//                     ),
//                   ),
//                   onTap: () {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(
//             bottom: 5.0,
//           ),
//           child: Container(
//             width: double.infinity,
//             height: 1.0,
//             color: Colors.grey[300],
//           ),
//         ),
//         Row(
//           children: [
//             //comment
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 5.0,
//                 ),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 18.0,
//                       backgroundImage: NetworkImage(
//                         '${SocialCubit.get(context).userModel!.image}',
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                     Expanded(
//                       child: Container(
//                         height: 30.0,
//                         child: TextFormField(
//                           controller: commentController,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Write a comment...',
//                             hintStyle:
//                             Theme.of(context).textTheme.caption,
//                           ),
//                           onFieldSubmitted: (String value) {
//                             SocialCubit.get(context).commentPost(
//                                 SocialCubit.get(context).postsId[index],
//                                 commentController.text);
//                             commentController.clear();
//                             SocialCubit.get(context).getDataUser();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             InkWell(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       IconBroken.Heart,
//                       size: 20,
//                       color: Colors.red,
//                     ),
//                     const SizedBox(
//                       width: 5.0,
//                     ),
//                     Text(
//                       'Like',
//                       style: Theme.of(context).textTheme.caption,
//                     ),
//                   ],
//                 ),
//               ),
//               onTap: () {
//                 SocialCubit.get(context)
//                     .likePost(SocialCubit.get(context).postsId[index]);
//               },
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// );

