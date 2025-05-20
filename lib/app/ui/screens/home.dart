import 'package:app_movil_pta/app/models/login_model.dart';
import 'package:app_movil_pta/app/services/login_services.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formlogin = GlobalKey<FormState>();

  Future<LoginResponse?>? _getUsers;
  LoginServices getUsers = LoginServices();
   LoginRequest? requestModel;
  @override
  void initState(){
    super.initState();
    requestModel =  LoginRequest();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('home')),
      body: Column(
        children: [
          Form(
            key: _formlogin,
            child:  Column(
            children: [
              TextFormField(
                controller: _emailController,
                validator: ( v){
                  if(v == null || v.isEmpty){
                    return 'ingrese un valor';
                  }
                  if( v.contains('[')){
                    return "no puede contener charateres especiales '['";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController ,
                validator: (v){
                  if(v == null || v.isEmpty){
                    return 'este campo no puede ir vacio';
                  }
                  if(v.length < 5){
                    return 'contraseña muy corta';
                  }
                  return null;

                },
              ),
              ElevatedButton(onPressed: () async{
                if(_formlogin.currentState!.validate())
                {
                  _formlogin.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('procesando'))
                  );
                  requestModel!.email = _emailController.text;
                  requestModel!.password = _passwordController.text;

                  final response = await getUsers.fetchData(requestModel!);

                  if (response != null) {

                    print('Token: ${response.token}');
                  } else {
                    print('Error al iniciar sesión');
                  }

                  _formlogin.currentState!.reset();
                }


              }, child: const Text('submit'))
            ],
          )),


          ElevatedButton(
            onPressed: () async {
              requestModel!.email = 'Pri@example.com';
              requestModel!.password = 'dagamer_panda'; // tu contraseña hardcodeada


            },
            child: const Text('Click'),
          ),


          FutureBuilder(future: _getUsers, builder:(context, shapshot){
              if(shapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }else if(shapshot.hasError){
                return Text("Error: ${shapshot.error}");
              }else if(shapshot.hasData){
                return  Text(" ${shapshot.data!.token}");
              }

              else{
                return const Text('otra cosa');
              }

          })
        ],
      ),


    );
  }
}
