class Producto {
  final int? id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String categoria;
  final int umbralStockBajo;
  final int usuarioId;

  Producto({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.categoria,
    required this.umbralStockBajo,
    required this.usuarioId,
  });
}
