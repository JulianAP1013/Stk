import '../entities/movimiento.dart';
import '../repository/movimientoRepository.dart';
import '../../data/models/movimiento_model.dart';
import '../../data/datasource/movimientoDatasource.dart';

class Movimientorepositoryimpl implements Movimientorepository {
  final Movimientodatasource datasource;
  Movimientorepositoryimpl(this.datasource);

  @override
  Future<void> insertMovimiento(Movimiento movimiento) =>
      datasource.insertMovimiento(MovimientoModel.fromMovimiento(movimiento));

  @override
  Future<List<Movimiento>> getMovimientos(int usuarioId) =>
      datasource.getMovimientos(usuarioId);

  @override
  Future<Movimiento> getMovimientosById(int id, int usuarioId) =>
      datasource.getMovimientosById(id, usuarioId);

  @override
  Future<void> updateMovimiento(Movimiento movimiento) =>
      datasource.updateMovimiento(MovimientoModel.fromMovimiento(movimiento));

  @override
  Future<void> deleteMovimiento(int id, int usuarioId) =>
      datasource.deleteMovimiento(id, usuarioId);
}
