import 'dart:convert';

import 'package:app_aulagramma/addProducto.dart';
import 'package:app_aulagramma/datos_producto.dart';
import 'package:app_aulagramma/modificarProducto.dart';
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

  mostrar_alerta(id, nombre){
    showDialog(
        context: context,
      builder: (BuildContext context){
          return AlertDialog(
            title: Text("Alerta!!!"),
            content: SingleChildScrollView(
              child: Text("Realmente quieres eliminar " + nombre + "?"),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    confirmar_Eliminar(id);
                  },
                  child: Text("Eliminar", style: TextStyle(color: Colors.red),)),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar" , style: TextStyle(color: Colors.blue),))
            ],
          );
      }
    );
  }

  Future<void> confirmar_Eliminar(id) async{
    print('la id : ' + id);
    var url = Uri.https('api.aulagrammae.com', 'apps/eliminar_producto.php');
    var response = await https.post(url, body: {
      'id' : id
    }).timeout(Duration(seconds: 90));
    print('Respuesta: ' + response.body);
    if(response.body == '1'){
      setState(() {
        loading = true;
        datos = [];
        tomar_datos().then((value){
          setState(() {
            datos.addAll(value);
            loading = false;
          });
          print(datos);
          Navigator.of(context).pop();
        });
      });
    }else{
      print(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    tomar_datos().then((value){
      setState(() {
        datos.addAll(value);
        loading = false;
      });
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
      body: loading == true ? Center(
        child: CircularProgressIndicator(color: Colors.blue,),
      ) : Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount: datos.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1)
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text(datos[index].nombre!, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),)),
                      Expanded(child: Text(datos[index].descripcion!, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),)),
                      Expanded(child: Text(datos[index].precio!, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),)),
                      Expanded(child: Text(datos[index].id!, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),)),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context){
                                return modificarProducto(
                                    datos[index].id!,
                                    datos[index].nombre!,
                                    datos[index].descripcion!,
                                    datos[index].precio!
                                );
                              }
                          )).then((value){
                            setState(() {
                              loading = true;
                              datos = [];
                              tomar_datos().then((value){
                                setState(() {
                                  datos.addAll(value);
                                  loading = false;
                                });
                              });
                              print(datos);
                            });
                          });
                        },
                        child: Icon(Icons.edit, color: Colors.green,),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          mostrar_alerta(datos[index].id!, datos[index].nombre!);
                        },
                        child: Icon(Icons.delete, color: Colors.red,),
                      ),
                    ],
                  ),
                );
              }
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context){
                return add_producto();
              }
              )).then((value) {
            setState(() {
              loading = true;
              datos = [];
              tomar_datos().then((value){
                setState(() {
                  datos.addAll(value);
                  loading = false;
                });
                print(datos);
              });
            });
          });
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
      ),
    );
  }
}
