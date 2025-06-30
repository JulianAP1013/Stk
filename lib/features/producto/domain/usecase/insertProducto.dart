import '../entities/producto.dart';
import '../repository/producto_Repository.dart';

class InsertProducto {
  final ProductoRepository repo;
  InsertProducto(this.repo);
  Future<void> call(Producto producto) => repo.insertProducto(producto);
}
