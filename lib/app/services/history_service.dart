import 'dart:convert';

import 'package:http/http.dart' as http;


import 'package:app_movil_pta/app/models/history_model/history_response.dart';

class HistoryService{

  Future<List<HistoryResponse>?> fetchData(String userID) async{

    String url = "http://192.168.18.39:8000/history/$userID";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      List<dynamic> decodedJson = jsonDecode(response.body);
      return decodedJson.map((item) => HistoryResponse.fromJson(item)).toList();

    }

    throw Exception('error al hacer solicitud');
  }

}