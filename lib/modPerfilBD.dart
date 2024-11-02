import 'package:flutter/material.dart';

class modPerfilBD extends StatefulWidget {
  const modPerfilBD({super.key});

  @override
  State<modPerfilBD> createState() => _modPerfilBDState();
}

class _modPerfilBDState extends State<modPerfilBD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("modificar datos del perfil", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
         ),),
          backgroundColor: Color(0xFF040C52),
    ),
    );
  }
}
