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
          ListTile(
            title: Text("Perfil"),
            leading: Icon(Icons.person),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}

