import 'dart:convert';
import 'package:app_aulagramma/blog.dart';
import 'package:app_aulagramma/comprarProductos.dart';
import 'package:app_aulagramma/home.dart';
import 'package:app_aulagramma/perfilBD.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String username = '';
  String email = '';
  String age = '';
  String number = '';
  String IDUser = '';

  @override
  void initState() {
    super.initState();
    obtenerDatos();
  }

  Future<void> obtenerDatos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString('IDUser') ?? '';

    if (userId.isNotEmpty) {
      var url = Uri.https('api.aulagrammae.com', 'apps/ver_perfil.php');
      var response = await https.post(url, body: {'userId': userId});

      if (response.statusCode == 200) {
        var datosJson = jsonDecode(response.body) as List;

        for (var datos in datosJson) {
          if (datos['id'] == userId) {
            setState(() {
              username = datos['user'] ?? '';
              email = datos['correo'] ?? '';
              age = datos['age'] ?? '';
              number = datos['numTelefonico'] ?? '';
            });
            break;
          }
        }
      } else {
        print('Error en la obtención de datos del usuario: ${response.statusCode}');
      }
    } else {
      print('ID de usuario no encontrado.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username.isNotEmpty ? username : "Usuario", style: TextStyle(
              color: Color(0xFFD0DBF3),
            )),
            accountEmail: Text(email.isNotEmpty ? email : "email@example.com", style: TextStyle(
              color: Color(0xFFD0DBF3),
            )),
            currentAccountPicture: Image.asset("Imagenes/LogoAulagramma.jpeg"),
            decoration: BoxDecoration(
              color: Color(0xFF040C52),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
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
                  Text("Aula Gramma", style: TextStyle(
                    color: Color(0xFFD0DBF3),
                  )),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF040C52),
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
                      return perfilBD();
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
                      color: Color(0xFFD0DBF3),
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF040C52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ComprarProductos();
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
                      color: Color(0xFFD0DBF3),
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF040C52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Blog(username: username);
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Blog",
                    style: TextStyle(
                      color: Color(0xFFD0DBF3),
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF040C52),
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
