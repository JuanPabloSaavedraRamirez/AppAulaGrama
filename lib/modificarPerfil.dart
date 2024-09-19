import 'package:app_aulagramma/login.dart';
import 'package:app_aulagramma/perfil.dart';
import 'package:flutter/material.dart';

class modificarPerfil extends StatefulWidget {
  const modificarPerfil({super.key});

  @override
  State<modificarPerfil> createState() => _modificarPerfilState();
}

class _modificarPerfilState extends State<modificarPerfil> {

  //aqui van las funciones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Modificar perfil"),
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
                      hintText: " Nuevo Correo",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Nuevo Confirmar correo",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Nueva Contraseña",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.password, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Confirmar Nueva contraseña",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.password, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Nuevo Nombre de usuario",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Nueva Edad",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.numbers, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                        return perfil();
                      }
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Confirmar", style: TextStyle(
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
