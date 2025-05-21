

class LoginResponse {

  final UserData? user;
  final String? token;
  final String? errorMessage;

  const LoginResponse({
    this.user,
    this.token,
    this.errorMessage
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json){

    if(json.containsKey('detail')){
      return LoginResponse(errorMessage: json['detail']);
    }

    return  LoginResponse( user: UserData.fromJson(json["user_data"]), token: json["token"]);

  }
}

class LoginRequest {
  String? email;
   String? password;

   LoginRequest({
    this.email,
     this.password
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> fieldPost = {
      'email' : email?.trim(),
      'password_hashed': password?.trim()
    };

    return fieldPost;
  }
}


class UserData {
  final String id;
  final String username;
  final int age;
  final String email;
  final String password;

  UserData({
    required this.id,
    required this.username,
    required this.age,
    required this.email,
    required this.password
 });

  factory UserData.fromJson(Map<String, dynamic> json){

    return UserData(id: json["_id"], username: json["username"],
        age: json["age"], email: json["email"], password: json["password_hashed"]);
  }
}