import 'package:app_aulagramma/addProducto.dart';
import 'package:flutter/material.dart';

class Productos extends StatefulWidget {
  const Productos({super.key});

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
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
