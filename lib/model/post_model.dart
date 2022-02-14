class PostModel {
  late String? userName;
  late String? uId;
  late String? image;
  late String? dateTime;
  late String? text;
  late String? postImage;
  late String? postId;



  PostModel({
    this.userName,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.postId,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
