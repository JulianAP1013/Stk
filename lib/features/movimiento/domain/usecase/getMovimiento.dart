import '../repository/movimientoRepositoryImpl.dart';
import '../entities/movimiento.dart';

class Getmovimiento {
  final Movimientorepositoryimpl repo;
  Getmovimiento(this.repo);

  Future<List<Movimiento>> call(int usuarioId) =>
      repo.getMovimientos(usuarioId);
}
