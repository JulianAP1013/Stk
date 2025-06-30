import '../repository/movimientoRepository.dart';
import '../entities/movimiento.dart';

class Updatemovimiento {
  final Movimientorepository repo;
  Updatemovimiento(this.repo);

  Future<void> call(Movimiento movimiento) => repo.updateMovimiento(movimiento);
}
