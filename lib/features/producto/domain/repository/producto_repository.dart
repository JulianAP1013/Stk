import 'package:app/features/producto/domain/entities/producto.dart';

abstract class ProductoRepository {
  Future<List<Producto>> getProductos(int usuariosId);
  Future<void> insertProducto(Producto producto);
  Future<List<Producto>> getProductosConStockBajo(int usuarioId);
  Future<Producto> getProductoById(int id, int usuarioId);
  Future<void> updateProducto(Producto producto);
  Future<void> deleteProducto(int id, int usuarioId);
}
