import 'package:flutter/material.dart';

class perfil extends StatefulWidget {
  const perfil({super.key});

  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                child: Text("User"),
              ),
              Container(
                child: Text("Correo"),
              ),
              Container(
                child: Text("Edad"),
              ),
              Row(
                children: [
                  Container(
                    child: ,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
