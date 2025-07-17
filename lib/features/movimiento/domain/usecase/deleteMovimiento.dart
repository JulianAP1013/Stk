import '../repository/movimientoRepository.dart';

class Deletemovimiento {
  final Movimientorepository repo;
  Deletemovimiento(this.repo);

  Future<void> call(int id, int usuarioId) =>
      repo.deleteMovimiento(id, usuarioId);
}
