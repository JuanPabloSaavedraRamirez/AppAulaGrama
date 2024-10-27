import 'package:app_aulagramma/Productos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class add_producto extends StatefulWidget {
  const add_producto({super.key});

  @override
  State<add_producto> createState() => _add_productoState();
}

class _add_productoState extends State<add_producto> {
  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController descProductController = TextEditingController();
  final TextEditingController priceProductController = TextEditingController();

  String nameP = "";
  String desP = "";
  String priceP = "";

  void complete(){
    nameP = nameProductController.text;
    desP = descProductController.text;
    priceP = priceProductController.text;
    addProduct();
  }

  Future<void> addProduct() async{
    var url = Uri.https('api.aulagrammae.com', 'apps/add_product.php');
    var response = await https.post(url, body:{
      'nombre': nameP,
      'descripcion': desP,
      'precio': priceP,
    });
    print('Respuesta: ' + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Agregar producto", style: TextStyle(
            //color: Color(0xFF040F51)
        ),),
      ),
      //backgroundColor: Color(0xFF040C52),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: nameProductController,
                    decoration: InputDecoration(
                      hintText: "Nombre",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.bookmark_add, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: descProductController,
                    decoration: InputDecoration(
                      hintText: "Descripcion",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.book, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: priceProductController,
                    decoration: InputDecoration(
                      hintText: "Precio",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.price_change_outlined, size: 20),
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
                          "Completar",
                          style: TextStyle(
                            color: Color(0xFF040C52),
                          ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
