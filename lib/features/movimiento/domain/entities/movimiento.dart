class Movimiento {
  final int? id;
  final String? firebaseId;
  final int productoId;
  final String tipo; // 'entrada' o 'salida'
  final int cantidad;
  final DateTime fecha;
  final String detalles;
  final int usuarioId;

  Movimiento({
    this.id,
    this.firebaseId,
    required this.productoId,
    required this.tipo,
    required this.cantidad,
    required this.fecha,
    required this.detalles,
    required this.usuarioId,
  });
}
