import 'dart:convert';
import 'package:app_aulagramma/comprarProductos.dart';
import 'package:app_aulagramma/registerBD.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // Verificar si el usuario ya ha iniciado sesión previamente
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('IDUser');

    if (userID != null) {
      // Si el IDUser ya está guardado, redirigir a la pantalla ComprarProductos
      page();
    }
  }

  void complete() {
    correo = correoController.text;
    pass = passwordController.text;
    login();
  }

  void page() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ComprarProductos(),
      ),
    );
  }

  Future<void> login() async {
    var url = Uri.https('api.aulagrammae.com', 'apps/login.php');
    var response = await https.post(url, body: {
      'Correo': correo,
      'Password': pass,
    });
    print('Respuesta completa: ${response.body}');

    try {
      var datos = jsonDecode(response.body);
      if (datos['respuesta'] == "1") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('IDUser', datos['IDUser']);
        page();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Usuario no encontrado"),
              content: Text("El correo ingresado no existe o la contraseña está mal escrita."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Aceptar"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error al parsear JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Login BD", style: TextStyle(
            color: Color(0xFF040F51),
          ),
        ),
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
                        hintText: "Correo",
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
                            return RegisterBD();
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
          ],
        ),
      ),
    );
  }
}
