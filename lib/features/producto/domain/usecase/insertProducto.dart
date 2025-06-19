import '../entities/producto.dart';
import '../repository/producto_Repository_Impl.dart';

class InsertProducto {
  final ProductoRepositoryImpl repo;
  InsertProducto(this.repo);
  Future<void> call(Producto producto) => repo.insertProducto(producto);
}