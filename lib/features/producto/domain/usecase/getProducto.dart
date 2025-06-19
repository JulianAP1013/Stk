import '../entities/producto.dart';
import '../repository/producto_Repository_Impl.dart';

class Getproducto {
  final ProductoRepositoryImpl repo;
  Getproducto(this.repo);
  Future<List<Producto>> call(int usuarioId) => repo.getProductos(usuarioId);
}