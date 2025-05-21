


import 'package:app_movil_pta/app/design_patterns/classes/roc.dart';
import 'package:app_movil_pta/app/design_patterns/classes/sma.dart';
import 'package:app_movil_pta/app/design_patterns/factory/iresponseMode.dart';

import '../classes/rl.dart';

class FactoryMode {
  static IResponse getMode(dynamic json) {
    if (json is List) {

      return Roc().getResponse(json);
    }
    if (json is Map<String, dynamic>) {
      final String type = json['type'];
      if (type == 'sma') {
        return Sma().getResponse(json);
      }
      if (type == 'rl') {
        return Rl().getResponse(json);
      }
    }
    throw Exception('Tipo no soportado o formato inválido');
  }
}

