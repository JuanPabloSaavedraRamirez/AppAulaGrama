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
    setState(() { //para que se este actualizando y solo lo tiene el stateful
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
                  alignment: Alignment.bottomRight, //Acomodar el stack
                  children: [
                    Image.asset("Imagenes/Tbate1.jpg"),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),//darle un pading determinado
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5), //decorar la caja
                      ),
                      child: const Text("500 mnx", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ],
                ),
                const SizedBox( //Para poder separar
                  height: 10,
                ),
                const Text("Tbate Volumen 7", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),
                const SizedBox(
                  height: 10,
                ),
                const Text("Este es el volumen 7 del libro the beginning after the end", style: TextStyle(
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
                    shape: RoundedRectangleBorder( //Para quitarle el redondeo al boton
                        borderRadius: BorderRadius.circular(0)
                    ),
                    elevation: 20, //para fingir que anda elevador el boton
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
