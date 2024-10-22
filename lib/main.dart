import 'package:app_aulagramma/loginBD.dart';
import 'package:app_aulagramma/register.dart';
import 'package:app_aulagramma/registerBD.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(app());
}

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Prueba 1",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home: loginBD(),
    );
  }
}
