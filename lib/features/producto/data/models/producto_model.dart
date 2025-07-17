import 'package:app/features/producto/domain/entities/producto.dart';
import '../../domain/entities/producto.dart';

class ProductoModel extends Producto {
  final String? firebaseId;
  ProductoModel({
    int? id,
    this.firebaseId,
    required String nombre,
    required String descripcion,
    required double precio,
    required String categoria,
    required int stock,
    required int umbralStockBajo,
    required int usuarioId,
  }) : super(
         id: id,
         firebaseId: firebaseId,
         nombre: nombre,
         descripcion: descripcion,
         precio: precio,
         categoria: categoria,
         stock: stock,
         umbralStockBajo: umbralStockBajo,
         usuarioId: usuarioId,
       );

  ProductoModel copyWith({
    int? id,
    String? nombre,
    String? despcripcion,
    double? precio,
    String? categoria,
    int? stock,
    int? umbralStockBajo,
    int? usuarioId,
  }) {
    return ProductoModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      categoria: categoria ?? this.categoria,
      stock: stock ?? this.stock,
      umbralStockBajo: umbralStockBajo ?? this.umbralStockBajo,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

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
      firebaseId: producto.firebaseId,
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

  factory ProductoModel.fromFirestore(Map<String, dynamic> map, String docId) {
    return ProductoModel(
      firebaseId: docId,
      id: map['id'] is int ? map['id'] : int.tryParse(map['id'].toString()),
      nombre: map['nombre'] ?? '',
      descripcion: map['descripcion'] ?? '',
      precio:
          (map['precio'] is double)
              ? map['precio']
              : double.tryParse(map['precio'].toString()) ?? 0.0,
      categoria: map['categoria'] ?? '',
      stock: map['stock'] ?? 0,
      umbralStockBajo: map['umbral_stock_bajo'] ?? 0,
      usuarioId: map['usuarioId'] ?? 0,
    );
  }

  @override
  String toString() =>
      'ProductoModel(id: $id, usuarioId: $usuarioId, nombre: $nombre)';
}
