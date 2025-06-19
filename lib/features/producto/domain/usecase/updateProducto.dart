import '../entities/producto.dart';
import '../repository/producto_Repository_Impl.dart';

class Updateproducto {
  final ProductoRepositoryImpl repo;
  Updateproducto(this.repo);
  Future<void> call(Producto producto) => repo.updateProducto(producto);
}