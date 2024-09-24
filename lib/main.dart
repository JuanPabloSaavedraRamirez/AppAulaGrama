import 'package:app_aulagramma/camara.dart';
import 'package:app_aulagramma/login.dart';
import 'package:flutter/material.dart'; //Este es para android
import 'tienda.dart';
import 'Home.dart'; //Siempre debemos importar los archivos que estaremos usando

void main(){ //Se crea la funcion main y dentro se llama al "runApp()"
  runApp(app());
}

class app extends StatelessWidget { //Esta es la clase dinamica
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //Material app es un navegador
      title: "Prueba 1",
      theme: ThemeData( //poner colores o temas especificos
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home: camara(),
    );
  }
}
