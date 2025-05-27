import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? username;
  String? id;
  final SharedPreferencesAsync asyncUser = SharedPreferencesAsync();


  Future<void> loadUsername() async{
    final String? storedUsername = await asyncUser.getString('username');
    final String? storedId= await asyncUser.getString('id');
    setState(() {
      username = storedUsername;
      id = storedId;
    });
  }

  @override
  void initState(){
    super.initState();
    loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child:  Text("Welcome, ${username ?? '{user}' } ", style: const TextStyle( fontSize: 26,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold
                ),
                ),

              ),
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(right: 10),
                child: FloatingActionButton(onPressed: (){
                  Navigator.pushNamed(context, '/login');
                }, heroTag: null,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.exit_to_app),
                ),
              )
            ],
          ),
          const SizedBox(height: 50 ,),
          const Text('DashBoard', style: TextStyle(fontSize: 20),),
          const SizedBox(height: 18,),
        ],
      )
    );
  }
}
