import '../repository/movimientoRepositoryImpl.dart';
import '../entities/movimiento.dart';

class Updatemovimiento {
  final Movimientorepositoryimpl repo;
  Updatemovimiento(this.repo);

  Future<void> call(Movimiento movimiento) => repo.updateMovimiento(movimiento);
}
