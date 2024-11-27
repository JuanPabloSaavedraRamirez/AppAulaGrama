import 'dart:convert';
import 'dart:io';
import 'package:app_aulagramma/datos_perfil.dart';
import 'package:app_aulagramma/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_aulagramma/loginBD.dart';
import 'package:quickalert/quickalert.dart';

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
  Dio dio = Dio();

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

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image');
    await prefs.remove('IDUser');

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => loginBD()),
          (Route<dynamic> route) => false,
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _saveImageToPreferences(_imageFile!); // Guardar en SharedPreferences
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
      // Crear un archivo temporal desde la imagen codificada
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/temp_profile_image.png');
      await tempFile.writeAsBytes(base64Decode(imgString));
      setState(() {
        _imageFile = tempFile; // Cargar la imagen como archivo
      });
    }
  }

  Future<void> subirImagen() async {
    if (_imageFile != null) {
      String filename = _imageFile!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _imageFile!.path,
          filename: filename,
        ),
      });

      try {
        var response = await dio.post(
          'https://api.aulagrammae.com/apps/foto_perfil.php',
          data: formData,
        );
        if (response.data == '1') {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "¡Éxito!",
            text: "La imagen de perfil se subió correctamente.",
          );
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Error",
            text: "No se pudo subir la imagen. Inténtalo de nuevo.",
          );
        }
      } catch (e) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Error",
          text: "Ocurrió un error al subir la imagen: $e",
        );
      }
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: "Advertencia",
        text: "Selecciona una imagen antes de intentar subirla.",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImageFromPreferences(); // Cargar imagen al iniciar
    tomar_datos().then((value) {
      setState(() {
        datos.addAll(value);
        loading = false;
      });
      print(datos);
    });
  }

  void _showImageSourceSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar foto'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Elegir de la galería'),
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
        title: const Text(
          "Perfil",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF040C52),
      ),
      backgroundColor: const Color(0xFFEBF0FA),
      endDrawer: const Menu(),
      body: loading
          ? const Center(
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
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : null,
                backgroundColor: Colors.blueGrey,
                child: _imageFile == null
                    ? const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: subirImagen,
              icon: const Icon(Icons.cloud_upload),
              label: const Text("Subir Imagen de Perfil"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: datos.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildProfileCard(datos[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(datos_perfil perfil) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileText('Usuario', perfil.user),
          _buildProfileText('Correo', perfil.correo),
          _buildProfileText('Teléfono', perfil.numTelefonico),
          _buildProfileText('Nacimiento', perfil.FechaNacimiento),
        ],
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
            style: const TextStyle(
              color: Color(0xFF040C52),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'Sin datos',
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
