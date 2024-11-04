  import 'dart:convert';
  import 'dart:io';
  import 'package:app_aulagramma/datos_perfil.dart';
import 'package:app_aulagramma/menu.dart';
  import 'package:app_aulagramma/modPerfilBD.dart';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as https;
  import 'package:image_picker/image_picker.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:app_aulagramma/loginBD.dart';

  class perfilBD extends StatefulWidget {
    const perfilBD({super.key});

    @override
    State<perfilBD> createState() => _perfilBDState();
  }

  class _perfilBDState extends State<perfilBD> {
    List<datos_perfil> datos = [];
    bool loading = true;
    File? _imageFile;
    final ImagePicker _picker = ImagePicker();

    Future<List<datos_perfil>> tomar_datos() async {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('IDUser');

      var url = Uri.https('api.aulagrammae.com', 'apps/ver_perfil.php');
      var response = await https.post(url).timeout(Duration(seconds: 90));
      print(response.body);
      var datosJson = jsonDecode(response.body) as List;
      List<datos_perfil> perfil = [];

      for (var datos in datosJson) {
        var perfilUsuario = datos_perfil.fromJson(datos);

        if (perfilUsuario.id == userId) {
          perfil.add(perfilUsuario);
          break;
        }
      }

      return perfil;
    }


    Future<void> _pickImage(ImageSource source) async {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        _saveImageToPreferences(_imageFile!);
      }
    }

    Future<void> _saveImageToPreferences(File image) async {
      final prefs = await SharedPreferences.getInstance();
      final bytes = await image.readAsBytes();
      String imgString = base64Encode(bytes);
      await prefs.setString('profile_image', imgString);
    }

    Future<void> _loadImageFromPreferences() async {
      final prefs = await SharedPreferences.getInstance();
      String? imgString = prefs.getString('profile_image');
      if (imgString != null) {
        setState(() {
          _imageFile = File.fromRawPath(base64Decode(imgString));
        });
      }
    }

    Future<void> _logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('profile_image');
      await prefs.remove('IDUser');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => loginBD()),
            (Route<dynamic> route) => false,
      );
    }



    @override
    void initState() {
      super.initState();
      tomar_datos().then((value) {
        setState(() {
          datos.addAll(value);
          loading = false;
        });
        print(datos);
      });
      _loadImageFromPreferences();
    }

    void _showImageSourceSelection() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Tomar foto'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Elegir de la galería'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Perfil",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Color(0xFF040C52),
        ),
        backgroundColor: Color(0xFFEBF0FA),
        endDrawer: Menu(),
        body: loading
            ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ),
        )
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _showImageSourceSelection,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  _imageFile != null ? FileImage(_imageFile!) : null,
                  backgroundColor: Colors.blueGrey,
                  child: _imageFile == null
                      ? Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  )
                      : null,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: datos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildProfileText(
                                    'Usuario', datos[index].user),
                                _buildProfileText(
                                    'Correo', datos[index].correo),
                                _buildProfileText(
                                    'Teléfono', datos[index].numTelefonico),
                                _buildProfileText('Nacimiento',
                                    datos[index].FechaNacimiento),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (datos.isNotEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => modPerfilBD(
                          datos[0].correo,
                          datos[0].user,
                          datos[0].password,
                          datos[0].FechaNacimiento,
                          datos[0].numTelefonico,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF040F51),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Modificar perfil',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Cerrar sesión',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

            ],
          ),
        ),
      );
    }

    Widget _buildProfileText(String label, String? value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Text(
              '$label: ',
              style: TextStyle(
                color: Color(0xFF040C52),
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                value ?? 'Sin datos',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    }
  }
