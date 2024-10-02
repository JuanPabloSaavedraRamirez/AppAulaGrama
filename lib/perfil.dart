import 'package:app_aulagramma/login.dart';
import 'package:flutter/material.dart';
import 'package:app_aulagramma/tienda.dart';
import 'package:app_aulagramma/modificarPerfil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Perfil extends StatefulWidget {
  final String username;
  final String email;
  final String age;

  const Perfil({
    super.key,
    required this.username,
    required this.email,
    required this.age,
  });

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  late String _username;
  late String _email;
  late String _age;
  File? _profileImage;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _email = widget.email;
    _age = widget.age;
  }

  void _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('age');

    setState(() {
      _username = '';
      _email = '';
      _age = '';
      _profileImage = null;
    });
  }

  Future<void> _pickImage(int option) async {
    var pickedFile;
    if (option == 1) {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500,
      );
    } else {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500,
      );
    }

    if (pickedFile != null) {
      _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _cropImage(File picked) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: picked.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar Imagen',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _profileImage = File(croppedFile.path);
      });
    }
  }

  void _showImageOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Tomar foto'),
                onTap: () {
                  _pickImage(1);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Seleccionar de galería'),
                onTap: () {
                  _pickImage(2);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancelar'),
                onTap: () {
                  Navigator.of(context).pop();
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
        backgroundColor: Colors.blue,
        title: Text("Perfil"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: _showImageOptions,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  )
                      : null,
                ),
              ),
              SizedBox(height: 20),
              _buildProfileInfo('User:', _username),
              _buildProfileInfo('Correo:', _email),
              _buildProfileInfo('Edad:', _age),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton('Volver', () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext context) {
                      return tienda();
                    }));
                  }),
                  _buildActionButton('Modificar', () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext context) {
                      return ModificarPerfil(
                          currentEmail: _email,
                          currentUsername: _username,
                          currentAge: _age);
                    }));
                  }),
                ],
              ),
              _buildActionButton('Cerrar sesión', () {
                _clearUserData();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => login(),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.blue,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            color: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(value.isEmpty ? 'Sin datos' : value),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.blue[50],
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }
}
