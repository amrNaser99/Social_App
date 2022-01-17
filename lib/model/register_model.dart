// class RegisterModel {
//   late bool status;
//   late String message;
//   UserData? data;
//
//   RegisterModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = UserData.fromJson(json['data']);
//   }
// }
//
// class UserData {
//   late int id;
//   late String name;
//   late String email;
//   late String phone;
//   late String image;
//   late String token;
//
//   UserData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     token = json['token'];
//   }
// }
//
//




class RegisterModel {
  RegisterModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final Data data;

  RegisterModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.name,
    required this.phone,
    required this.email,
    required this.id,
    required this.image,
    required this.token,
  });
  late final String name;
  late final String phone;
  late final String email;
  late final int id;
  late final String image;
  late final String token;

  Data.fromJson(Map<String, dynamic> json){
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['id'] = id;
    _data['image'] = image;
    _data['token'] = token;
    return _data;
  }
}