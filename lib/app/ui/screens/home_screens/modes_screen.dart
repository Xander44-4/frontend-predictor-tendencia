
import 'package:app_movil_pta/app/design_patterns/classes/rl.dart';
import 'package:app_movil_pta/app/design_patterns/classes/roc.dart';
import 'package:app_movil_pta/app/design_patterns/classes/sma.dart';
import 'package:app_movil_pta/app/models/mode_model/mode_request_model.dart';
import 'package:app_movil_pta/app/services/mode_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModesScreen extends StatefulWidget {
  const ModesScreen({super.key});

  @override
  State<ModesScreen> createState() => _ModesScreenState();
}

class _ModesScreenState extends State<ModesScreen> {
  var modes =['Media Móvil Simple (SMA)Crossover','Regresion Lineal', 'Momentum (ROC)'];

  String? value;
  int valuesToPredict= 6;
  final  SharedPreferencesAsync asyncUser = SharedPreferencesAsync();
  String? userId;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputValuesToPredict = TextEditingController();

   List<TextEditingController> datesPicker = [];
   List<TextEditingController> valuesControllers = [];

   //fetch
  final ModeRequest _bodyToSend = ModeRequest(modeType: 1);
  final ModeService _postNewMode = ModeService();

  //localstorage
  Future<void> loadUserData() async{
    final String? storedUserId = await asyncUser.getString('id');
    setState(() {
      userId = storedUserId;
    });
  }

  List<String> datesValues = [];
  List<double> userValues = [];


  @override
  void initState(){
    super.initState();
    value = modes.first;
    loadUserData();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item, style: const TextStyle(fontSize: 15)),
  );

  void updateControllers(int newCount) {

    while (datesPicker.length < newCount) {
      datesPicker.add(TextEditingController());

    }
    while (valuesControllers.length < newCount) {
      valuesControllers.add(TextEditingController());
    }


    while (datesPicker.length > newCount) {
      datesPicker.removeLast().dispose();
    }
    while (valuesControllers.length > newCount) {
      valuesControllers.removeLast().dispose();

    }
  }


  @override
  Widget build(BuildContext context) {
    updateControllers(valuesToPredict);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //btns
            Row(
              children: [
                ///btns
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(top: 20),
                  width: 100,
                  height: 38,
                  decoration:  const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: IconButton(onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor:  WidgetStateProperty.all(Colors.green),
                     ),
                    icon: const Icon(FontAwesomeIcons.solidFileExcel) ,color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(top: 20),
                  width: 100,
                  height: 38,
                  decoration:  const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: IconButton(onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor:  WidgetStateProperty.all(Colors.grey),
                    ),
                    icon: const Icon(FontAwesomeIcons.fileCsv) ,color: Colors.white,
                  ),
                ),
              ],
            ),
            //dropdown
            Center(
              child: DropdownButton<String>(
                value: value ?? modes.first,
                items: modes.map(buildMenuItem).toList(),
                onChanged: (v) => setState(() {
                  value = v!;
                  if (value == 'Media Móvil Simple (SMA)Crossover') {
                    _bodyToSend.modeType = 1;
                  } else if (value == 'Regresion Lineal') {
                    _bodyToSend.modeType = 2;
                  } else if (value == 'Momentum (ROC)') {
                    _bodyToSend.modeType = 3;
                  } else {
                    _bodyToSend.modeType = 1;
                  }
                }),
              ),
            ),
            //form
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Form(
                key: _formKey,
                child:   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _inputValuesToPredict,
                      //investigar
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onFieldSubmitted: (value){
                        int numero = int.parse(value);
                        if(numero < 5){
                          mostrarAlerta(context, 'menor de 6 valores de activos no se puede realizar el calculo adecuadamente');
                        }
                        if(numero >= 5){ setState(() {
                          valuesToPredict = numero;
                        });}
                        },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Only 6+ values',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),)


            ),
            //request to fetch
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder  (
                      itemCount: valuesToPredict,
                      itemBuilder: (context, index) {

                        return
                          Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: datesPicker[index],
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(11.5)
                                        ),
                                        focusedBorder:  OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(11.5),
                                          borderSide: const BorderSide(color: Colors.blue)
                                        ),
                                        hintText: "Fecha ${index + 1}",
                                        prefixIcon:const Icon(FontAwesomeIcons.calendar)
                                      ),
                                      onTap: () async{
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        DateTime? datetime = await showDatePicker(initialDate: DateTime.now(),context: context, firstDate: DateTime(2000), lastDate: DateTime(2026));

                                          if(datetime != null){
                                            String formattedDate = DateFormat('yyyy-MM-dd').format(datetime);

                                            setState(() {
                                              datesPicker[index].text = formattedDate;
                                            });
                                          }
                                        },
                                    ),
                                  ),

                                )),
                            Expanded(
                                child: SizedBox(

                                  child: Padding (
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: valuesControllers[index],
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(11.5)
                                          ),
                                          focusedBorder:  OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(11.5),
                                              borderSide: const BorderSide(color: Colors.blue)
                                          ),
                                          hintText: "valor ${index + 1}",
                                      ),
                                    ),
                                  ),

                                )),
                          ],
                          );
                      },

                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ElevatedButton(onPressed: () async {

                      _bodyToSend.userId = userId;
                      _bodyToSend.inputs = [];
                      for(int i = 0; i < valuesToPredict; i++){
                        _bodyToSend.inputs!.add(Inputs(
                            date: datesPicker[i].text,
                            value: double.parse(valuesControllers[i].text)
                        ));
                      }

                      print(_bodyToSend.toString());

                      if(_bodyToSend.modeType == 1){
                        var response = await _postNewMode.fetchData(_bodyToSend, 'http://192.168.18.39:8000/mode');
                        if (!context.mounted) return;

                        if(response.factory is Sma){
                          final sma = response.factory as Sma;
                         QuickAlert.show(
                             context: context,
                             type: QuickAlertType.success,
                             text: 'SMA Creado Correctamente',
                            widget: Column(
                              children: [
                                const SizedBox(height: 20,) ,
                                Text('High Sma: ${sma.highSma}'),
                                Text('Low Sma: ${sma.lowSma}'),
                                Text('Mensaje'
                                    ': ${sma.msg}'),
                              ],
                            )
                         );

                        }


                      }
                      if(_bodyToSend.modeType == 2){
                        var response = await _postNewMode.fetchData(_bodyToSend, 'http://192.168.18.39:8000/mode/two');

                        if (!context.mounted) return;
                        if(response.factory is Rl){
                          final rl = response.factory as Rl;
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'RL Creado Correctamente',
                              widget: Column(
                                children: [
                                  const SizedBox(height: 20,) ,
                                  Text('futuro valor: ${rl.futureValue}'),
                                  Text('mensaje: ${rl.msg}'),

                                ],
                              )
                          );

                        }

                      }

                      if(_bodyToSend.modeType == 3){
                        var response = await _postNewMode.fetchData(_bodyToSend, 'http://192.168.18.39:8000/mode/three');
                        if (!context.mounted) return;
                        if(response.factory is Roc){
                          final roc = response.factory as Roc;
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'ROC Creado Correctamente',
                              widget: SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  itemCount: roc.listOfRoc!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text('${roc.listOfRoc![index]}'),
                                    );
                                  },
                                ),
                              )
                          );

                        }
                      }
                    },

                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white
                    ), child: const Text('Ver Prediccion')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Error de cantidad de valores"),
        content: Text(mensaje),
        actions: [
          TextButton(
            child: const Text("Cerrar"),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
          ),
        ],
      );
    },
  );
}