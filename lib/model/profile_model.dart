class ProfileModel
{
  bool? status ;
  Data? data ;

  ProfileModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = Data.fromJson(json['data'] as Map<String, dynamic>);
  }
}

class Data
{
  int? id ;
  String? name ;
  String? email ;
  String? phone ;
  String? image ;
  String? token ;

  Data.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}