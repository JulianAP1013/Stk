import '../entities/producto.dart';
import '../repository/producto_Repository.dart';

class Getproductobyid {
  final ProductoRepository repo;
  Getproductobyid(this.repo);
  Future<Producto> call(int id, int usuarioId) =>
      repo.getProductoById(id, usuarioId);
}
