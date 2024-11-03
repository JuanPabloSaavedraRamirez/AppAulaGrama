import 'dart:convert';
import 'package:app_aulagramma/addProducto.dart';
import 'package:app_aulagramma/confirmarCompra.dart';
import 'package:app_aulagramma/datos_producto.dart';
import 'package:app_aulagramma/menu.dart';
import 'package:app_aulagramma/modificarProducto.dart';
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

  @override
  void initState() {
    super.initState();
    tomar_datos().then((value) {
      setState(() {
        datos.addAll(value);
        loading = false;
      });
      print(datos);
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
            return Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon or image placeholder for product
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF040C52),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF040C52),
                    ),
                  ),
                  SizedBox(width: 15),
                  // Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datos[index].nombre!,
                          style: TextStyle(
                            fontSize: 16,
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
                        SizedBox(height: 5),
                        Text(
                          "\$${datos[index].precio!}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  // Buy button
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
                      padding: EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
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
            );
          },
        ),
      ),
    );
  }
}
