class CommentModel {
  String? userName;
  String? uId;
  String? comment;
  String? profileImage;
  String? dateTime;

  CommentModel({
    this.userName,
    this.comment,
    this.uId,
    this.profileImage,
    this.dateTime,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    comment = json['comment'];
    uId = json['uId'];
    profileImage = json['profileImage'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'comment': comment,
      'uId': uId,
      'profileImage': profileImage,
      'dateTime': dateTime,
    };
  }
}
