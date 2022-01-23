import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialApp/shared/components/components.dart';
import 'package:socialApp/shared/cubit/social_cubit.dart';
import 'package:socialApp/shared/cubit/social_states.dart';
import 'package:socialApp/shared/styles/colors.dart';
import 'package:socialApp/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var userNameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if(state is SocialUpdateSuccessfullySuccessStates)
        {
          showToast(message: 'Update Done Successfully');
        }
      },
      builder: (BuildContext context, Object? state) {
        var userModel = SocialCubit
            .get(context)
            .userModel;
        var profileImage = SocialCubit
            .get(context)
            .profileImage;
        var coverImage = SocialCubit
            .get(context)
            .coverImage;
        userNameController.text = userModel!.userName!;
        bioController.text = userModel.bio!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                      userName: userNameController.text,
                      bio: bioController.text);
                  print('Update clicked');
                },
                text: 'UPDATE',
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.imgCover}')
                                        : FileImage(coverImage)
                                    as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage != null
                                    ? FileImage(profileImage)
                                    : NetworkImage('${userModel.image}')
                                as ImageProvider,
                              ),
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                radius: 18.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 18.0,
                                ),
                              ),
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit
                      .get(context)
                      .profileImage != null ||
                      SocialCubit
                          .get(context)
                          .coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit
                            .get(context)
                            .profileImage != null)
                          Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    color: primaryColor,
                                    text: 'Update Profile',
                                    function: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                          userName: userNameController.text,
                                          bio: bioController.text);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  const LinearProgressIndicator(),
                                ],
                              )),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit
                            .get(context)
                            .coverImage != null)
                          Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    color: primaryColor,
                                    text: 'Update Cover',
                                    function: ()
                                    {
                                      SocialCubit.get(context)
                                          .uploadCoverImage(
                                          userName: userNameController.text,
                                          bio: bioController.text);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  const LinearProgressIndicator()
                                ],
                              )),
                      ],
                    ),
                  if (SocialCubit
                      .get(context)
                      .profileImage != null ||
                      SocialCubit
                          .get(context)
                          .coverImage != null)
                    const SizedBox(
                      height: 20.0,
                    ),
                  defaultTextFormField(
                    controller: userNameController,
                    keyboardType: TextInputType.name,
                    prefixIcon: IconBroken.User,
                    labelText: 'UserName',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                      controller: bioController,
                      keyboardType: TextInputType.name,
                      prefixIcon: IconBroken.Edit,
                      labelText: 'Bio'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
