import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:twasol/Module/nav_bar/chats/chats_screen.dart';
import 'package:twasol/Module/nav_bar/post/post_screen.dart';
import 'package:twasol/Module/nav_bar/users/users_screen.dart';
import 'package:twasol/model/comment_model.dart';
import 'package:twasol/model/like_post_model.dart';
import 'package:twasol/model/massege_model.dart';
import 'package:twasol/model/post_model.dart';
import 'package:twasol/model/user_model.dart';
import '../../Module/nav_bar/profile/profile_screen.dart';
import '../components/constants.dart';
import 'package:twasol/shared/cubit/social_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Module/nav_bar/home/home_screen.dart';
import '../styles/icon_broken.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  Future<void> getDataUser() async {
    emit(SocialGetUserDataLoadingStates());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      print(value.data());

      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserDataSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserDataErrorStates(error.toString()));
    });
  }

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
                emit(SocialCreatePostErrorStates(error));
              })
            })
        .catchError((error) {
      emit(SocialCreatePostErrorStates(error));
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
      dateTime: DateTime.now().toString(),
      text: text,
      postImage: postImage ?? '',
      // controller: TextEditingController(),
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessStates());
    }).catchError((error) {
      emit(SocialCreatePostErrorStates(error));
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageStates());
  }

  List<PostModel> posts = [];

  List postsId = [];

//get All posts to Feeds -------------------------------------
  bool postsLoadedSuccessfully = false;

  bool userDataLoadedSuccessfully = false;

  Future<void> getPosts() async {
    emit(SocialGetPostsDataLoadingStates());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      event.docs.forEach((element) async {
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
        var likes = await element.reference.collection('likes').get();
        var comments = await element.reference.collection('comments').get();
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(element.id)
            .update({
          'likes': likes.docs.length,
          'nComments': comments.docs.length,
          'postId': element.id,
        });
      });
      emit(SocialGetPostsDataSuccessStates());
    });
  }

  void likePost({
    String? postId,
  }) async {
    emit(SocialLikePostsLoadingStates());
    LikesModel likesModel = LikesModel(
      userName: userModel!.userName,
      uId: userModel!.uId,
      profileImage: userModel!.image,
      postId: postId,
      dateTime: DateTime.now().toString(),
    );

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set(likesModel.toMap())
        .then((value) {
      getPosts();
      print('${userModel!.uId} Liked Succesfully');
      emit(SocialLikePostsSuccessStates());
    }).catchError((error) {
      emit(SocialLikePostsErrorStates(error));
    });
  }

  List<LikesModel> peopleReacted = [];

  void getLikes({
    String? postId,
  }) {
    emit(SocialGetLikesCountLoadingStates());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .snapshots()
        .listen((event) {
      peopleReacted = [];
      event.docs.forEach((element) {
        peopleReacted.add(LikesModel.fromJson(element.data()));
      });
      if (peopleReacted.contains(userModel!.uId)) {
        // disLikePost();
      }
      print('peaole reacted ${peopleReacted.length}');

      emit(SocialGetLikesCountSuccessStates());
      emit(SocialOpenLikeSheetStates());
    });
  }

  void disLikePost({
    String? postId,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      getPosts();
      emit(SocialDisLikePostSuccessState());
    }).catchError((error) {
      emit(SocialDisLikePostErrorState(error));
      print(error.toString());
    });
  }

  Future<bool> likedByMe({
    String? postId,
  }) async {
    emit(SocialLikedByMeCheckedLoadingState());
    bool isLikedByMe = false;
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((event) async {
      var likes = await event.reference.collection('likes').get();
      likes.docs.forEach((element) {
        if (element.id == userModel!.uId) {
          isLikedByMe = true;
          disLikePost(postId: postId);
        }
      });
      if (isLikedByMe == false) {
        likePost(postId: postId);
      }
      print(isLikedByMe);
      emit(SocialLikedByMeCheckedSuccessState());
    });
    return isLikedByMe;
  }

  void commentPost({required String postId, required String commentText}) {
    CommentModel commentModel = CommentModel(
      userName: userModel!.userName,
      comment: commentText,
      uId: userModel!.uId,
      profileImage: userModel!.image,
      postId: postId,
      dateTime: DateTime.now().toString(),
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set(
          commentModel.toMap(),
        )
        .then((value) {
      getPosts();
      print('${userModel!.uId} Comment Successfully');

      emit(SocialCommentsPostsSuccessStates());
      emit(SocialOpenCommentSheetStates());
    }).catchError((error) {
      emit(SocialCommentsPostsSuccessStates());
    });
  }

  List<CommentModel> peopleComments = [];

  void getComments({String? postId}) {
    emit(SocialGetCommentsLoadingStates());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .listen((event) {
      peopleComments = [];
      event.docs.forEach((element) {
        peopleComments.add(CommentModel.fromJson(element.data()));
      });
      print('number of people Comments ${peopleComments.length}');
      emit(SocialGetCommentsSuccessStates());
      emit(SocialOpenCommentSheetStates());
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
    required String? postId,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      print(postId);
      posts.remove(postsId);
      // posts.clear();
      getPosts();
      emit(SocialDeletePostSuccessStates());
    }).catchError((error) {
      emit(SocialDeletePostErrorStates(error.toString()));
    });
  }

// Sign Out ---------------
  void signOut() async {
    emit(SocialSignOutLoadingStates());
    await FirebaseAuth.instance.signOut();
    token = null;
    uId = null;

    emit(SocialSignOutSuccessStates());
  }

  Future<void> searchUsername({required String userName}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('userName' == userName)
        .get()
        .then((value) {
      print(value.docs.length);
    }).catchError((error) {
      emit(SocialSearchUserNameErrorStates(error));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    const ChatsScreen(),
    PostScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];

  List<Widget> tabs = [
    Tab(
      icon: Icon(IconBroken.Home),
    ),
    Tab(
      icon: Icon(IconBroken.Location),
    ),
    Tab(
      icon: Icon(IconBroken.Chat),
    ),
    Tab(
      icon: Icon(IconBroken.Profile),
    ),
  ];

  void changeNavItems(int index) {
    if (index == 0) {
      getPosts();
    }
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
    'Profile',
  ];

  List appBarIcons = [
    [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          IconBroken.Notification,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          IconBroken.Search,
        ),
      ),
    ],
    [],
  ];

  bool isRecord = false;
  Record audioRecorder = Record();


  Future voiceStartRecord() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
      Permission.manageExternalStorage,
    ].request();

    bool permissionsGranted = permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted && permissions[Permission.manageExternalStorage]!.isGranted;

    if (permissionsGranted) {
      print('in permissionsGranted');
      Directory appFolder = Directory(Paths.recording);
      bool appFolderExists = await appFolder.exists();
      if (!appFolderExists) {
        final created = await appFolder.create(recursive: true);
        print(created.path);
      }
      final filepath = Paths.recording +
          '/' +
          DateTime
              .now()
              .millisecondsSinceEpoch
              .toString() +
          '.wav';
      print(filepath);

      await audioRecorder.start(path: filepath);

      isRecord = true;
      emit(SocialVoiceRecordOn());
    }
  }
  Future voiceStopRecord() async
  {
    String? path = await audioRecorder.stop();
    emit(SocialVoiceRecordOff());
    print('Output path $path');
  }
  Future voiceResumeRecord() async
  {
    await audioRecorder.resume();
    emit(SocialVoiceRecordOn());
  }
  void voiceRecorder() {
    emit(SocialVoiceRecorderLoadingStates());
  }
}
