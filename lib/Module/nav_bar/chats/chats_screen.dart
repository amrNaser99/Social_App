import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialApp/Module/chat_details/chat_details_screen.dart';
import 'package:socialApp/model/user_model.dart';
import 'package:socialApp/shared/components/components.dart';
import 'package:socialApp/shared/cubit/social_cubit.dart';
import 'package:socialApp/shared/cubit/social_states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (BuildContext context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(context, SocialCubit.get(context).users[index]),
            separatorBuilder: (context, index) =>  myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

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
}
