class UserModel {
  late String? userName ;
  late String? email ;
  late String? phone ;
  late String? uId ;
  late String? image ;
  late String? imgCover ;
  late String? bio ;
  late bool? isEmailVerified ;

  UserModel({
      this.userName,
      this.email,
      this.phone,
      this.uId,
      this.image,
      this.imgCover,
      this.bio,
      this.isEmailVerified });

  UserModel.fromJson(Map<String,dynamic> json)
  {
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    imgCover = json['imgCover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'userName':userName,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'imgCover':imgCover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }

}