import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialApp/model/massege_model.dart';
import 'package:socialApp/model/user_model.dart';
import 'package:socialApp/shared/cubit/social_cubit.dart';
import 'package:socialApp/shared/cubit/social_states.dart';
import 'package:socialApp/shared/styles/colors.dart';
import 'package:socialApp/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  late UserModel userModel;

  var messageController = TextEditingController();

  ChatDetailsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        '${userModel.userName}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty || SocialCubit.get(context).messages.isEmpty,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            addAutomaticKeepAlives: true,
                            dragStartBehavior: DragStartBehavior.down,
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).userModel!.uId ==
                                  message.senderId) {
                                return buildMyMessage(context, message);
                              } else {
                                return buildMessage(context, message);
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15.0,
                            ),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                            border: Border.all(
                              color: greyColor,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                height: 50.0,
                                onPressed: () {
                                  // SocialCubit.get(context).uploadPostImage(dateTime: DateTime.now().toString(), text: text)
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Image,
                                  size: 20.0,
                                  color: mainColor,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50.0,
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                      hintText: 'Type Your Massege Here',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.0,
                                child: MaterialButton(
                                  color: mainColor,
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId!,
                                      dataTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                    messageController.clear();
                                  },
                                  minWidth: 1.0,
                                  child: const Icon(
                                    IconBroken.Send,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (BuildContext context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(context, MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text(
            model.text!,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
          ),
        ),
      );

  Widget buildMyMessage(context, MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text(
            model.text!,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 18.0,
                ),
          ),
        ),
      );
}
