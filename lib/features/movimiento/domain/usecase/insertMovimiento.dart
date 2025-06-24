import '../repository/movimientoRepositoryImpl.dart';
import '../entities/movimiento.dart';

class Insertmovimiento {
  final Movimientorepositoryimpl repo;
  Insertmovimiento(this.repo);

  Future<void> call(Movimiento movimiento) => repo.insertMovimiento(movimiento);
}
