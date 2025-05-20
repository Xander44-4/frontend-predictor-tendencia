

class LoginResponse {

  final String user;
  final String token;

  const LoginResponse({
    required this.user,
    required this.token
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json){

    return  LoginResponse( user: json["user_data"], token: json["token"]);
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