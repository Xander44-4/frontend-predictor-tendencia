

import 'package:app_movil_pta/app/design_patterns/factory/iresponseMode.dart';


class Sma implements IResponse {
  double? highSma;
  double? lowSma;
  String? msg;

  Sma({
   this.highSma,
  this.lowSma ,
   this.msg
  });

  factory Sma.fromJson(Map<String, dynamic> json){
    return  Sma(highSma: json['high_sma'], lowSma: json['low_sma'], msg: json['msg']);
  }

  @override
  IResponse getResponse(dynamic json) {
    return Sma.fromJson(json);
  }

  @override
  String toString() {
    return 'SMA -> High: $highSma, Low: $lowSma, Msg: $msg';
  }
}