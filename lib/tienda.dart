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
        title: Text("Tienda"),
      ),
      endDrawer: menu(), //crear un drawer llamando al manu
      body:
      Column(
        children: [
          Expanded(
            child: ListView( //Para hacer scroll
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
            color: Colors.lightBlue,
            child: ElevatedButton(
              onPressed: (){

                //Opcion 1 carga una nueva pantalla
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context){
                      return new pantallaConfirmar();
                    }));

                //Opcion 2 esta desaparece la anterior y carga una nueva
                /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder:(BuildContext context) {
                      return new pantallaConfirmar();
                    }), (Route) => false);*/

              },
              child: Text("Confirmar compra", style: TextStyle(
                color: Colors.white,
              ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
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
