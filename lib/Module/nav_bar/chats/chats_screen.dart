import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubit/social_cubit.dart';
import '../../../shared/cubit/social_states.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).chatUsers.isNotEmpty,
          builder: (BuildContext context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(
                context, SocialCubit.get(context).chatUsers[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).chatUsers.length,
          ),
          fallback: (BuildContext context) =>
              const Center(child: Text('No Chat Yet')),
        );
      },
    );
  }
}
