class CommentModel {
  String? userName;
  String? uId;
  String? comment;
  String? profileImage;
  String? postId;
  String? dateTime;
  var voice;

  CommentModel({
    this.userName,
    this.uId,
    this.profileImage,
    this.postId,
    this.dateTime,
    this.comment,
    this.voice,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    comment = json['comment'];
    uId = json['uId'];
    profileImage = json['profileImage'];
    postId = json['postId'];
    dateTime = json['dateTime'];
    voice = json['voice'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'comment': comment,
      'uId': uId,
      'profileImage': profileImage,
      'postId': postId,
      'dateTime': dateTime,
      'voice': voice,
    };
  }
}
