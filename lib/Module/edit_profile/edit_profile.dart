import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialApp/shared/components/components.dart';
import 'package:socialApp/shared/cubit/social_cubit.dart';
import 'package:socialApp/shared/cubit/social_states.dart';
import 'package:socialApp/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  var userNameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {

        var userModel = SocialCubit.get(context).userModel;
        userNameController.text = userModel!.userName!;
        bioController.text = userModel.bio!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                onPressed: () {},
                text: 'UPDATE',
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: Padding(
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
                                  image: NetworkImage('${userModel.imgCover}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 18.0,
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
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                              ),
                            ),
                          ),
                          const CircleAvatar(
                            radius: 18.0,
                            child: Icon(
                              IconBroken.Camera,
                              size: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
        );
      },
    );
  }
}

// Scaffold
// (
// appBar: defaultAppBar
// (
// context: context,title: '
// Edit Post
// '
// ,
// actions: [
// defaultTextButton
// (
// onPressed: () {},
// text: '
// UPDATE
// '
// ,
// )
// ,
// const SizedBox(width: 10.0
// ,
// )
// ,
// ]
// ,
// )
// ,
// body: Padding
// (
// padding: const EdgeInsets.all(8.0
// )
// ,
// child: Column
// (
// children: [
// Container
// (
// height: 200
// ,
// child: Stack
// (
// alignment: AlignmentDirectional.bottomCenter,children: [
// Align
// (
// alignment: AlignmentDirectional.topCenter,child: Stack
// (
// alignment: AlignmentDirectional.topEnd,children: [
// Container
// (
// width: double.infinity,height: 150.0
// ,
// decoration: BoxDecoration
// (
// borderRadius: const BorderRadius.only(topLeft: Radius.circular(4.0
// )
// ,
// topRight: Radius.circular(4.0
// )
// ,
// )
// ,
// image: DecorationImage
// (
// image: NetworkImage
// (
// // '${userModel!.imgCover}',
// 'imgCover
// '
// ,
// )
// ,
// fit: BoxFit.cover,)
// ,
// )
// ,
// )
// ,
// const Padding(padding: EdgeInsets.all(10.0
// )
// ,
// child: CircleAvatar
// (
// radius: 22.0
// ,
// backgroundColor: Colors.white,child: CircleAvatar
// (
// radius: 20.0
// ,
// child: Icon
// (
// IconBroken.Camera,size: 18.0,
// ),
// ),
// ),
// ),
// ]
// ,
// )
// ,
// )
// ,
// Stack
// (
// alignment: AlignmentDirectional.bottomEnd,children: [
// CircleAvatar
// (
// radius: 64.0
// ,
// backgroundColor:Theme.of(context).
// scaffoldBackgroundColor,child: CircleAvatar
// (
// radius: 60.0
// ,
// backgroundImage: NetworkImage
// (
// // '${userModel.image}',
// 'image
// '
// )
// ,
// )
// ,
// )
// ,
// const CircleAvatar(radius: 22.0
// ,
// backgroundColor: Colors.white,child: CircleAvatar
// (
// radius: 20.0
// ,
// child: Icon
// (
// IconBroken.Edit,size: 20.0,
// ),
// ),
// ),
// ],
// )
// ,
// ]
// ,
// )
// ,
// )
// ,
// const SizedBox(height: 20.0
// ,
// )
// ,
// defaultTextFormField
// (
// controller: userNameController,labelText: '
// userName
// '
// ,
// keyboardType: TextInputType.name,prefixIcon: IconBroken.User,)
// ,
// const SizedBox(height: 10.0
// ,
// )
// ,
// defaultTextFormField
// (
// controller: bioController,labelText: '
// Bio...
// '
// ,
// // hintText: {userModel.bio},
// keyboardType: TextInputType.name,prefixIcon: IconBroken.Info_Circle,
// ),
// ],
// ),
// ),
// );
