import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:io';

class AddProducto extends StatefulWidget {
  const AddProducto({super.key});

  @override
  State<AddProducto> createState() => _AddProductoState();
}

class _AddProductoState extends State<AddProducto> {
  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController descProductController = TextEditingController();
  final TextEditingController priceProductController = TextEditingController();

  String nameP = "";
  String desP = "";
  String priceP = "";

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Dio dio = Dio();

  void complete() {
    nameP = nameProductController.text;
    desP = descProductController.text;
    priceP = priceProductController.text;
    addProduct();
  }

  Future<void> addProduct() async {
    var url = Uri.https('api.aulagrammae.com', 'apps/add_product.php');
    var response = await https.post(url, body: {
      'nombre': nameP,
      'descripcion': desP,
      'precio': priceP,
    });
    print('Respuesta: ' + response.body);
    Navigator.of(context).pop();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Seleccionar fuente de la imagen"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Cámara"),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Galería"),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
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
          'https://api.aulagrammae.com/apps/subir_foto.php',
          data: formData,
        );
        if (response.data == '1') {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "¡Éxito!",
            text: "La imagen se subió correctamente.",
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF040C52),
        title: const Text(
          "Agregar Producto",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: _showImageSourceDialog,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: _imageFile == null
                    ? const Center(
                  child: Text(
                    "Seleccionar Imagen",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameProductController,
                      decoration: const InputDecoration(
                        labelText: "Nombre del producto",
                        prefixIcon: Icon(Icons.bookmark_add),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descProductController,
                      decoration: const InputDecoration(
                        labelText: "Descripción",
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: priceProductController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Precio",
                        prefixIcon: Icon(Icons.price_change),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: complete,
              icon: const Icon(Icons.check),
              label: const Text("Guardar Producto"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C8CB2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: subirImagen,
              icon: const Icon(Icons.cloud_upload),
              label: const Text("Subir Imagen"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
