import 'package:app_aulagramma/blog.dart';
import 'package:app_aulagramma/home.dart';
import 'package:app_aulagramma/perfil.dart';
import 'package:app_aulagramma/tienda.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    obtenerDatos();
  }

  Future<void> obtenerDatos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String regUsername = prefs.getString('username') ?? '';
    String regEmail = prefs.getString('email') ?? '';
    String regAge = prefs.getString('age') ?? '';
    String regNumber = prefs.getString('number') ?? '';

    String loginUsername = prefs.getString('loginUsername') ?? '';
    String loginEmail = prefs.getString('loginEmail') ?? '';
    String loginAge = prefs.getString('loginAge') ?? '';
    String loginNumber = prefs.getString('loginNumber') ?? '';

    setState(() {
      username = regUsername.isNotEmpty ? regUsername : loginUsername;
      email = regEmail.isNotEmpty ? regEmail : loginEmail;
      age = regAge.isNotEmpty ? regAge : loginAge;
      number = regNumber.isNotEmpty ? regNumber : loginNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username.isNotEmpty ? username : "Usuario"),
            accountEmail: Text(email.isNotEmpty ? email : "email@example.com"),
            currentAccountPicture: Image.asset("Imagenes/LogoAulagramma.jpeg"),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Perfil(
                        username: username,
                        email: email,
                        age: age,
                        number: number,
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
              onPressed: () {
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
