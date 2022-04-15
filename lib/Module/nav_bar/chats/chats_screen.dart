import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubit/social_cubit.dart';
import '../../../shared/cubit/social_states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SocialMediaRecorder(
                  sendRequestFunction: (soundFile) {
                    print("the current path is ${soundFile.path}");
                    },
                  encode: AudioEncoderType.AAC,
                ),
              )
            ],
          ),
        );
        //   ConditionalBuilder(
        //   condition: true,
        //   // SocialCubit.get(context).chatUsers.isNotEmpty,
        //   builder: (BuildContext context) => ListView.separated(
        //     physics: const BouncingScrollPhysics(),
        //     itemBuilder: (context, index) =>
        //         buildChatItem(context, SocialCubit.get(context).chatUsers[index]),
        //     separatorBuilder: (context, index) =>  myDivider(),
        //     itemCount: SocialCubit.get(context).chatUsers.length,
        //   ),
        //   fallback: (BuildContext context) =>
        //       const Center(child: CircularProgressIndicator()),
        // );
      },
    );
  }

}
