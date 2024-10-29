class Datos_Producto{
  String? id;
  String? nombre;
  String? descripcion;
  String? precio;

  Datos_Producto(this.id, this.nombre, this.descripcion, this.precio);

  Datos_Producto.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    precio = json['precio'].toString();
  }
}