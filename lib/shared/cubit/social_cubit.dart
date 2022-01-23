import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialApp/Module/nav_bar/chats/chats_screen.dart';
import 'package:socialApp/Module/nav_bar/home/feeds_screen.dart';
import 'package:socialApp/Module/nav_bar/post/post_screen.dart';
import 'package:socialApp/Module/nav_bar/setting/setting_screen.dart';
import 'package:socialApp/Module/nav_bar/users/users_screen.dart';
import 'package:socialApp/model/post_model.dart';
import 'package:socialApp/model/user_model.dart';
import 'package:socialApp/shared/components/constants.dart';
import 'package:socialApp/shared/cubit/social_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getDataUser() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());

      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserDataSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserDataErrorStates(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostScreen(),
    UsersScreen(),
    SettingScreen(),
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

  File? profileImage;

  var profileImagePicker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile =
        await profileImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);

      emit(SocialProfileImageSuccessStates());
    } else {
      print('No Image Selected.');
      emit(SocialProfileImageErrorStates());
    }
  }

  File? coverImage;

  var coverImagePicker = ImagePicker();

  Future<void> getCoverImage() async {
    final pickedFile =
        await coverImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImageSuccessStates());
    } else {
      print('No Image Selected.');
      emit(SocialCoverImageErrorStates());
    }
  }

  ImageProvider? putProfileImage() {
    if (coverImage == null) {
      NetworkImage(
        '${userModel!.image}',
      );
    } else {
      FileImage(File(profileImage!.path));
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage({
    required String userName,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                updateUser(
                  userName: userName,
                  bio: bio,
                  image: value,
                );
                emit(SocialUploadProfileImageSuccessStates());
              }).catchError((error) {
                emit(SocialUploadProfileImageErrorStates());
              })
            })
        .catchError((error) {
      emit(SocialUploadProfileImageErrorStates());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage({
    required String userName,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                updateUser(
                  userName: userName,
                  bio: bio,
                  cover: value,
                );

                emit(SocialUploadCoverImageSuccessStates());
              }).catchError((error) {
                emit(SocialUploadCoverImageErrorStates());
              })
            })
        .catchError((error) {
      emit(SocialUploadCoverImageErrorStates());
    });
  }

  void updateUser({
    required String userName,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel model = UserModel(
      userName: userName,
      email: userModel!.email,
      bio: bio,
      image: image ?? userModel!.image,
      imgCover: cover ?? userModel!.imgCover,
      isEmailVerified: userModel!.isEmailVerified,
      phone: userModel!.phone,
      uId: userModel!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getDataUser();
      emit(SocialUpdateSuccessfullySuccessStates());
    }).catchError((error) {
      emit(SocialUserUpdateErrorStates());
    });
  }

  File? postImage;

  var postImagePicker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile =
        await postImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessStates());
    } else {
      print('No Image Selected.');
      emit(SocialPostImagePickedErrorStates());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                print(value);

                createPost(
                  dateTime: dateTime,
                  text: text,
                  postImage: value,
                );

                emit(SocialCreatePostSuccessStates());
              }).catchError((error) {
                emit(SocialCreatePostErrorStates());
              })
            })
        .catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingStates());

    PostModel model = PostModel(
        userName: userModel!.userName,
        image: userModel!.image,
        uId: userModel!.uId,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessStates());
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageStates());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    emit(SocialGetPostsDataLoadingStates());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      emit(SocialLikePostsLoadingStates());
      value.docs.forEach((element) {

        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialLikePostsSuccessStates());
        }).catchError((error) {
          emit(SocialLikePostsErrorStates(error.toString()));
        });

        emit(SocialCreatePostLoadingStates());

        element.reference.collection('comments').get().then((value) {

          comments.add(value.docs.length);
          emit(SocialCommentsPostsSuccessStates());
        }).catchError((error) {

          emit(SocialCommentsPostsErrorStates(error));
        });
      });

      emit(SocialGetPostsDataSuccessStates());
    }).catchError((error) {
      SocialGetPostsDataErrorStates(error.toString());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'likes': true}).then((value) {
      emit(SocialLikePostsSuccessStates());
    }).catchError((error) {
      emit(SocialLikePostsErrorStates(error.toString()));
    });
  }

  void commentPost(String postId, String commentText) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': commentText}).then((value) {
      emit(SocialCommentsPostsSuccessStates());
    }).catchError((error) {
      emit(SocialCommentsPostsSuccessStates());
    });
  }
}
