import 'package:app/features/movimiento/presentation/pages/movimiento_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/movimiento.dart';

class MovimientoModel extends Movimiento {
  final String? firebaseId;
  MovimientoModel({
    int? id,
    this.firebaseId,
    required int productoId,
    required String tipo,
    required int cantidad,
    required DateTime fecha,
    required String detalles,
    required int usuarioId,
  }) : super(
         id: id,
         firebaseId: firebaseId,
         productoId: productoId,
         tipo: tipo,
         cantidad: cantidad,
         fecha: fecha,
         detalles: detalles,
         usuarioId: usuarioId,
       );

  MovimientoModel copyWith({
    int? id,
    String? firebaseId,
    int? productoId,
    String? tipo,
    int? cantidad,
    DateTime? fecha,
    String? detalles,
    int? usuarioId,
  }) {
    return MovimientoModel(
      id: id ?? this.id,
      firebaseId: firebaseId ?? this.firebaseId,
      productoId: productoId ?? this.productoId,
      tipo: tipo ?? this.tipo,
      cantidad: cantidad ?? this.cantidad,
      fecha: fecha ?? this.fecha,
      detalles: detalles ?? this.detalles,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  factory MovimientoModel.fromFirestore(
    Map<String, dynamic> map,
    String docId,
  ) {
    return MovimientoModel(
      firebaseId: docId,
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()),
      productoId:
          map['productoId'] is int
              ? map['productoId']
              : int.tryParse(map['productoId'].toString()) ?? 0,
      tipo: map['tipo'] ?? '',
      cantidad:
          map['cantidad'] is int
              ? map['cantidad']
              : int.tryParse(map['cantidad'].toString()) ?? 0,
      fecha:
          map['fecha'] is Timestamp
              ? (map['fecha'] as Timestamp).toDate()
              : DateTime.tryParse(map['fecha'].toString()) ?? DateTime.now(),
      detalles: map['observacion'] ?? '',
      usuarioId:
          map['usuarioId'] is int
              ? map['usuarioId']
              : int.tryParse(map['usuarioId'].toString()) ?? 0,
    );
  }

  factory MovimientoModel.fromMap(Map<String, dynamic> map) => MovimientoModel(
    id: map['id'],
    productoId: map['productoId'],
    tipo: map['tipo'],
    cantidad: map['cantidad'],
    fecha: DateTime.parse(map['fecha']),
    detalles: map['observacion'],
    usuarioId: map['usuarioId'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'productoId': productoId,
    'tipo': tipo,
    'cantidad': cantidad,
    'fecha': fecha.toIso8601String(),
    'observacion': detalles,
    'usuarioId': usuarioId,
  };

  factory MovimientoModel.fromMovimiento(Movimiento movimiento) {
    return MovimientoModel(
      id: movimiento.id,
      firebaseId: movimiento.firebaseId,
      productoId: movimiento.productoId,
      tipo: movimiento.tipo,
      cantidad: movimiento.cantidad,
      fecha: movimiento.fecha,
      detalles: movimiento.detalles,
      usuarioId: movimiento.usuarioId,
    );
  }
}
