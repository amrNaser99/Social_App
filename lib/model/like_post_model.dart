class LikesModel {
  String? userName;
  String? uId;
  String? profileImage;
  String? postId;
  String? dateTime;

  LikesModel({
    this.userName,
    this.uId,
    this.profileImage,
    this.postId,
    this.dateTime,
  });

  LikesModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    uId = json['uId'];
    profileImage = json['profileImage'];
    postId = json['postId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'uId': uId,
      'profileImage': profileImage,
      'postId': postId,
      'dateTime': dateTime,
    };
  }
}
