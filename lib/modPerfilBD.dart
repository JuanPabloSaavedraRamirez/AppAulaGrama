import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class modPerfilBD extends StatefulWidget {
  String? email;
  String? username;
  String? password;
  String? age;
  String? number;

  modPerfilBD(this.email, this.username,this.password, this.age, this.number, {super.key});

  @override
  State<modPerfilBD> createState() => _modPerfilBDState();
}

class _modPerfilBDState extends State<modPerfilBD> {
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
    emailController.text = widget.email ?? '';
    confirmEmailController.text = widget.email ?? '';
    passwordController.text = widget.password ?? '';
    confirmPasswordController.text = widget.password ?? '';
    usernameController.text = widget.username ?? '';
    ageController.text = widget.age ?? '';
    numberController.text = widget.number ?? '';
  }

  bool _validateEmails() {
    return emailController.text == confirmEmailController.text;
  }

  bool _validatePasswords() {
    return passwordController.text == confirmPasswordController.text;
  }

  bool _validateFields() {
    return emailController.text.isNotEmpty &&
        confirmEmailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        numberController.text.isNotEmpty;
  }

  Future<void> modificar() async {
    var url = Uri.https('api.aulagrammae.com', 'apps/mod_perfil.php');
    var response = await https.post(url, body: {
      'email': emailController.text,
      'username': usernameController.text,
      'age': ageController.text,
      'number': numberController.text,
      'password': passwordController.text,
    });

    print('Respuesta: ' + response.body);

    if (response.body == "1") {
      Navigator.of(context).pop();
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error al modificar perfil. Intenta de nuevo."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Modificar perfil BD", style: TextStyle(color: Color(0xFF040F51))),
      ),
      backgroundColor: Color(0xFF040C52),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                // Campos de texto para email y demás datos
                _buildTextField(emailController, "Nuevo Correo", Icons.person),
                _buildTextField(confirmEmailController, "Confirmar nuevo correo", Icons.person),
                _buildTextField(passwordController, "Nueva contraseña", Icons.password, obscureText: true),
                _buildTextField(confirmPasswordController, "Confirmar nueva contraseña", Icons.password, obscureText: true),
                _buildTextField(usernameController, "Nuevo Nombre de usuario", Icons.person),
                _buildTextField(ageController, "Fecha de nacimiento", Icons.numbers),
                _buildTextField(numberController, "Nuevo número", Icons.numbers),

                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_validateFields()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Debes llenar todos los campos"), backgroundColor: Colors.red));
                      } else if (!_validateEmails()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Los correos no coinciden. Por favor, verifica tus datos."), backgroundColor: Colors.red));
                      } else if (!_validatePasswords()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Las contraseñas no coinciden. Por favor, verifica tus datos."), backgroundColor: Colors.red));
                      } else {
                        modificar();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Confirmar", style: TextStyle(color: Color(0xFF040C52))),
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

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon, {bool obscureText = false}) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, size: 20),
        ),
      ),
    );
  }
}
