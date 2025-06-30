import '../entities/producto.dart';
import '../repository/producto_Repository.dart';

class Updateproducto {
  final ProductoRepository repo;
  Updateproducto(this.repo);
  Future<void> call(Producto producto) => repo.updateProducto(producto);
}
