import 'package:app_aulagramma/perfil.dart';
import 'package:app_aulagramma/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String cor = "saavedra75@live.com";
  String edad = "20";
  String number = "3310145888";

  void validar() {
    final String user = usernameController.text.trim();
    final String pw = passwordController.text.trim();

    if (user.isEmpty || pw.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Debes llenar todos los campos")),
      );
    } else if (user == 'JP' && pw == '123') {
      guardar_prefs(user);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Perfil(
              username: user,
              email: cor,
              age: edad,
              number: number,
            );
          },
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuario o contraseña incorrectos")),
      );
      usernameController.clear();
      passwordController.clear();
    }
  }

  Future<void> guardar_prefs(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("usuario", user);
    await prefs.setString("loginEmail", cor);
    await prefs.setString("loginAge", edad);
    await prefs.setString("loginNumber", number);
  }

  Future<void> tomar_datos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedUser = prefs.getString("username");

    if (storedUser != null && storedUser.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Perfil(
              username: storedUser,
              email: cor,
              age: edad,
              number: number,
            );
          },
        ),
      );
    }
  }


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("Login"),
      ),
      backgroundColor: Colors.blue[800],
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.blue,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(20)),
                  Text(
                    "Bienvenido",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[50],
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Usuario",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.person, size: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.lock, size: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        validar();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "¿Perdiste tu contraseña?",
                    style: TextStyle(color: Colors.blue[50]),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Register();
                          },
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "¿No tienes cuenta? Regístrate",
                            style: TextStyle(color: Colors.blue[50]),
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
                  SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Volver",
                style: TextStyle(
                  color: Colors.blue[50],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
