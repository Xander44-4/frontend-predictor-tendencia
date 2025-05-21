


import 'package:app_movil_pta/app/design_patterns/factory/iresponseMode.dart';
import 'package:app_movil_pta/app/design_patterns/factory/modeFactory.dart';

class ModeResponse {
   IResponse? factory;



  IResponse transformJson(dynamic json){
    factory = FactoryMode.getMode(json);
    return  factory!;
  }
  @override
  String toString() {
    return factory.toString();
  }
}