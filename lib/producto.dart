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
                        color: Color(0xFFD0DBF3).withOpacity(0.5)
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
                  color: Color(0xFF040F51)
                ),),
                const SizedBox(
                  height: 10,
                ),
                const Text("Este curso trata de ....", style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFF040F51)
                ),),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: (){
                    agregarCarrito();
                  },
                  child: Text(texto, style: TextStyle(
                    color: Color(0xFF040C52),
                  ),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7C8CB2),
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
