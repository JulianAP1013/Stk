import 'package:app/features/producto/domain/entities/producto.dart';
import '../../domain/entities/producto.dart';

class ProductoModel extends Producto {
  ProductoModel({
    int? id,
    required String nombre,
    required String descripcion,
    required double precio,
    required String categoria,
    required int stock,
    required int umbralStockBajo,
    required int usuarioId,
  }) : super(
         id: id,
         nombre: nombre,
         descripcion: descripcion,
         precio: precio,
         categoria: categoria,
         stock: stock,
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
      stock: map['stock'],
      umbralStockBajo: map['umbral_stock_bajo'],
      usuarioId: map['usuarioId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'categoria': categoria,
      'stock': stock,
      'umbral_stock_bajo': umbralStockBajo,
      'usuarioId': usuarioId,
    };
  }

  factory ProductoModel.fromProducto(Producto producto) {
    return ProductoModel(
      id: producto.id,
      nombre: producto.nombre,
      descripcion: producto.descripcion,
      stock: producto.stock,
      precio: producto.precio,
      categoria: producto.categoria,
      umbralStockBajo: producto.umbralStockBajo,
      usuarioId: producto.usuarioId,
    );
  }
}
