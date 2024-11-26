import 'dart:convert';
import 'package:app_aulagramma/confirmarCompra.dart';
import 'package:app_aulagramma/datos_producto.dart';
import 'package:app_aulagramma/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:image_card/image_card.dart';

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
    var datos = jsonDecode(response.body);
    List<Datos_Producto> registros = [];

    for (var producto in datos) {
      registros.add(Datos_Producto.fromJson(producto));
    }

    return registros;
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
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return confirmarCompra();
                        },
                      ),
                    );
                  },
                  child: TransparentImageCard(
                    width: double.infinity,
                    height: 250,
                    borderRadius: 15,
                    imageProvider: NetworkImage(
                      "https://api.aulagrammae.com/apps/Fotos/${datos[index].foto!}",
                    ),
                    title: Text(
                      datos[index].nombre!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    description: Text(
                      datos[index].descripcion!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    tags: [
                      Text(
                        "\$${datos[index].precio!}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
