import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialApp/Module/edit_profile/edit_profile.dart';
import 'package:socialApp/shared/components/components.dart';
import 'package:socialApp/shared/cubit/social_cubit.dart';
import 'package:socialApp/shared/cubit/social_states.dart';
import 'package:socialApp/shared/styles/colors.dart';
import 'package:socialApp/shared/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if(state is SocialCreatePostSuccessStates)
          {
            SocialCubit.get(context).postImage = null ;
            SocialCubit.get(context).coverImage = null ;
          }
        },
        builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              width: double.infinity,
                              height: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage('${userModel!.imgCover}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${userModel.userName}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '${userModel.bio}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '100',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    'Posts',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '265',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    'Photos',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '10k',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    'Followers',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '54',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    'Following',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Add Photo',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: mainColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            NavigateTo(
                              context,
                              EditProfileScreen(),
                            );
                          },
                          child: Icon(
                            IconBroken.Edit,
                            color: mainColor,
                            size: 20.0,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
