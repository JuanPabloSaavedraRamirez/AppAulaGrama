import 'dart:convert';
import 'package:app_aulagramma/comprarProductos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class confirmarCompra extends StatefulWidget {
  const confirmarCompra({super.key});

  @override
  State<confirmarCompra> createState() => _confirmarCompraState();
}

class _confirmarCompraState extends State<confirmarCompra> {
  final TextEditingController numTarjetaController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  final TextEditingController fechaCaController = TextEditingController();

  String NumeroTarjeta = "";
  String CVC = "";
  String FechaCaducidad = "";

  void complete() {
    NumeroTarjeta = numTarjetaController.text;
    CVC = cvcController.text;
    FechaCaducidad = fechaCaController.text;
    tarjeta();
  }

  Future<void> tarjeta() async {
    var url = Uri.https('api.aulagrammae.com', 'apps/addTarjeta.php');
    var response = await https.post(url, body: {
      'NumeroTarjeta': NumeroTarjeta,
      'CVC': CVC,
      'FechaCaducidad': FechaCaducidad,
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    try {
      var datos = jsonDecode(response.body);
      if (datos['respuesta'] == "1") {
        print("Tarjeta registrada exitosamente.");
      } else {
        print('Error: ${datos["mensaje"]}');
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
        title: Text("Confirmar compra", style: TextStyle(
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
                      controller: numTarjetaController,
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
                      controller: cvcController,
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
                      controller: fechaCaController,
                      decoration: InputDecoration(
                        hintText: "Fecha de caducidad (MM/DD)",
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
                          Text("Confirmar compra", style: TextStyle(
                              color: Color(0xFF040C52)),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComprarProductos(),
                          ),
                        );
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

