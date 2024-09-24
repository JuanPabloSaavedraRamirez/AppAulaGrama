import 'package:app_aulagramma/login.dart';
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
  late String _username;
  late String _email;
  late String _age;

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _email = widget.email;
    _age = widget.age;
  }

  void _clearUserData() {
    setState(() {
      _username = '';
      _email = '';
      _age = '';
    });
  }

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
                      padding: EdgeInsets.only(left: 20, right: 100, top: 10, bottom: 10),
                      child: Text(_username.isEmpty ? 'Sin usuario' : _username),
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
                      child: Text(_email.isEmpty ? 'Sin correo' : _email),
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
                      padding: EdgeInsets.only(left: 20, right: 100, top: 10, bottom: 10),
                      child: Text(_age.isEmpty ? 'Sin edad' : _age),
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
                        "Volver",
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
                          return ModificarPerfil(currentEmail: _email, currentUsername: _username, currentAge: _age);
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
              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    _clearUserData();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => login(),
                      ),
                    );
                  },
                  child: Text(
                    "Cerrar sesion",
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
    );
  }
}
