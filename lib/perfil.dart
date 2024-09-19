import 'package:app_aulagramma/modificarPerfil.dart';
import 'package:app_aulagramma/tienda.dart';
import 'package:flutter/material.dart';

class perfil extends StatefulWidget {
  const perfil({super.key});

  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Perfil"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 23, top: 10, bottom: 10),
                      color: Colors.blue,
                      child: Text("User:", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                    Container(
                      color: Colors.grey,
                      padding: EdgeInsets.only(left: 20, right: 170, top: 10, bottom: 10),
                      child: Text("data",),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                      color: Colors.blue,
                      child: Text("Correo:", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                    Container(
                      color: Colors.grey,
                      padding: EdgeInsets.only(left: 20, right: 170, top: 10, bottom: 10),
                      child: Text("data",),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 23, top: 10, bottom: 10),
                      color: Colors.blue,
                      child: Text("Edad:", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                    Container(
                      color: Colors.grey,
                      padding: EdgeInsets.only(left: 20, right: 170, top: 10, bottom: 10),
                      child: Text("data",),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                          Text("Cerrar", style: TextStyle(
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
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                          return modificarPerfil();
                        }
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Modificar", style: TextStyle(
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
            ],
          ),
        ],
      ),
    );
  }
}
