import 'dart:convert';
import 'package:app_aulagramma/Productos.dart';
import 'package:app_aulagramma/registerBD.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class confirmarCompra extends StatefulWidget {
  const confirmarCompra({super.key});

  @override
  State<confirmarCompra> createState() => _confirmarCompraState();
}

class _confirmarCompraState extends State<confirmarCompra> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String correo = "";
  String pass = "";

  void complete() {
    correo = correoController.text;
    pass = passwordController.text;
    login();
  }

  void page(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Productos(),
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
        page();
      } else {
        print('Error en la respuesta: ${datos["respuesta"]}');
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
        title: Text("confirmar compra", style: TextStyle(
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
                  Text("Datos de tarjeta", style: TextStyle(
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
                        hintText: "Numero de tarjeta",
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
                        hintText: "CVC",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.lock, size: 20),
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
                        hintText: "Fecha de caducidad",
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
                            "confirmar",
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
                            "Cancelar",
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

