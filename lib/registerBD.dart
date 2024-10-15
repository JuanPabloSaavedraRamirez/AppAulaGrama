import 'package:app_aulagramma/login.dart';
import 'package:flutter/material.dart';
import 'package:app_aulagramma/perfil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterBD extends StatefulWidget {
  const RegisterBD ({super.key});

  @override
  State<RegisterBD> createState() => _RegisterStateBD();
}

class _RegisterStateBD extends State<RegisterBD> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  bool _validateFields() {
    return emailController.text.isNotEmpty &&
        confirmEmailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        numberController.text.isNotEmpty;
  }

  bool _validateEmails() {
    return emailController.text == confirmEmailController.text;
  }

  bool _validatePasswords() {
    return passwordController.text == confirmPasswordController.text;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('username', usernameController.text);
    await prefs.setString('age', ageController.text);
    await prefs.setString('number', numberController.text);
  }


  void _onComplete() async {
    if (!_validateFields()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Debes llenar todos los campos"),
            backgroundColor: Colors.red,));
    } else if (!_validateEmails()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Los correos no coinciden. Por favor, verifica tus datos."),
            backgroundColor: Colors.red,));
    } else if (!_validatePasswords()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Las contraseñas no coinciden. Por favor, verifica tus datos."),
            backgroundColor: Colors.red,));
    } else {
      await _saveData();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return Perfil(
          username: usernameController.text,
          email: emailController.text,
          age: ageController.text,
          number: numberController.text,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Registro para base de datos", style: TextStyle(
            color: Color(0xFF040F51)
        ),),
      ),
      backgroundColor: Color(0xFF040C52),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Correo",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.email, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: confirmEmailController,
                    decoration: InputDecoration(
                      hintText: "Confirmar correo",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.email, size: 20),
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
                  color: Colors.white,
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirmar contraseña",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.lock, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Nombre de usuario",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Fecha de nacimiento",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.numbers, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Numero",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.numbers, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: _onComplete,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Completar",
                          style: TextStyle(
                            color: Color(0xFF040C52),
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7C8CB2),
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
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return login();
                          },
                        ),
                            (Route<dynamic> route) => false, // Esta es la condición que faltaba para la función pushAndRemoveUntil
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "¿Ya tienes cuenta? Inicia sesión",
                          style: TextStyle(
                            color: Color(0xFF040C52),
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7C8CB2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
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
