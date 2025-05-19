import 'package:app_movil_pta/app/routes/app_routers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouters.loginScreen,
      routes: AppRouters.getRouters(),
    );
  }
}
