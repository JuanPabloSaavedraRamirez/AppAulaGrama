import 'package:app_aulagramma/comprarProductos.dart';
import 'package:app_aulagramma/loginBD.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';


class RegisterBD extends StatefulWidget {
  const RegisterBD({super.key});

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

  String user = "";
  String correo = "";
  String pass = "";
  String date = "";
  String number = "";

  void complete() {
    if (_verifyFields()) {
      user = usernameController.text;
      correo = emailController.text;
      pass = passwordController.text;
      date = ageController.text;
      number = numberController.text;
      register();
    }
  }

  bool _verifyFields() {
    // Verificar campos vacíos
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        confirmEmailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        ageController.text.isEmpty ||
        numberController.text.isEmpty) {
      _showAlertDialog("Error", "Falta llenar un campo.");
      return false;
    }
    if (emailController.text != confirmEmailController.text) {
      _showAlertDialog("Error", "Los correos electrónicos no coinciden.");
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      _showAlertDialog("Error", "Las contraseñas no coinciden.");
      return false;
    }
    return true;
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> register() async {
    var url = Uri.https('api.aulagrammae.com', 'apps/register.php');
    var response = await https.post(url, body: {
      'User': user,
      'Correo': correo,
      'Password': pass,
      'FechaDeNacimiento': date,
      'Numero': number,
    });
    print('Respuesta: ' + response.body);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ComprarProductos(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Registrate BD", style: TextStyle(color: Color(0xFF040F51))),
      ),
      backgroundColor: Color(0xFF040C52),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                _buildTextField(emailController, "Correo", Icons.email),
                _buildTextField(confirmEmailController, "Confirmar correo", Icons.email),
                _buildTextField(passwordController, "Contraseña", Icons.lock, obscureText: true),
                _buildTextField(confirmPasswordController, "Confirmar contraseña", Icons.lock, obscureText: true),
                _buildTextField(usernameController, "Nombre de usuario", Icons.person),
                _buildTextField(ageController, "Fecha de nacimiento", Icons.cake),
                _buildTextField(numberController, "Numero", Icons.phone, keyboardType: TextInputType.number),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: complete,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Completar", style: TextStyle(color: Color(0xFF040C52))),
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginBD()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¿Ya tienes cuenta? Inicia sesión", style: TextStyle(color: Color(0xFF040C52))),
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

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon, {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, size: 20),
        ),
      ),
    );
  }
}

