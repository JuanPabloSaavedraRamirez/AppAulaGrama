import 'package:app_aulagramma/menu.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aula Gramma", style: TextStyle(
            color:Color(0xFF040F51),
      ),),
      ),
      endDrawer: Menu(),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            children: [
              SizedBox(height: 5,),
              Image.asset("Imagenes/LogoAulagramma.jpeg"),
              Row(
                children: [
                  Expanded(child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur lacinia quis sem et sagittis. Nulla vestibulum ultrices massa nec tincidunt. Quisque ut ligula at ligula scelerisque ornare. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam congue a ligula ut pellentesque. Phasellus blandit vitae lorem eget rhoncus. In eget sodales eros, vel congue magna. Integer scelerisque magna vitae orci sagittis lobortis. Quisque pretium euismod massa, vitae scelerisque mi vulputate in. Nullam viverra ipsum ac orci blandit aliquet.", style: TextStyle(
                    color: Colors.white,
                  ),))
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(child: Text("¿Que hacemos?", style: TextStyle(color: Colors.white),),),
                  SizedBox(width: 10,),
                  Container(child: Expanded(child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur lacinia quis sem et sagittis. Nulla vestibulum ultrices massa nec tincidunt. Quisque ut ligula at ligula scelerisque ornare", style: TextStyle(
                    color: Colors.white,
                  ),)),)

                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(child: Expanded(child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur lacinia quis sem et sagittis. Nulla vestibulum ultrices massa nec tincidunt. Quisque ut ligula at ligula scelerisque ornare", style: TextStyle(
                    color: Colors.white,
                  ),)),),
                  SizedBox(width: 10,),
                  Container(child: Text("¿Que hacemos?", style: TextStyle(color: Colors.white),),),
                ],
              ),
            ],
          )
        ],
      ),
      backgroundColor: Color(0xFF040F51),
    );
  }
}
