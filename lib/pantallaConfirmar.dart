import 'package:flutter/material.dart';

class pantallaConfirmar extends StatefulWidget {
  const pantallaConfirmar({super.key});

  @override
  State<pantallaConfirmar> createState() => _pantallaConfirmarState();
}

class _pantallaConfirmarState extends State<pantallaConfirmar> {

  void mostrarAlerta(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("¡Gracias por comprar!"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Gracias por comprar el curso")
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Aceptar"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Confirmar compra", style: TextStyle(
          color: Color(0xFF040F51)
        ),),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: (){
                  mostrarAlerta();
                },
                child: Text("Confirmar compra", style: TextStyle(
                  color: Colors.white,
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.all(10)
                ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Cancelar compra", style: TextStyle(
                color: Colors.white,
              ),),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(10)
              ),
            ),
          )
        ],
      ),
      backgroundColor: Color(0xFF040C52),
    );
  }
}
