import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twasol/Module/nav_bar/chats/chats_screen.dart';
import 'package:twasol/Module/nav_bar/post/post_screen.dart';
import 'package:twasol/Module/nav_bar/setting/setting_screen.dart';
import 'package:twasol/Module/nav_bar/users/users_screen.dart';
import 'package:twasol/model/massege_model.dart';
import 'package:twasol/model/post_model.dart';
import 'package:twasol/model/user_model.dart';
import 'package:twasol/shared/components/constants.dart';
import 'package:twasol/shared/cubit/social_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Module/nav_bar/home/feeds_screen.dart';
// import '../../Module/nav_bar/home/feeds_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getDataUser() {
    emit(SocialGetUserDataLoadingStates());
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
    UsersScreen(),
    PostScreen(),
    ChatsScreen(),
    SettingScreen(),
  ];

  void changeNavItems(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 3) {
      getUsersWithChat();
    }
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
      return NetworkImage(
        '${userModel!.image}',
      );
    } else {
      return FileImage(File(profileImage!.path));
    }
  }

  String profileImageUrl = '';

  Future uploadProfileImage({
    required String userName,
    required String bio,
  }) async {
    await firebase_storage.FirebaseStorage.instance
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

  Future uploadCoverImage({
    required String userName,
    required String bio,
  }) async {
    await firebase_storage.FirebaseStorage.instance
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

  Future uploadPostImage({
    required String dateTime,
    required String text,
  }) async {
    emit(SocialCreatePostLoadingStates());
    print('in Upload Post Image ');
    await firebase_storage.FirebaseStorage.instance
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
  List<TextEditingController> commentController = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void _getPosts() {
    emit(SocialGetPostsDataLoadingStates());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
      posts = [];
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

  void getPosts({AsyncSnapshot<QuerySnapshot>? snapshot}) async {
    emit(SocialGetPostsDataLoadingStates());
    posts = [];
    if (snapshot == null) {
      emit(SocialGetPostsDataLoadingStates());

      FirebaseFirestore.instance
          .collection('posts')
          .orderBy('dateTime', descending: true)
          .get()
          .then((value) {
        // posts = [];
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
        SocialGetPostsDataErrorStates(error);
      });
    }

    else {
      snapshot.data!.docs.forEach((element) {
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data() as Map<String, dynamic>));
        // element.reference.collection('likes').snapshots().listen((event) {
        // likes.add(event.docs.length);
        // });
        // element.reference.collection('comments').snapshots().listen((event) {
        // comments.add(event.docs.length);
        // });
        emit(SocialGetPostsDataSuccessStates());
      });
    }
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'likes': true,
    }).then((value) {
      emit(SocialLikePostsSuccessStates());
    }).catchError((error) {
      emit(SocialLikePostsErrorStates(error));
    });
  }

  void commentPost(String postId, String commentText) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comment': commentText,
    }).then((value) {
      emit(SocialCommentsPostsSuccessStates());
    }).catchError((error) {
      emit(SocialCommentsPostsSuccessStates());
    });
  }

  List<UserModel> users = [];
  List usersWithChat = [];
  List<UserModel> chatUsers = [];

  void getUsersWithChat() {
    emit(SocialGetUsersWithChatLoadingStates());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .get()
        .then((value) {
      print(value.docs);
      print('in Then Fum');
      value.docs.forEach((element) {
        print(element.data());
        print('in ForEach Fum');
        var i = 0;
        usersWithChat.add(element.id);
        if (users[i].uId == element.id) {
          chatUsers.add(users[i]);
        }
      });

      print('========================');
      print(usersWithChat[1]);
      emit(SocialGetUsersWithChatSuccessStates());
    }).catchError((error) {
      emit(SocialGetUsersWithChatErrorStates(error));
    });
  }

  void getAllUsers() {
    emit(SocialGetAllUsersLoadingStates());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessStates());
      }).catchError((error) {
        print(error);
        emit(SocialGetAllUsersErrorStates(error));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dataTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dataTime: dataTime,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      SocialSendMessageErrorStates();
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      SocialSendMessageErrorStates();
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    emit(SocialGetMessagesLoadingStates());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];
      print(messages);
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessagesSuccessStates());
    });
  }

  void deletePost({
    required PostModel post,
    required int index,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId[index])
        .delete()
        .then((value) {
      print(postsId[index]);
      posts.remove(postsId[index]);
      // posts.clear();
      getPosts();
      emit(SocialDeletePostSuccessStates());
    }).catchError((error) {
      emit(SocialDeletePostErrorStates(error.toString()));
    });
  }
}
