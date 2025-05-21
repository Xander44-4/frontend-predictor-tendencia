
import 'package:app_movil_pta/app/ui/screens/home_screens/history_screen.dart';
import 'package:app_movil_pta/app/ui/screens/home_screens/mainpage_screen.dart';
import 'package:app_movil_pta/app/ui/screens/home_screens/modes_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? indexOfBar = 1;
  final itemsBottomBar = <Widget>[
    const Icon(Icons.access_alarm),
    const Icon(Icons.home),
    const Icon(Icons.museum)

  ];
  final screens = <Widget>[
    const HistoryScreen(),
    const MainScreen(),
    const ModesScreen()
  ];

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: screens[indexOfBar!])

     ,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white)
        ),
        child: CurvedNavigationBar(
          color: Colors.black,
          buttonBackgroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
            index: 1,
            items: itemsBottomBar,
            onTap: (i) => setState(() => indexOfBar = i)
        ),
      ),
    );
  }
}
