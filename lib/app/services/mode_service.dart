import 'dart:convert';

import 'package:app_movil_pta/app/models/mode_model/mode_response.dart';
import 'package:http/http.dart' as http;

import 'package:app_movil_pta/app/models/mode_model/mode_request_model.dart';

class ModeService{

  Future<ModeResponse> fetchData(ModeRequest request,String url) async{

    //const String url = '192.168.18.39:8000/mode';
    
    final response =
        await http.post( Uri.parse(url),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(request.toJson())
        );

    if(response.statusCode == 200){
      var decodedJson = jsonDecode(response.body);
      ModeResponse modeResponse = ModeResponse();
      modeResponse.transformJson(decodedJson);

      return modeResponse;

    }


    throw Future.error('erroraso');

  }


}