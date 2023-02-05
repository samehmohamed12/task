class UserModel {
 // String? userId;
  String? userName;
  String? email;
  String? password;

  UserModel({
  //  required this.userId,
    required this.userName,
    required this.email,
    required this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
  //  userId = json['user_id'];
    userName = json['user_name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
   //   'user_id': userId,
      'user_name': userName,
      'email': email,
      'password': password,
    };
  }
}
