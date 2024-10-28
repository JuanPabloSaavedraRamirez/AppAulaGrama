import 'dart:convert';

import 'package:app_aulagramma/addProducto.dart';
import 'package:app_aulagramma/datos_producto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class Productos extends StatefulWidget {
  const Productos({super.key});

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {

  List<Datos_Producto> datos = [];
  bool loading = true;

  Future<List<Datos_Producto>> tomar_datos() async {
    var url = Uri.https('api.aulagrammae.com', 'apps/ver_productos.php');
    var response = await https.post(url).timeout(Duration(seconds: 90));
    print(response.body);
    var datos = jsonDecode(response.body);
    List<Datos_Producto> registros = [];

    for(datos in datos){
      registros.add(Datos_Producto.fromJson(datos));
    }

    return registros;
  }
  @override
  void initState() {
    super.initState();
    tomar_datos().then((value){
      datos.addAll(value);
      loading = false;
      print(datos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de productos", style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.blue,
      ),
      body: ListView(

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context){
                return add_producto();
              }
              ));
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
      ),
    );
  }
}
