import 'dart:convert';
import 'package:app_movil_pta/app/models/login_model.dart';
import 'package:http/http.dart' as http;

class LoginServices {

  Future<LoginResponse?> fetchData(LoginRequest request ) async {
    String url = 'http://10.0.2.2:8000/login';
    final response =
        await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),

    );

    print('Código de respuesta: ${response.statusCode}');
    print('Cuerpo: ${response.body}');

    if(response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);
      LoginResponse goodResponse =LoginResponse.fromJson(decodedJson);
      return goodResponse;
    }
    if(response.statusCode == 401){
      return const LoginResponse(errorMessage: "Credenciales inválidas");
    }
    return null;




  }

}