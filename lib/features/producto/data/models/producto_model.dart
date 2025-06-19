import 'package:app/features/producto/domain/entities/producto.dart';

class ProductoModel extends Producto {
  ProductoModel({
    required int id,
    required String nombre,
    required String descripcion,
    required double precio,
    required String categoria,
    required int umbralStockBajo,
    required int usuarioId,
  }) : super(
         id: id,
         nombre: nombre,
         descripcion: descripcion,
         precio: precio,
         categoria: categoria,
         umbralStockBajo: umbralStockBajo,
         usuarioId: usuarioId,
       );

  factory ProductoModel.fromMap(Map<String, dynamic> map) {
    return ProductoModel(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      precio: map['precio'],
      categoria: map['categoria'],
      umbralStockBajo: map['umbral_stock_bajo'],
      usuarioId: map['usuario_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'categoria': categoria,
      'umbral_stock_bajo': umbralStockBajo,
      'usuario_id': usuarioId,
    };
  }
}
