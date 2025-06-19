import 'package:app/features/producto/data/models/producto_model.dart';

abstract class Productodatasource {
  Future<List<ProductoModel>> getProductos(int usuarioId);
  Future<int> insertProducto(ProductoModel producto);
  Future<List<ProductoModel>> getProductosConStockBajo(int usuarioId);
  Future<ProductoModel> getProductoById(int id, int usuarioId);
  Future<int> updateProducto(ProductoModel producto);
  Future<int> deleteProducto(int id, int usuarioId);
}
