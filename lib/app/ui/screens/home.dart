import 'package:app_movil_pta/app/models/login_model.dart';
import 'package:app_movil_pta/app/services/login_services.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final modes =['modo 1','modo 2', 'modo 3'];
  String? value;

  LoginServices getUsers = LoginServices();
   LoginRequest? requestModel;

  @override
  void initState(){
    super.initState();
    requestModel =  LoginRequest();
    value = modes.first;
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item, style: const TextStyle(fontSize: 20)),
  );

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(title: const Text('home')),
      body:  Column(
        children: [
        const SizedBox(height: 18),

         Row(
           children: [
             Container(
               margin: const EdgeInsets.only(left: 20),
               child: const Text("Hello, {user}", style: TextStyle( fontSize: 26,
                   fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold
               ),
               ),
             ),
           ],
         ),
          const SizedBox(height: 50 ,),
          const Text('Predictor Tendencia Activos', style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 18,),
          const Text('MODO', style: TextStyle(fontSize: 20)),
          Center(
            child: DropdownButton<String>(
                value: value,
                items: modes.map(buildMenuItem).toList(),
                onChanged: (v) => setState(() => value = v)
            ),
          )
        ],
      ),

    );


  }
}
