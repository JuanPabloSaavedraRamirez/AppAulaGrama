import 'package:app_aulagramma/home.dart';
import 'package:app_aulagramma/perfil.dart';
import 'package:app_aulagramma/tienda.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  Future<Map<String, String>> obtenerDatos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("usuario") ?? '';
    String email = prefs.getString("correo") ?? '';
    String age = prefs.getString("edad") ?? '';
    String number = prefs.getString("numero") ?? '';

    return {
      'username': username,
      'email': email,
      'age': age,
      'number': number,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("JP Saavedra"),
            accountEmail: Text("Saavedra75@live.com"),
            currentAccountPicture: Image.asset("Imagenes/LogoAulagramma.jpeg"),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return home();
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Aula Gramma",
                    style: TextStyle(
                      color: Colors.blue[50],
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                final datos = await obtenerDatos();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Perfil(
                        username: datos['username']!,
                        email: datos['email']!,
                        age: datos['age']!,
                        number: datos['number']!,
                      );
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Perfil",
                    style: TextStyle(
                      color: Colors.blue[50],
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return tienda();
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tienda",
                    style: TextStyle(
                      color: Colors.blue[50],
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
