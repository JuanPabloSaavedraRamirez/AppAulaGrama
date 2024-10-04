import 'package:flutter/material.dart';

class producto extends StatefulWidget {
  const producto({super.key});

  @override
  State<producto> createState() => _productoState();
}

class _productoState extends State<producto> {

  String texto = "compra 0";
  int contador = 0;
  void agregarCarrito() {
    contador ++;
    setState(() {
      texto = "compro $contador";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image.asset("Imagenes/LogoAulagramma.jpeg"),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5)
                      ),
                      child: const Text("3500 mnx", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Curso de ...", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),
                const SizedBox(
                  height: 10,
                ),
                const Text("Este curso trata de ....", style: TextStyle(
                  fontSize: 9,
                ),),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton( //un boton
                  onPressed: (){
                    agregarCarrito();
                  },
                  child: Text(texto, style: TextStyle(
                    color: Colors.white,
                  ),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                    ),
                    elevation: 20,
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
