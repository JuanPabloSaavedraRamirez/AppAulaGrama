import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class modPerfilBD extends StatefulWidget {
  String? id;
  String? user;
  String? correo;
  String? password;
  String? numTelefonico;
  String? FechaNacimiento;
  modPerfilBD(this.id, this.user,this.correo, this.password,
      this.numTelefonico, this.FechaNacimiento, {super.key});

  @override
  State<modPerfilBD> createState() => _modPerfilBDState();
}

class _modPerfilBDState extends State<modPerfilBD> {

  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController descProductController = TextEditingController();
  final TextEditingController priceProductController = TextEditingController();

  String nameP = "";
  String desP = "";
  String priceP = "";
  String idP = "";

  void complete(){
    nameP = nameProductController.text;
    desP = descProductController.text;
    priceP = priceProductController.text;
    modificar();
  }

  Future<void> modificar() async{
    var url = Uri.https('api.aulagrammae.com', 'apps/mod_product.php');
    var response = await https.post(url, body:{
      'nombre': nameP,
      'descripcion': desP,
      'precio': priceP,
      'id': widget.id,
    });
    print('Respuesta: ' + response.body);

    if (response.body == "1"){
      Navigator.of(context).pop();
    }else{
      print(response.body);
    }
    //Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      //nameProductController.text = widget.nombre!;
      //descProductController.text = widget.descripcion!;
      //priceProductController.text = widget.precio!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Modificar perfil", style: TextStyle(
          //color: Color(0xFF040F51)
        ),),
      ),
      backgroundColor: Color(0xFF040C52),
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
