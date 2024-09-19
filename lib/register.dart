import 'package:flutter/material.dart';
import 'package:app_aulagramma/perfil.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Controladores para los campos de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  // Función para validar que los campos no estén vacíos
  bool _validateFields() {
    return emailController.text.isNotEmpty &&
        confirmEmailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        ageController.text.isNotEmpty;
  }

  // Función para validar que los correos coincidan
  bool _validateEmails() {
    return emailController.text == confirmEmailController.text;
  }

  // Función para validar que las contraseñas coincidan
  bool _validatePasswords() {
    return passwordController.text == confirmPasswordController.text;
  }

  // Mostrar un mensaje de error
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

  // Lógica cuando se presiona el botón "Completar"
  void _onComplete() {
    if (!_validateFields()) {
      _showError("Por favor, completa todos los campos.");
    } else if (!_validateEmails()) {
      _showError("Los correos no coinciden. Por favor, verifica tus datos.");
    } else if (!_validatePasswords()) {
      _showError("Las contraseñas no coinciden. Por favor, verifica tus datos.");
    } else {
      // Navega a la pantalla de perfil pasando los datos automáticamente
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        return Perfil(
          username: usernameController.text,  // Pasa el nombre de usuario
          email: emailController.text,        // Pasa el correo
          age: ageController.text,            // Pasa la edad
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Registro"),
      ),
      backgroundColor: Colors.blue,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                // Campo de texto para correo
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
                // Campo de texto para confirmar correo
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
                // Campo de texto para contraseña
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
                // Campo de texto para confirmar contraseña
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
                // Campo de texto para nombre de usuario
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
                // Campo de texto para la edad
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Edad",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.numbers, size: 20),
                    ),
                  ),
                ),
                // Botón "Completar"
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
                // Botón para iniciar sesión si ya tiene cuenta
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "¿Ya tienes cuenta? Inicia sesión",
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
          ),
        ],
      ),
    );
  }
}
