import 'dart:ffi';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( //la bara superior
          title: Text("Youtube", style: TextStyle(color: Colors.white),), // Youtube
          //title: Text("Facebook", style: TextStyle(color: Colors.blue),), //Facebook
          backgroundColor: Colors.white10,
        ),
        backgroundColor: Colors.black54, //Youtube
        //backgroundColor: Colors.white, //Facabook

        body:

        /*Center( //toma el espacio disponible y lo centra (el child)
        child: /*Text("Hola mundo", style: TextStyle( //Las fuentes personalizadas hay cosas que no puede usar
          color: Colors.deepPurple,
          fontSize: 40,
          //fontWeight: FontWeight.bold,
          //fontStyle: FontStyle.italic,
          letterSpacing: 2.5,
          wordSpacing: 10,
          fontFamily: "bellena",
        ),),*/
        //Image.asset('Imagenes/Tbate1.jpg', width: 200,) //Asi se cargan imagenes
        //Image.network("https://images8.alphacoders.com/113/1135889.jpg") //cargarla desde la web

      ),*/
        /*Container(
        alignment: Alignment.center,
        child: Image.asset('Imagenes/Tbate1.jpg', width: 200,), //Se le agrega imagen al contenedor
        //color: Colors.amber,
        margin: EdgeInsets.all(20), //usa el margin top/button
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
            color: Colors.amber, //si tiene decoration el color debe ir dentro
          //border: Border.all(color: Colors.red,width: 3),
          borderRadius: BorderRadius.circular(20),
          border: Border(
            bottom: BorderSide(color: Colors.red,width: 3), //lo aplica solo abajo
          )
        ),
      )*/
        /*Row( //Filas
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [ //es un array
          Image.asset("Imagenes/Tbate1.jpg", width: 100),
          Image.asset("Imagenes/Tbate2.jpg", width: 80),
          Image.asset("Imagenes/Tbate3.jpg", width: 50,), //de esta manera excede el ancho de mi pantalla
        ],
      )*/
        /*Column( //columnas
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [ //es un array
          Image.asset("Imagenes/Tbate1.jpg", width: 100),
          Image.asset("Imagenes/Tbate2.jpg", width: 80),
          Image.asset("Imagenes/Tbate3.jpg", width: 50,),
        ],
      )*/
        /*Row( //Filas
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [ //es un array

          Expanded(
            flex: 3,
              child: Image.asset("Imagenes/Tbate1.jpg")
          ),
          Expanded(
              flex: 2,
              child: Image.asset("Imagenes/Tbate2.jpg")
          ),
          Expanded(
              flex: 3,
              child: Image.asset("Imagenes/Tbate3.jpg")
          ),
          Text("Hola mundo"),
          Icon(Icons.more_vert,color: Colors.red, size: 40,)
        ],
      )*/

        //Youtube
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("Imagenes/Tbate.jpg"),
          Row(
              children: [
                Image.asset("Imagenes/Logo.png", width: 40,),
                const Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cap. 486 | Libro 12 | TBATE | Novela Web", style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),),
                      Text("Dahak resume | 1.3k vistas | hace 2 dias", style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),)
                    ],
                  ),
                ),
                const Icon(Icons.more_vert,color: Colors.white, size: 20,)
              ]//
          )
        ]
      )

        //Facebook
        /*Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("Imagenes/Logo.png", width: 40,),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sacktoon", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),),
                        Row(
                          children: [
                            Text("Publicidad · ", style: TextStyle(
                              fontSize: 10,
                            ),),
                            Icon(Icons.public, size: 12,)
                          ],
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    const Row(
                      children: [
                        Icon(Icons.more_horiz,color: Colors.black, size: 20,),
                        Icon(Icons.close_rounded, size: 20,)
                      ],
                    ),
                  ],
                ),
                Container(width: double.infinity, child: Image(image: AssetImage("Imagenes/Diplomado.jpg"), fit: BoxFit.fill,),),
              ],
            ),
            Container(
              color: Colors.grey,
              child:
              const Row(
                children: [
                  Text("Whatsapp",style: TextStyle(
                      fontSize: 12
                  ),),
                ],
              ),
            ),

            Container(
              color: Colors.grey,
              child:
              Row(
                children: [
                  const Flexible(
                    child: Text("Diplomado de animacion para niños y adolecentes | Sacktoon animation", softWrap: true, style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  FilledButton(style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green),onPressed: () {}, child: Text("Whatsapp"),)
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.thumb_up, size: 15,color: Colors.blue,),
                Text(" 3", style: TextStyle(
                  fontSize: 15,
                ),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("                                                           1 comentario", style: TextStyle(
                      fontSize: 15,
                    ),)
                  ],
                )
              ],
            ),
            Container(height: 10,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.thumb_up_off_alt, size: 17, color: Colors.black, ),
                Text(" Me gusta ", style: TextStyle(
                  fontSize: 17
                ),),

                Icon(Icons.chat_bubble_outline, size: 17,),
                Text(" Comentar ", style: TextStyle(
                  fontSize: 17,
                ),),

                Icon(Icons.link, size: 17,),
                Text(" Compartir ", style: TextStyle(
                  fontSize: 17,
                ),),
              ],
            )
          ],
        ),*/
    );
  }
}
