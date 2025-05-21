import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_elevatedbtn.dart';
import 'package:app_movil_pta/app/models/login_model.dart';
import 'package:app_movil_pta/app/services/login_services.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      extendBodyBehindAppBar: false,

      body:  _LoginBody()
    );
  }
}

//Body

class _LoginBody extends StatefulWidget{
 const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {

  final SharedPreferencesAsync asyncUser = SharedPreferencesAsync();


  //controladores de input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //llave formulario
  final _formKey = GlobalKey<FormState>();

  //ahora lo duro el fetch

  final _fetchLogin = LoginServices();
  final _requestModel = LoginRequest();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.black87,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Container(
          color: Colors.black87,
          width: double.infinity,
          child:  Padding(
            padding:const EdgeInsets.only(top: 15),
            child: Stack(
              children: [
                Padding(
                  padding:  const EdgeInsets.only(top: 30 , left: 20),
                  child: Column(
                    children: [
                       const Text(
                        'Hello!',
                        style: TextStyle(fontSize: 50, color: Colors.white,
                            fontStyle:FontStyle.italic, fontWeight: FontWeight.bold),
                      ),
                        const Text('welcome to my app', style: TextStyle(color: Colors.white, fontSize: 15)),
                       Form(
                           key: _formKey,
                         child: Column(
                         children: [
                           InputX(placeHolderTxt: 'Gmail', customIcon: Icons.email, isPassword: false,
                             controller: _emailController,
                             validator: (v){
                               if(v == null || v.isEmpty){
                                 return 'ingrese un valor';
                               }
                               if( v.contains('[')){
                                 return "no puede contener charateres especiales '['";
                               }
                               return null;
                             },

                           ),
                           InputX(placeHolderTxt: 'Password', customIcon: Icons.abc, isPassword: true ,
                             controller: _passwordController,
                             validator: (v){
                               if(v == null || v.isEmpty){
                                 return 'ingrese un valor';
                               }
                               if( v.contains('[')){
                                 return "no puede contener charateres especiales '['";
                               }
                               return null;
                             },
                           ),
                           SizedBox(
                             width: 200,
                             child: ElevatedButton(onPressed: () async{
                               if(_formKey.currentState!.validate())
                               {
                                 _formKey.currentState!.save();

                                  _requestModel.email = _emailController.text;
                                  _requestModel.password = _passwordController.text;

                                  final responseFetch = await _fetchLogin.fetchData(_requestModel);

                                  if( responseFetch != null ){
                                    if(responseFetch.errorMessage != null){
                                    mostrarAlerta(  context, responseFetch.errorMessage.toString());
                                    }
                                    if(responseFetch.errorMessage == null){
                                      print(responseFetch.user?.age);
                                      Navigator.pushNamed(context, '/home');
                                      await asyncUser.setString('username', responseFetch.user!.username);
                                      await asyncUser.setString('id', responseFetch.user!.id);
                                    }

                                  }

                                  if(responseFetch == null){
                                    print('error Lidel verifique que hizo mal');
                                  }

                                  
                                 _formKey.currentState!.reset();
                               }
                              //
                             }, child: const Text('Login')),
                           )

                         ],
                       ))
                      ,
                    ],

                  ),

                ),
                DraggableScrollableSheet(
                    initialChildSize: 0.3,
                    minChildSize: 0.2,
                    maxChildSize: 0.4,
                    builder: (context,controller){

                  return  Container(

                    decoration: const BoxDecoration(color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      )
                    ),


                      child: SingleChildScrollView(
                        controller: controller,
                        child:  Column(
                          children: [
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                    margin: const EdgeInsets.only(left: 5, top: 10),
                                    child: FloatingActionButton(
                                        heroTag: null,
                                        onPressed: (){}, foregroundColor: Colors.black,
                                        backgroundColor: Colors.grey,child:
                                        const Icon(Icons.arrow_back))
                                ),
                                const Text('Sign In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Container(
                                    margin: const EdgeInsets.only(left: 5, top: 10),
                                    child: FloatingActionButton(
                                        heroTag: null,
                                        onPressed: (){}, foregroundColor: Colors.black,
                                        backgroundColor: Colors.grey,child:
                                        const Icon(Icons.close))
                                )
                              ],

                            ),
                            const SizedBox(height: 30,),
                            Container(
                              margin: const EdgeInsets.only(top: 20,left: 20,right:20, bottom:9 ),
                                child: const ElevatedBtnX(widthContainer: EdgeInsets.only(),
                                    iconBtn: FontAwesomeIcons.google,
                                    textBtn: 'Continue with Google')
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 20,left: 20,right:20 ),
                                child: const ElevatedBtnX(widthContainer: EdgeInsets.only(),
                                    iconBtn: FontAwesomeIcons.facebook,
                                    textBtn: 'Continue with Facebook')
                            )
                          ],
                        ),
                      )
                  );

                })
              ],
            ),
          ),
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
        title: const Text("Error"),
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





