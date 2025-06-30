import '../entities/producto.dart';
import '../repository/producto_Repository.dart';

class Getproducto {
  final ProductoRepository repo;
  Getproducto(this.repo);
  Future<List<Producto>> call(int usuarioId) => repo.getProductos(usuarioId);
}
