class LikesModel {
  String? userName;
  String? uId;
  String? profileImage;
  String? dateTime;

  LikesModel({
    this.userName,
    this.uId,
    this.profileImage,
    this.dateTime,
  });

  LikesModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    uId = json['uId'];
    profileImage = json['profileImage'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'uId': uId,
      'profileImage': profileImage,
      'dateTime': dateTime,
    };
  }
}
