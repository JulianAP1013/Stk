import '../repository/movimientoRepository.dart';
import '../entities/movimiento.dart';

class Getmovimientobyid {
  final Movimientorepository repo;
  Getmovimientobyid(this.repo);

  Future<Movimiento> call(int id, int usuarioId) =>
      repo.getMovimientosById(id, usuarioId);
}
