import 'package:app_movil_pta/app/models/history_model/history_response.dart';
import 'package:app_movil_pta/app/services/history_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<HistoryResponse>?>? _response;
  final HistoryService _repository = HistoryService();
  SharedPreferencesAsync userData = SharedPreferencesAsync();
  String? useId;
  Future<void> loadUserId() async{
    String? storedUserId = await userData.getString('id');
    setState(() {
      this.useId = storedUserId;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserId();
    setState(() {
      _response = _repository.fetchData('682b3760f6354f552c122dff');
    });
  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Text('HISTORIAL' , style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: FutureBuilder<List<HistoryResponse>?>(
                  future: _response, builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child:  CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Aún no tiene historial'));
                }

                if(snapshot.hasError){
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if(snapshot.hasData){
                  final List<HistoryResponse> historyList = snapshot.data!;
                  int historyCount = historyList.length;

                  return ListView.builder(

                      itemCount: historyCount,
                      itemBuilder: (context, index){
                      int numberModeType = historyList[index].values!.modeType!.toInt();
                      return Column(

                        children: [
                          const SizedBox(height: 10,),
                          Container(
                            alignment: Alignment.center,


                            margin: const EdgeInsets.only(left: 20, right: 20),
                            decoration:
                             BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(11)
                            ),
                            child: Column(
                              children: [
                                Text( predictionString(numberModeType), textAlign: TextAlign.right,),

                                Text(
                                  historyList[index].values!.inputs!
                                      .map((input) => '\nfecha: ${input.date}\nvalor: ${input.value}')
                                      .join('\n'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${historyList[index].factory}'),
                                )



                              ],
                            ),
                          )
                        ],
                      );
                  });
                }


                return const Center(child:  Text('Otro error', style: TextStyle(),));
              }),
            )
          ],
        ),
      )

    );
  }
}


String predictionString(int modeType){
  if(modeType == 1){
    return 'Media Móvil Simple (SMA)Crossover';
  }
  if(modeType == 2){
    return 'Regresión Lineal';
  }if(modeType == 3){
    return 'Momentum (ROC)';
  }
  return '{tipo de modo:}';
}