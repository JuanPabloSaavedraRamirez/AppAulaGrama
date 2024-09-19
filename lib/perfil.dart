import 'package:flutter/material.dart';
import 'package:app_aulagramma/tienda.dart';
import 'package:app_aulagramma/modificarPerfil.dart';

class Perfil extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  const Perfil({
    super.key,
    required this.username,
    required this.email,
    required this.age,
  });

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
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
                      child: Text(
                        "User:",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      padding: EdgeInsets.only(left: 20, right: 170, top: 10, bottom: 10),
                      child: Text(widget.username),
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
                      child: Text(
                        "Correo:",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      padding: EdgeInsets.only(left: 20, right: 80, top: 10, bottom: 10),
                      child: Text(widget.email),
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
                      child: Text(
                        "Edad:",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      padding: EdgeInsets.only(left: 20, right: 170, top: 10, bottom: 10),
                      child: Text(widget.age),
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                          return tienda();
                        }));
                      },
                      child: Text(
                        "Cerrar",
                        style: TextStyle(
                          color: Colors.blue[50],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                          return ModificarPerfil(currentEmail: "", currentUsername: "", currentAge: "");
                        }));
                      },
                      child: Text(
                        "Modificar",
                        style: TextStyle(
                          color: Colors.blue[50],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
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
