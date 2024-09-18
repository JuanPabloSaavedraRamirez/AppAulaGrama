import 'package:app_aulagramma/login.dart';
import 'package:app_aulagramma/tienda.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {

  //aqui van las funciones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Registro"),
      ),
      backgroundColor: Colors.blue,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Correo",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Confirmar correo",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Contraseña",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.password, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Confirmar contraseña",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.password, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Nombre de usuario",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Edad",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.numbers, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                        return tienda();
                      }
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Completar", style: TextStyle(
                          color: Colors.blue[50],
                        ),),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                        return login();
                      }
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" ¿Ya tinenes cuenta? Inicia sesion", style: TextStyle(
                          color: Colors.blue[50],
                        ),),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
