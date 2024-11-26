import 'dart:convert';
import 'package:app_aulagramma/confirmarCompra.dart';
import 'package:app_aulagramma/datos_producto.dart';
import 'package:app_aulagramma/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class ComprarProductos extends StatefulWidget {
  const ComprarProductos({super.key});

  @override
  State<ComprarProductos> createState() => _ComprarProductosState();
}

class _ComprarProductosState extends State<ComprarProductos> {
  List<Datos_Producto> datos = [];
  bool loading = true;

  Future<List<Datos_Producto>> tomar_datos() async {
    var url = Uri.https('api.aulagrammae.com', 'apps/ver_productos.php');
    var response = await https.post(url).timeout(Duration(seconds: 90));
    print(response.body);
    var datos = jsonDecode(response.body);
    List<Datos_Producto> registros = [];

    for (var producto in datos) {
      registros.add(Datos_Producto.fromJson(producto));
    }

    return registros;
  }

  Future<void> Foto() async {
    var url = Uri.https('api.aulagrammae.com', 'apps/ver_foto.php');
    var response = await https.post(url, body: {
      //'id': correo,
      //'foto': pass,
    });
    final sensual = jsonDecode(response.body);
    print('Respuesta completa: ${response.body}');
  }

  @override
  void initState() {
    super.initState();
    tomar_datos().then((value) {
      setState(() {
        datos.addAll(value);
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cursos",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF040C52),
      ),
      endDrawer: Menu(),
      body: loading
          ? Center(
        child: CircularProgressIndicator(color: Colors.blue),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView.builder(
          itemCount: datos.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      "https://api.aulagrammae.com/apps/Fotos/${datos[index].foto!}",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datos[index].nombre!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          datos[index].descripcion!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${datos[index].precio!}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return confirmarCompra();
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF040C52),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Comprar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
