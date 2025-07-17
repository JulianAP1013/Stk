import 'package:rxdart/rxdart.dart';
import '../../domain/entities/producto.dart';
import '../../domain/usecase/deleteProducto.dart';
import '../../domain/usecase/getProducto.dart';
import '../../domain/usecase/getProductoById.dart';
import '../../domain/usecase/getProductoConStockBajo.dart';
import '../../domain/usecase/insertProducto.dart';
import '../../domain/usecase/updateProducto.dart';

class ProductorxViewmodel {
  final InsertProducto _insertproducto;
  final Getproducto _getproducto;
  final Getproductobyid _getproductobyid;
  final Getproductoconstockbajo _getproductoconstockbajo;
  final Deleteproducto _deleteproducto;
  final Updateproducto _updateproducto;

  ProductorxViewmodel(
    this._insertproducto,
    this._getproducto,
    this._getproductobyid,
    this._getproductoconstockbajo,
    this._deleteproducto,
    this._updateproducto,
  );

  /* STREAM */
  final _productoSubject = BehaviorSubject<List<Producto>>();
  Stream<List<Producto>> get productoStream => _productoSubject.stream;

  /* ACCION */
  Future<void> insertProducto(Producto producto) async {
    await _insertproducto(producto);
    await getProductos(producto.usuarioId);
  }

  Future<List<Producto>> getProductos(int usuarioId) async {
    final productos = await _getproducto(usuarioId);
    _productoSubject.add(List<Producto>.from(productos));
    return productos;
  }

  Future<Producto> getProductoById(int id, int usuarioId) async {
    final productos = await _getproductobyid(id, usuarioId);
    return productos;
  }

  Future<List<Producto>> getProductoConStockBajo(int usuarioId) async {
    final producto = await _getproductoconstockbajo(usuarioId);
    return producto.where((p) => p.stock <= p.umbralStockBajo).toList();
  }

  Future<void> deleteProducto(int id, int usuarioId) async {
    await _deleteproducto(id, usuarioId);
    await getProductos(usuarioId);
  }

  Future<void> updateProducto(Producto producto) async {
    await _updateproducto(producto);
    await getProductos(producto.usuarioId);
  }

  /* LIMPIEZA */

  void dispose() {
    _productoSubject.close();
  }
}
