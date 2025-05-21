

import 'package:app_movil_pta/app/design_patterns/factory/iresponseMode.dart';


class Rl implements IResponse {
  double? futureValue;
  String? msg;

  Rl({
    this.futureValue,
    this.msg
  });

  factory Rl.fromJson(Map<String, dynamic> json){
    return  Rl(futureValue: json['future_value'], msg: json['msg']);
  }

  @override
  IResponse getResponse(dynamic json) {
    return Rl.fromJson(json);
  }
  @override
  String toString() {

    return "RL -> future_values: $futureValue, \n msg: $msg ";
  }
}