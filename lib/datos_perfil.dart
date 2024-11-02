class datos_perfil{
  String? id;
  String? user;
  String? correo;
  String? password;
  String? numTelefonico;
  String? FechaNacimiento;

  datos_perfil(this.id, this.user, this.correo, this.password,
      this.numTelefonico, this.FechaNacimiento);

  datos_perfil.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    user = json['user'];
    correo = json['correo'];
    password = json['password'];
    numTelefonico = json['numTelefonico'].toString();
    FechaNacimiento = json['fechaNacimiento'].toString();
  }
}