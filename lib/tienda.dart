import 'package:flutter/material.dart';
import 'menu.dart';
import 'producto.dart';
import 'pantallaConfirmar.dart';

class tienda extends StatefulWidget {
  const tienda({super.key});

  @override
  State<tienda> createState() => _tiendaState();
}

class _tiendaState extends State<tienda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Tienda", style: TextStyle(
          color: Color(0xFF040F51)
        ),),
      ),
      endDrawer: Menu(),
      body:
      Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Row(
                  children: [
                    producto(),
                    producto(),
                  ],
                ),
                Row(
                  children: [
                    producto(),
                    producto(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Color(0xFF7C8CB2),
            child: ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context){
                      return new pantallaConfirmar();
                    }));
              },
              child: Text("Confirmar compra", style: TextStyle(
                color: Color(0xFF040C52),
              ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7C8CB2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
