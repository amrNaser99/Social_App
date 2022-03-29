import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/cubit/social_cubit.dart';
import '../../../shared/cubit/social_states.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        TextEditingController searchController = TextEditingController();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: Theme
                      .of(context)
                      .textTheme
                      .caption,

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  prefixIcon: const Icon(Icons.search),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field must be not Empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (String value) {
                  SocialCubit.get(context).searchUsername(userName: value);
                },
                onFieldSubmitted: (String value) {
                  SocialCubit.get(context).searchUsername(userName: value);
                },
              ),
            ),
            


          ],
        );
        //   ConditionalBuilder(
        //   condition: SocialCubit.get(context).users.isNotEmpty,
        //   builder: (BuildContext context) => ListView.separated(
        //     physics: const BouncingScrollPhysics(),
        //     itemBuilder: (context, index) =>
        //         buildChatItem(context, SocialCubit.get(context).users[index]),
        //     separatorBuilder: (context, index) =>  myDivider(),
        //     itemCount: SocialCubit.get(context).users.length,
        //   ),
        //   fallback: (BuildContext context) =>
        //   const Center(child: CircularProgressIndicator()),
        // );
      },
    );
  }

}
