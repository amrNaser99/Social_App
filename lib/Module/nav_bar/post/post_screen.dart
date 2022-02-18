import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasol/shared/components/components.dart';
import 'package:twasol/shared/cubit/social_cubit.dart';
import 'package:twasol/shared/cubit/social_states.dart';
import 'package:twasol/shared/styles/colors.dart';
import 'package:twasol/shared/styles/icon_broken.dart';

class PostScreen extends StatelessWidget {

  var textController = TextEditingController();

  PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if(state is SocialCreatePostSuccessStates)
        {
          SocialCubit.get(context).get_Posts();
          SocialCubit.get(context).changeNavItems(0);
          SocialCubit.get(context).removePostImage();
          Navigator.pop(context);

        }
      },
      builder: (BuildContext context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Posts',
                  actions:
                  [
            defaultTextButton(
              onPressed: () {
                if (SocialCubit.get(context).postImage == null) {
                  SocialCubit.get(context).createPost(
                    dateTime: DateTime.now().toString(),
                    text: textController.text,
                  );
                } else {
                  SocialCubit.get(context).uploadPostImage(
                    dateTime: DateTime.now().toString(),
                    text: textController.text,
                  );
                }
              },
              text: 'POST',
            ),
            const SizedBox(
              width: 8.0,
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingStates)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingStates)
                  const SizedBox(
                    height: 5.0,
                  ),
                Row(
                  children: [
                     CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel!.image}',
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
                                '${SocialCubit.get(context).userModel!.userName}',
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on Your Mind, ${userModel!.userName}',
                      border: InputBorder.none,
                    ),
                  ),
                )),
                const SizedBox(
                  height: 10.0,
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.0,
                        ),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Add Photos',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              '#',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            // Icon(IconBroken.Shield_Fail),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'TAGS',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
