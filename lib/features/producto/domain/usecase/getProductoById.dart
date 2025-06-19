import '../entities/producto.dart';
import '../repository/producto_Repository_Impl.dart';

class Getproductobyid {
  final ProductoRepositoryImpl repo;
  Getproductobyid(this.repo);
  Future<Producto> call(int id, int usuarioId) => repo.getProductoById(id, usuarioId);
}