import 'package:flutter/material.dart';
import 'package:app_aulagramma/perfil.dart';

class ModificarPerfil extends StatefulWidget {
  final String currentEmail;
  final String currentUsername;
  final String currentAge;
  final String currentNumber;

  const ModificarPerfil({
    Key? key,
    required this.currentEmail,
    required this.currentUsername,
    required this.currentAge,
    required this.currentNumber,
  }) : super(key: key);

  @override
  State<ModificarPerfil> createState() => _ModificarPerfilState();
}

class _ModificarPerfilState extends State<ModificarPerfil> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.currentEmail;
    usernameController.text = widget.currentUsername;
    ageController.text = widget.currentAge;
    numberController.text = widget.currentNumber;
  }

  bool _validateEmails() {
    return emailController.text == confirmEmailController.text;
  }

  bool _validatePasswords() {
    return passwordController.text == confirmPasswordController.text;
  }

  bool _validateFields() {
    if (emailController.text.isEmpty ||
        confirmEmailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        usernameController.text.isEmpty ||
        ageController.text.isEmpty ||
        numberController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Modificar perfil", style: TextStyle(
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
                      hintText: "Nuevo Correo",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: confirmEmailController,
                    decoration: InputDecoration(
                      hintText: "Confirmar nuevo correo",
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
                      hintText: "Nueva contraseña",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.password, size: 20),
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
                      hintText: "Confirmar nueva contraseña",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.password, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Nuevo Nombre de usuario",
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
                    decoration: InputDecoration(
                      hintText: "Nueva Edad",
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
                    decoration: InputDecoration(
                      hintText: "Nuevo numero",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.numbers, size: 20),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_validateFields()) {
                        _showError("Hay campos vacíos. Por favor, completa todos los campos.");
                      } else if (!_validateEmails()) {
                        _showError("Los correos no coinciden. Por favor, verifica tus datos.");
                      } else if (!_validatePasswords()) {
                        _showError("Las contraseñas no coinciden. Por favor, verifica tus datos.");
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Perfil(
                                username: usernameController.text,
                                email: emailController.text,
                                age: ageController.text,
                                number: numberController.text,
                              );
                            },
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Confirmar",
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
