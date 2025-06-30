import '../repository/movimientoRepository.dart';
import '../entities/movimiento.dart';

class Getmovimiento {
  final Movimientorepository repo;
  Getmovimiento(this.repo);

  Future<List<Movimiento>> call(int usuarioId) =>
      repo.getMovimientos(usuarioId);
}
