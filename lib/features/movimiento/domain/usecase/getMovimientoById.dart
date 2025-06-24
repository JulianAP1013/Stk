import '../repository/movimientoRepositoryImpl.dart';
import '../entities/movimiento.dart';

class Getmovimientobyid {
  final Movimientorepositoryimpl repo;
  Getmovimientobyid(this.repo);

  Future<Movimiento> call(int id, int usuarioId) =>
      repo.getMovimientosById(id, usuarioId);
}
