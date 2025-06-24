import '../../domain/entities/producto.dart';
import '../../domain/repository/producto_repository.dart';
import 'package:app/features/producto/data/datasource/productoDatasource.dart';
import 'package:app/features/producto/data/models/producto_model.dart';

class ProductoRepositoryImpl implements ProductoRepository {
  final Productodatasource datasource;

  ProductoRepositoryImpl(this.datasource);

  @override
  Future<List<Producto>> getProductos(int usuarioId) =>
      datasource.getProductos(usuarioId);

  @override
  Future<void> insertProducto(Producto producto) =>
      datasource.insertProducto(producto as ProductoModel);

  @override
  Future<List<Producto>> getProductosConStockBajo(int usuarioId) =>
      datasource.getProductosConStockBajo(usuarioId);

  @override
  Future<Producto> getProductoById(int id, int usuarioId) =>
      datasource.getProductoById(id, usuarioId);

  @override
  Future<void> updateProducto(Producto producto) =>
      datasource.updateProducto(producto as ProductoModel);

  @override
  Future<void> deleteProducto(int id, int usuarioId) =>
      datasource.deleteProducto(id, usuarioId);
}
