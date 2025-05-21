

import 'package:app_movil_pta/app/design_patterns/factory/iresponseMode.dart';


class Roc implements IResponse {
  List<ValuesRoc>? listOfRoc;

  Roc({
     this.listOfRoc
  });



  @override
  IResponse getResponse(dynamic json) {
    if (json is! List) {
      throw Exception('Se esperaba una lista JSON, pero se recibió: ${json.runtimeType}');
    }

    List<ValuesRoc> lista = ValuesRoc.listFromJson(json);
    return Roc(listOfRoc: lista);

  }
  @override
  String toString() {
    return "${listOfRoc!.map((roc) => "\ndia:${roc.t}\nprecio:${roc.price}\nroc:${roc.roc}\n")}";
  }
}

class ValuesRoc {
  int t;
  double price;
  dynamic roc;

  ValuesRoc({
    required this.t,
    required this.price,
    this.roc,
  });

  factory ValuesRoc.fromJson(Map<String, dynamic> json) {
    return ValuesRoc(
      t: json['t'],
      price: json['price'],
      roc: json['roc'],
    );
  }

  static List<ValuesRoc> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((e) => ValuesRoc.fromJson(e)).toList();
  }
  @override
  String toString() {

    return 'ROC => t: $t  price: $price  roc: $roc';
  }
}
