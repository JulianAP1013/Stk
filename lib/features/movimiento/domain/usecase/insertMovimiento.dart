import '../repository/movimientoRepository.dart';
import '../entities/movimiento.dart';

class Insertmovimiento {
  final Movimientorepository repo;
  Insertmovimiento(this.repo);

  Future<void> call(Movimiento movimiento) => repo.insertMovimiento(movimiento);
}
