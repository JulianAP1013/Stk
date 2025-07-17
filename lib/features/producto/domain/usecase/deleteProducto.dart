import '../repository/producto_Repository.dart';

class Deleteproducto {
  final ProductoRepository repo;
  Deleteproducto(this.repo);

  Future<void> call(int id, int usuarioId) =>
      repo.deleteProducto(id, usuarioId);
}
