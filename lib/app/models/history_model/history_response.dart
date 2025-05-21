

import 'package:app_movil_pta/app/design_patterns/factory/iresponseMode.dart';
import 'package:app_movil_pta/app/design_patterns/factory/modeFactory.dart';

class HistoryResponse {
  String? id;
  ValuesResponse? values;
  IResponse? factory;

  HistoryResponse({
    this.id,
    this.values,
    this.factory,
  });

  factory HistoryResponse.fromJson(dynamic json) {
    return HistoryResponse(
      id: json['id'],
      values: ValuesResponse.fromJson(json),
      factory: FactoryMode.getMode(json['answer_mode']),
    );
  }
@override
  String toString() {

    return factory.toString();
  }
}

class ValuesResponse {
  int? modeType;
  String? userId;
  List<ValuesInputs>? inputs;

  ValuesResponse({
    this.modeType,
    this.userId,
    this.inputs,
  });

  factory ValuesResponse.fromJson(dynamic json) {
    return ValuesResponse(
      modeType: json['mode_type'],
      userId: json['user_id'],
      inputs: (json['inputs'] as List<dynamic>?)
          ?.map((item) => ValuesInputs.fromJson(item))
          .toList(),
    );
  }

}

class ValuesInputs{
  double? value;
  String? date;

  ValuesInputs({
  this.value,
  this.date
 });

  factory ValuesInputs.fromJson(dynamic json){
    return ValuesInputs(value: json['value'],
        date: json['datetime']);
  }
  @override
  String toString() {

    return 'fecha: $date\nvalor: $value';
  }

}