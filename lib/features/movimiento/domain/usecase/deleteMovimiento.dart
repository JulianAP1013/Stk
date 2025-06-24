import '../repository/movimientoRepositoryImpl.dart';

class Deletemovimiento {
  final Movimientorepositoryimpl repo;
  Deletemovimiento(this.repo);

  Future<void> call(int id, int usuarioId) =>
      repo.deleteMovimiento(id, usuarioId);
}
