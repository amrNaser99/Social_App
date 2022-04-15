import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:twasol/model/comment_model.dart';
import 'package:twasol/model/like_post_model.dart';
import 'package:twasol/shared/cubit/social_states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
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
  var padding = EdgeInsets.zero,

}) =>
    Padding(
      padding: padding,
      child: Container(
        width: width,
        height: 40.0,
        child: MaterialButton(
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: function,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.indigo,
        ),
      ),
    );

void NavigateTo(context, Widget) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void NavigateAndFinish(context, Widget) =>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => Widget), (
        route) => false);

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
  bool isShort = false,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: isShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      // backgroundColor: Colors.green,
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

Widget buildListSItem(data, context, index) =>
    Padding(
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

Widget myDivider() =>
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildChatItem(context, UserModel model) =>
    InkWell(
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
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                '${model.userName}',
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(
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

Widget buildLikeListSheet(
    {required BuildContext context, required LikesModel model, index}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '${model.profileImage}',
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
                        style: Theme
                            .of(context)
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
                    DateFormat.yMMMMEEEEd()
                        .format(DateTime.parse(model.dateTime!)),
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption!
                        .copyWith(
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                IconBroken.Heart,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildCommentListSheet(
    {required BuildContext context, required CommentModel model, state, path}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    '${model.profileImage}',
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
                            Theme
                                .of(context)
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
                        DateFormat.yMMMMEEEEd()
                            .format(DateTime.parse(model.dateTime!)),
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    IconBroken.Heart,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white12,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).audioPlay(path);
                        },
                        icon: const Icon(
                          Icons.play_arrow,
                        ),
                      ),
                      if (state is SocialAudioPlayStates)
                        ConditionalBuilder(
                          condition:
                          state is! SocialUploadVoiceRecordSuccessStates ||
                              state is! SocialAudioVoiceLoadingStates,
                          builder: (BuildContext context) {
                            return IconButton(
                              onPressed: () {
                                SocialCubit.get(context).audioPause(path);
                              },
                              icon: const Icon(
                                Icons.pause,
                              ),
                            );
                          },
                          fallback: (BuildContext context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).audioStop();
                        },
                        icon: const Icon(
                          Icons.stop,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.50,
                        // 150,
                        height: 10,
                        child: const LinearProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildVoiceSheet({
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.grey,
              child: Icon(IconBroken.Voice_2),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildPostItem(context,
    PostModel model,) {
  var commentController = model.controller;
  SocialCubit cubit = BlocProvider.of(context);
  // bool isLikedByMe = cubit.likedByMe(postId: model.postId) as bool;
  return Card(
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
                          Theme
                              .of(context)
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
                      DateFormat.yMMMMEEEEd()
                          .format(DateTime.parse(model.dateTime!)),
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption!
                          .copyWith(
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
                  cubit.deletePost(postId: model.postId);
                },
                icon: const Icon(
                  IconBroken.More_Circle,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          //Text Body
          const SizedBox(
            height: 10,
          ),
          if (model.text != null)
            Text(
              '${model.text}',
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(
                  fontSize: 14.0,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
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
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
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
                            "${model.likes} Likes",
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                        ],
                      ),
                    ),
                    //TODO onTap show Liked Users
                    onTap: () {
                      cubit.getLikes(postId: model.postId);
                      print('onTap show Liked Users');
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
                            '${model.nComments} Comments',
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      cubit.getComments(
                        postId: model.postId,
                      );
                      print('onTap show Comments Users');
                      cubit.loadInAudioCache(
                        postId: model.postId,
                      );
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
          Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.0,
                    backgroundImage: NetworkImage(
                      '${cubit.userModel!.image}',
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
                        controller: commentController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a comment...',
                          hintStyle: Theme
                              .of(context)
                              .textTheme
                              .caption,
                        ),
                        onFieldSubmitted: (String value) {
                          cubit.commentPost(
                              postId: model.postId!, textComment: value);
                          print('Comment Done');
                          commentController.clear();
                        },
                      ),
                    ),
                  ),

                  Padding(
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption,
                        ),
                      ],
                    ),
                  ),

                  ///
                  Container(
                    width: 1,
                    height: 20,
                    color: Colors.black45,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  // SocialMediaRecorder(
                  //   sendRequestFunction: (soundFile) {
                  //     cubit.soundFile = soundFile;
                  //     print(soundFile.path);
                  //     return soundFile.path;
                  //   },
                  //   encode: AudioEncoderType.AAC,
                  //   recordIcon: const Icon(IconBroken.Voice),
                  //   backGroundColor: Colors.transparent,
                  // ),
                  IconButton(
                    onPressed: () {
                      cubit.checkRecording(postId: model.postId);
                    },
                    icon: const Icon(
                      IconBroken.Voice,
                      color: Colors.red,
                    ),
                  ),
                ],
              )

            // Row(
            //   children: [
            //     Stack(
            //       children: [
            //         // profile image and write comment
            //         Align(
            //           alignment: AlignmentDirectional.centerStart,
            //           child: Row(
            //             children: [
            //               CircleAvatar(
            //                 radius: 18.0,
            //                 backgroundImage: NetworkImage(
            //                   '${cubit.userModel!.image}',
            //                 ),
            //               ),
            //               const SizedBox(
            //                 width: 15,
            //               ),
            //               Expanded(
            //                 child: Container(
            //                   height: 30.0,
            //                   child: TextFormField(
            //                     //TODO Comments
            //                     controller: commentController,
            //                     // enableSuggestions: true,
            //                     decoration: InputDecoration(
            //                       border: InputBorder.none,
            //                       hintText: 'Write a comment...',
            //                       hintStyle:
            //                           Theme.of(context).textTheme.caption,
            //                     ),
            //                     onFieldSubmitted: (String value) {
            //                       cubit.commentPost(
            //                           postId: model.postId!,
            //                           textComment: value);
            //                       print('Comment Done');
            //                       commentController.clear();
            //                     },
            //                   ),
            //                 ),
            //               ),
            //               Padding(
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
            //               Container(
            //                 width: 1,
            //                 height: 20,
            //                 color: Colors.black45,
            //               ),
            //               const SizedBox(
            //                 width: 4,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //     Stack(
            //       children: [
            //         SocialMediaRecorder(
            //           sendRequestFunction: (soundFile) {
            //             cubit.soundFile = soundFile;
            //             print(soundFile.path);
            //             return soundFile.path;
            //           },
            //           encode: AudioEncoderType.AAC,
            //           recordIcon: const Icon(IconBroken.Voice),
            //           backGroundColor: Colors.transparent,
            //           // radius: BorderRadius.all(Radius.circular(3)),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ),
        ],
      ),
    ),
  );
}
//============= old comment style ============//
// Row(
// children: [
// CircleAvatar(
// radius: 18.0,
// backgroundImage: NetworkImage(
// '${cubit.userModel!.image}',
// ),
// ),
// const SizedBox(
// width: 15,
// ),
// Expanded(
// child: Container(
// height: 30.0,
// child: TextFormField(
// //TODO Comments
// controller: commentController,
// // enableSuggestions: true,
// decoration: InputDecoration(
// border: InputBorder.none,
// hintText: 'Write a comment...',
// hintStyle: Theme.of(context).textTheme.caption,
// ),
// onFieldSubmitted: (String value) {
// cubit.commentPost(
// postId: model.postId!, textComment: value);
// print('Comment Done');
// commentController.clear();
// },
// ),
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// children: [
// const Icon(
// IconBroken.Heart,
// size: 20,
// color: Colors.red,
// ),
// const SizedBox(
// width: 5.0,
// ),
// Text(
// 'Like',
// style: Theme.of(context).textTheme.caption,
// ),
// ],
// ),
// ),
// ///
// Container(
// width: 1,
// height: 20,
// color: Colors.black45,
// ),
// const SizedBox(
// width: 4,
// ),
// SocialMediaRecorder(
// radius: BorderRadius.circular(2,),
// sendRequestFunction: (soundFile) {
// cubit.soundFile = soundFile ;
// print(soundFile.path);
// return soundFile.path;
// },
// encode: AudioEncoderType.AAC,
// recordIcon: const Icon(IconBroken.Voice),
// backGroundColor: Colors.transparent,
// // radius: BorderRadius.all(Radius.circular(3)),
// ),
// ],
// )
