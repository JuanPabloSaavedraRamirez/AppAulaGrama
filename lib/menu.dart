import 'package:app_aulagramma/perfil.dart';
import 'package:flutter/material.dart';

class menu extends StatelessWidget {
  const menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("JP Saavedra"),
              accountEmail: Text("Saavedra75@live.com"),
              currentAccountPicture: Image.asset("Imagenes/Tbate2.jpg"),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                  return perfil();
                }
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(" Perfil", style: TextStyle(
                    color: Colors.blue[50],
                  ),),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

