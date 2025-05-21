import 'dart:convert';



class ModeRequest{
  late  int? modeType;
  late  String? userId;
  List<Inputs>? inputs;

 ModeRequest({
    this.modeType,
     this.userId,
     this.inputs

 });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> fieldsToPost = {
      'mode_type' : modeType,
      'userId' : userId,
      'inputs' : inputs
    };
        return fieldsToPost;
  }
  @override
  String toString() {
    return jsonEncode(toJson());
  }

}

class Inputs{
  final String date;
  final double value;


  Inputs({
    required this.date,
    required this.value
});

  Map<String, dynamic> toJson() {
    return {
      'datetime': date,
      'value': value,
    };
  }


}