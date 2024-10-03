import 'package:app_aulagramma/login.dart';
import 'package:app_aulagramma/register.dart';
import 'package:flutter/material.dart'; //Este es para android
import 'tienda.dart';

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
      home: Register(),
    );
  }
}
