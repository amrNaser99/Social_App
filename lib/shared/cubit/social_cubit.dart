import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:twasol/Module/nav_bar/chats/chats_screen.dart';
import 'package:twasol/Module/nav_bar/post/post_screen.dart';
import 'package:twasol/Module/nav_bar/users/users_screen.dart';
import 'package:twasol/model/comment_model.dart';
import 'package:twasol/model/like_post_model.dart';
import 'package:twasol/model/massege_model.dart';
import 'package:twasol/model/post_model.dart';
import 'package:twasol/model/user_model.dart';
import 'package:twasol/shared/components/components.dart';
import '../../Module/nav_bar/profile/profile_screen.dart';
import '../../model/notification_model.dart';
import '../components/constants.dart';
import 'package:twasol/shared/cubit/social_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import '../components/notifications.dart';
import '../styles/icon_broken.dart';
import '../../Module/nav_bar/home/home_screen.dart';

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
      debugPrint(error.toString());
      emit(SocialGetUserDataErrorStates(error));
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
      debugPrint('No Image Selected.');
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
      debugPrint('No Image Selected.');
      emit(SocialCoverImageErrorStates());
    }
  }

  Future<ImageProvider?> putProfileImage() async {
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

  Future<void> uploadCoverImage({
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

  Future<void> updateUser({
    required String userName,
    required String bio,
    String? image,
    String? cover,
  }) async {
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

    await FirebaseFirestore.instance
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
      debugPrint('No Image Selected.');
      emit(SocialPostImagePickedErrorStates());
    }
  }

  Future<void> uploadPostImage({
    required String dateTime,
    required String text,
  }) async {
    emit(SocialCreatePostLoadingStates());
    debugPrint('in Upload Post Image ');
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                debugPrint(value);

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

  Future<void> createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) async {
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

    await FirebaseFirestore.instance
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
    PostModel? postModel,
  }) async {
    emit(SocialLikePostsLoadingStates());
    LikesModel likesModel = LikesModel(
      userName: userModel!.userName,
      uId: userModel!.uId,
      profileImage: userModel!.image,
      postId: postModel!.postId,
      dateTime: DateTime.now().toString(),
    );

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set(likesModel.toMap())
        .then((value) {
      getPosts();
      if (postModel.uId != userModel!.uId) {
        disLikePost(postId: postModel.postId);
      }
      debugPrint('${userModel!.uId} Liked Succesfully');
      emit(SocialLikePostsSuccessStates());
    }).catchError((error) {
      emit(SocialLikePostsErrorStates(error));
    });
  }

  List<LikesModel> peopleReacted = [];

  void getLikes({
    String? postId,
  }) async {
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
    });
    debugPrint('peaole reacted ${peopleReacted.length}');
    emit(SocialGetLikesCountSuccessStates());
  }

  void disLikePost({
    String? postId,
  }) async {
    await FirebaseFirestore.instance
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
      debugPrint(error.toString());
    });
  }

  //
  // Future<bool> likedByMe({
  //   String? postId,
  // }) async {
  //   emit(SocialLikedByMeCheckedLoadingState());
  //   bool isLikedByMe = false;
  //   await FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .get()
  //       .then((event) async {
  //     var likes = await event.reference.collection('likes').get();
  //     likes.docs.forEach((element) {
  //       if (element.id == userModel!.uId) {
  //         isLikedByMe = true;
  //         disLikePost(postId: postId);
  //       }
  //     });
  //     if (isLikedByMe == false) {
  //       likePost(postId: postId);
  //     }
  //     debugPrint(isLikedByMe);
  //     emit(SocialLikedByMeCheckedSuccessState());
  //   });
  //   return isLikedByMe;
  // }

  void commentPost({
    required String postId,
    String? textComment,
    var voiceComment,
  }) async {
    CommentModel? commentModel;
    if (textComment != null && voiceComment == null) {
      commentModel = CommentModel(
        userName: userModel!.userName,
        comment: textComment,
        uId: userModel!.uId,
        profileImage: userModel!.image,
        postId: postId,
        dateTime: DateTime.now().toString(),
      );
    } else if (textComment == null && voiceComment != null) {
      commentModel = CommentModel(
        userName: userModel!.userName,
        uId: userModel!.uId,
        profileImage: userModel!.image,
        postId: postId,
        dateTime: DateTime.now().toString(),
        voice: voiceComment,
      );
    } else if (textComment != null && voiceComment != null) {
      commentModel = CommentModel(
        userName: userModel!.userName,
        comment: textComment,
        uId: userModel!.uId,
        profileImage: userModel!.image,
        postId: postId,
        dateTime: DateTime.now().toString(),
        voice: voiceComment,
      );
    } else {
      showToast(message: 'Comment Error !');
    }

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set(
          commentModel!.toMap(),
        )
        .then((value) {
      getPosts();
      debugPrint('${userModel!.uId} Comment Successfully');

      emit(SocialCommentsPostsSuccessStates());
    }).catchError((error) {
      emit(SocialCommentsPostsErrorStates(error));
    });
  }

  List<CommentModel> peopleComments = [];

  Future<void> getComments({String? postId}) async {
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
      debugPrint('number of people Comments ${peopleComments.length}');
    });
    emit(SocialGetCommentsSuccessStates());
  }

  List<UserModel> users = [];
  List usersWithChat = [];
  List<UserModel> chatUsers = [];

  void getUsersWithChat() async {
    emit(SocialGetUsersWithChatLoadingStates());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .get()
        .then((value) {
      print(value.docs);
      debugPrint('in Then Fum');
      value.docs.forEach((element) {
        print(element.data());
        debugPrint('in ForEach Fum');
        var i = 0;
        usersWithChat.add(element.id);
        if (users[i].uId == element.id) {
          chatUsers.add(users[i]);
        }
      });

      debugPrint('========================');
      debugPrint(usersWithChat[1]);
      emit(SocialGetUsersWithChatSuccessStates());
    }).catchError((error) {
      emit(SocialGetUsersWithChatErrorStates(error.toString()));
    });
  }

  void getAllUsers() async {
    emit(SocialGetAllUsersLoadingStates());
    if (users.isEmpty) {
      await FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUsersSuccessStates());
      }).catchError((error) {
        debugPrint(error);
        emit(SocialGetAllUsersErrorStates(error));
      });
    }
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      var postUrl = 'https://fcm.googleapis.com/fcm/send';
      await http.post(
        Uri.parse(postUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA9xPglTQ:APA91bEuI1Hg2Mw6dLpBuh2bDvJfgcYOUm_rEUhq3glaPRzICYtTUQEG6iFF1r_EeWx3B_wC9sTDVxk0x1PYgcSh-N9Di4qG-GNF3LVDjhc9F5B_cfEqvdky-Rc1ILwdAc1oqtB5Ho8v',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  void sendMessage({
    required String receiverId,
    required String dataTime,
    required String text,
  }) async {
    MessageModel messageModel = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dataTime: dataTime,
      text: text,
      pic: chatImage?.path ?? '',
    );
    // sender chat
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      // saveNotifications(
      //   NotificationModel(
      //     senderName: userModel!.userName,
      //     senderImage: userModel!.image,
      //     dateTime: messageModel.dataTime,
      //   ),
      // );
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      SocialSendMessageErrorStates();
    });

    await FirebaseFirestore.instance
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

    // createNotification(
    //   notificationTitle: userModel!.userName!,
    //   notificationBody: messageModel.text!,
    //   notificationPicture: messageModel.pic,
    // );
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) async {
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

  String fcmToken = '';

  void saveFcmToken({required String token}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .set(
      {
        'fcmToken': token,
      },
      SetOptions(merge: true),
    ).then((value) {
      fcmToken = token;
      debugPrint('FcmToken saved successfully : $fcmToken');
      emit(SocialSaveFcmTokenSuccessStates());
    }).catchError((error) {
      debugPrint('error in saving token ${error.toString()}');
    });
  }

  // get fcm token
  void getFcmToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      debugPrint('FCM Token : $value');

      saveFcmToken(token: value!);

      emit(SocialGetFcmTokenSuccessStates());
    }).catchError((error) {
      emit(SocialGetFcmTokenErrorStates(error));
    });
  }

  //////////////////////////////
  List notificationList = [];

// save Notifications.......
  void saveNotifications(NotificationModel notification) {
    FirebaseFirestore.instance
        .collection('notifications')
        .add(notification.toMap());
  }

  //get notifications.........
  Future<void> getNotifications() async {
    notificationList.clear();
    await FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        notificationList.add(NotificationModel.fromJson(element.data()));
      });
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
      debugPrint(postId);
      // remove element in posts list
      posts.removeWhere((element) => element.postId == postId);
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
    const HomeScreen(),
    const ChatsScreen(),
    PostScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];

  List<Widget> tabs = [
    const Tab(
      icon: Icon(IconBroken.Home),
    ),
    const Tab(
      icon: Icon(IconBroken.Location),
    ),
    const Tab(
      icon: Icon(IconBroken.Chat),
    ),
    const Tab(
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

  File? chatImage;

  Future<void> pickPostImage() async {
    if (chatImage != null) {
      chatImage = null;
    }
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      chatImage = File(value!.path);
      // uploadProfilePhoto();
      emit(PickChatImageSuccessState());
    }).catchError((error) {
      emit(PickChatImageErrorState(error));
    });
  }

  // voice message
  bool isRecord = false;
  Record audioRecorder = Record();
  String? voicePath;
  File? soundFile;

  Future voiceStartRecord({
    String? postId,
  }) async {
    if (permissionsGranted == true) {
      Directory appFolder = Directory(Paths.recording);

      bool appFolderExists = await appFolder.exists();
      if (!appFolderExists) {
        final created = await appFolder.create(recursive: true);
        debugPrint(created.path);
      }

      if (postId != null) {
        voicePath = Paths.recording +
            '/' +
            postId.toString() +
            '_' +
            DateTime.now().millisecondsSinceEpoch.toString() +
            '.wav';
        debugPrint(voicePath);
      } else {
        postId = 'postVoice';
        voicePath = Paths.recording +
            '/' +
            postId.toString() +
            '_' +
            DateTime.now().millisecondsSinceEpoch.toString() +
            '.wav';

        debugPrint(voicePath);
      }

      isRecord = true;

      await audioRecorder.start(
        path: voicePath,
      );
      emit(SocialVoiceRecordOn());
    }
  }

  Future voiceStopRecord({String? postId}) async {
    String? path = await audioRecorder.stop();
    emit(SocialVoiceRecordOff());
    debugPrint('Output path $path');

    uploadVoiceRecord(
      filePath: path,
      postId: postId,
    );
  }

  void uploadVoiceRecord({
    String? filePath,
    String? postId,
    String? textComment,
  }) async {
    emit(SocialUploadVoiceRecordLoadingStates());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('voiceRecord/${Uri.file(filePath!).pathSegments.last}')
        .putFile(File(filePath))
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        voicePath = value;
        commentPost(postId: postId!, voiceComment: value);

        emit(SocialUploadVoiceRecordSuccessStates());
      }).catchError((error) {
        emit(SocialUploadVoiceRecordErrorStates(error));
      });
    });
  }

  Future voiceResumeRecord() async {
    emit(SocialAudioVoiceLoadingStates());
    await audioRecorder.resume();
    emit(SocialVoiceRecordOn());
  }

  void voiceRecorderWithBottomSheet() {
    emit(SocialVoiceRecorderWithBottomSheetWithBottomSheetLoadingStates());
  }

  void checkRecording({String? postId}) {
    if (isRecord == true) {
      voiceStopRecord(postId: postId);
      isRecord = !isRecord;
      emit(SocialCheckRecordingStates());
    } else if (isRecord == false) {
      voiceStartRecord(postId: postId);
      isRecord = !isRecord;
      showToast(message: 'Recording');
      emit(SocialCheckRecordingStates());
    }
  }

  AudioPlayer audioPlayer = AudioPlayer();

  void audioPlay(String url) async {
    emit(SocialAudioVoiceLoadingStates());
    await audioPlayer.play(url);
    emit(SocialAudioPlayStates());
  }

  void audioPause(String url) async {
    emit(SocialAudioVoiceLoadingStates());

    await audioPlayer.pause();

    emit(SocialAudioPauseStates());
  }

  void audioResume() async {
    emit(SocialAudioVoiceLoadingStates());

    await audioPlayer.resume();

    emit(SocialAudioResumeStates());
  }

  void audioStop() async {
    emit(SocialAudioVoiceLoadingStates());

    await audioPlayer.stop();

    emit(SocialAudioStopStates());
  }

  Duration voiceChange() {
    Duration? ev;
    audioPlayer.onAudioPositionChanged.listen((event) {
      ev = event;
      debugPrint('onAudioPositionChanged Duration: $event');
      emit(SocialOnAudioPositionChangedStates());
    });
    return ev!;
  }

  Future<int> getCurrentPositionVoice() {
    return audioPlayer.getCurrentPosition();
  }

  AudioCache audioCache = AudioCache();

  void audioCachePlay(String fileName) async {
    await audioCache.play(fileName);

    emit(SocialAudioPlayStates());
  }

  // Future<void> loadInAudioCache({String? postId}) async {
  //   await FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('comments')
  //       .doc(userModel!.uId)
  //       .get()
  //       .then((value) {
  //     debugPrint('77777777777777777777777777777777');
  //     // debugPrint(value.data());
  //     CommentModel commentModel = CommentModel.fromJson(value.data()!);
  //     // voicePath = commentModel.voice.toString().split('?')[0];
  //     // audioCache.load(voicePath!);
  //   });
  // }

  void clearCacheVoice(String fileName) async {
    await audioCache.clearAll();
  }
}
