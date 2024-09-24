import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class camara extends StatefulWidget {
  const camara({super.key});

  @override
  State<camara> createState() => _camaraState();
}

class _camaraState extends State<camara> {

  final picker = ImagePicker();
  File? image = null; //el "?" es para decir que puede ser nulo

  Future tomar_foto(opcion) async{
    var pickedFile;

    if(opcion == 1){
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500,
      );
    }
    else{
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500,
      );
    }
    setState(() {
      if(pickedFile != null){
        //image = File(pickedFile.path);
        portal(File(pickedFile.path));
      }
    });
    Navigator.of(context).pop();
  }

  portal(picked) async{
    CroppedFile? cortado = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: CropAspectRatio(
            ratioX: 1,
            ratioY: 1
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cortar imagen',
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
              CropAspectRatioPreset.square, // IMPORTANT: iOS supports only one custom aspect ratio in preset list
            ],
          ),
          WebUiSettings(
            context: context,
          ),
        ],
    );

    var ruta = cortado?.path;
    setState(() {
      image = File(ruta!);
    });
  }

  opciones(){
    showDialog(
        context: context,
        builder:(BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content:SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    onTap: (){
                      tomar_foto(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.blue),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Text("Tomar foto", style: TextStyle(
                            fontSize: 18,
                          ),)),
                          Icon(Icons.camera_alt),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    /*borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                      ),*/
                    onTap: (){
                      tomar_foto(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Text("Tomar de galeria", style: TextStyle(
                            fontSize: 18,
                          ),)),
                          Icon(Icons.photo),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: Colors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cancelar", style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),);
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camara"),
      ),
      body: Padding(padding: const EdgeInsets.all(30),
        child:ListView(
          children: [
            SizedBox(height: 20,),
            image == null ? Container() : Image.file(image!, width: 200,),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                opciones();
              },
              child: Text("Foto", style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                ),
              ),
        ],
      ),),
    );
  }
}
