class Datos_Producto {
  final String? id;
  final String? nombre;
  final String? descripcion;
  final String? precio;
  final String? foto;

  Datos_Producto({this.id, this.nombre, this.descripcion, this.precio, this.foto});

  factory Datos_Producto.fromJson(Map<String, dynamic> json) {
    return Datos_Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: json['precio'],
      foto: json['foto'],
    );
  }
}
