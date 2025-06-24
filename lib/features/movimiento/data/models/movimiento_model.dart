import '../../domain/entities/movimiento.dart';

class MovimientoModel extends Movimiento {
  MovimientoModel({
    required int id,
    required int productoId,
    required String tipo,
    required int cantidad,
    required DateTime fecha,
    required String detalles,
    required int usuarioId,
  }) : super(
         id: id,
         productoId: productoId,
         tipo: tipo,
         cantidad: cantidad,
         fecha: fecha,
         detalles: detalles,
         usuarioId: usuarioId,
       );
  factory MovimientoModel.fromMap(Map<String, dynamic> map) => MovimientoModel(
    id: map['id'],
    productoId: map['producto_id'],
    tipo: map['tipo'],
    cantidad: map['cantidad'],
    fecha: map['fecha'],
    detalles: map['detalles'],
    usuarioId: map['usuario_id'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'producto_id': productoId,
    'tipo': tipo,
    'cantidad': cantidad,
    'fecha': fecha.toIso8601String(),
    'detalles': detalles,
    'usuario_id': usuarioId,
  };
}
