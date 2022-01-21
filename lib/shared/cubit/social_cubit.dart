import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialApp/Module/nav_bar/chats/chats_screen.dart';
import 'package:socialApp/Module/nav_bar/home/feeds_screen.dart';
import 'package:socialApp/Module/nav_bar/post/post_screen.dart';
import 'package:socialApp/Module/nav_bar/setting/setting_screen.dart';
import 'package:socialApp/Module/nav_bar/users/users_screen.dart';
import 'package:socialApp/model/user_model.dart';
import 'package:socialApp/shared/components/constants.dart';
import 'package:socialApp/shared/cubit/social_states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getDataUser() {
    FirebaseFirestore.
    instance.
    collection('users')
        .doc(uId)
        .get()
        .then((value) {
          print(value.data());
          userModel = UserModel.fromJson(value.data()!);
          emit(SocialGetUserDataSuccessStates());
        })
        .catchError((error) {
          print(error.toString());
          emit(SocialGetUserDataErrorStates(error.toString()));
        });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const PostScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];

  void changeNavItems(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeNavBarState());
    }
  }

  List<String> appBarTitles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];




  XFile? profileImage ;
  final profileImagePicker = ImagePicker();

  Future<void> getProfileImage() async
  {
    final pickedFile =  await profileImagePicker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      profileImage = XFile(pickedFile.path);
      emit(SocialProfileImageSuccessStates());
    }
    else
      {
        print('No Image Selected.');
        emit(SocialProfileImageErrorStates());
      }
  }


  XFile? coverImage ;
  final coverImagePicker = ImagePicker();

  Future<void> getCoverImage() async
  {
    final pickedFile =  await coverImagePicker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      coverImage = XFile(pickedFile.path);
      emit(SocialCoverImageSuccessStates());
    }
    else
    {
      print('No Image Selected.');
      emit(SocialCoverImageErrorStates());
    }
  }
}
