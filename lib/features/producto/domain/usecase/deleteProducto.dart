
import '../repository/producto_Repository_Impl.dart';

class Deleteproducto {
  final ProductoRepositoryImpl repo;
  Deleteproducto(this.repo);
  Future<void> call(int id, int usuarioId) => repo.deleteProducto(id, usuarioId);
}