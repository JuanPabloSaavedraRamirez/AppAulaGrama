import 'dart:convert';

import 'package:app_aulagramma/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class loginBD extends StatefulWidget {
  const loginBD({super.key});

  @override
  State<loginBD> createState() => _loginBDState();
}

class _loginBDState extends State<loginBD> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  String correo = "";
  String pass = "";

  void complete(){
    correo = correoController.text;
    pass = passwordController.text;
    login();
  }
  Future<void> login() async{
    var url = Uri.https('api.aulagrammae.com', 'apps/login.php');
    var response = await https.post(url, body:{
      'Correo': correo,
      'Password': pass,
    });
    print('Respuesta: ' + response.body);

    var datos = jsonDecode(response.body);
    if (datos['Respuesta'] == '1'){
      //dar acceso a mi plataforma
      //guardarSesion(); guardar sharedPreferences
    }
    else{
      print(datos["Respuesta"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("LoginBD", style: TextStyle(
          color:Color(0xFF040F51),
        ),),
      ),
      backgroundColor: Color(0xFF040F51),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              color: Color(0xFF2D366F),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(20)),
                  Text(
                    "Bienvenido",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD0DBF3),
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: TextField(
                      controller: correoController,
                      decoration: InputDecoration(
                        hintText: "Usuario",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.person, size: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.lock, size: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: complete,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(color: Color(0xFF040C52)),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF7C8CB2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "¿Perdiste tu contraseña?",
                    style: TextStyle(color: Colors.blue[50]),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Register();
                          },
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "¿No tienes cuenta? Regístrate",
                            style: TextStyle(color: Color(0xFF040C52)),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF7C8CB2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Volver",
                style: TextStyle(
                  color: Colors.blue[50],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }

