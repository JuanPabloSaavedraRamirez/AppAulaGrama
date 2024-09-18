import 'package:app_aulagramma/register.dart';
import 'package:app_aulagramma/tienda.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final username = TextEditingController();
  final password = TextEditingController();

  String user = "";
  String pw = "";

  validar(){
    if (user == '' || pw == ''){
      print("Debes de llenar todos los datos");
    }
    else if (user == 'JP' && pw == '123'){
      guardar_prefs();
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
        return tienda();
      }
      ));
    }
    else{
      print("usuario o contraseña incorrecta");
      username.text = '';
      password.text = '';
    }
  }

  Future <void> guardar_prefs() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("usuario", "JP");
  }

  Future <void> tomar_datos() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getString("usuario")!;

    //prefs.clear();

    if (user != null){
      if (user != ''){
        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
          return tienda();
        }
        ));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tomar_datos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("",),
      ),
      backgroundColor: Colors.blue[800],
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.blue,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(20)),
                Text("Bienvenido", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[50],
                    fontSize: 30
                ),),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      hintText: " Usuario",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: " Contraseña",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.public, size: 20,),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: (){
                      user = username.text;
                      pw = password.text;
                      validar();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Login", style: TextStyle(
                          color: Colors.black,
                        ),),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                      ),
                    ),
                  ),
                ),
                Text("¿Perdiste tu contraseña?", style: TextStyle(
                  color: Colors.blue[50],
                ),),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                        return register();
                      }
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" ¿No tienes cuenta? Registrate", style: TextStyle(
                          color: Colors.blue[50],
                        ),),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text("Volver", style: TextStyle(
              color: Colors.blue[50],
            ),),
          ),
        ],
      ),
    );
  }
}
