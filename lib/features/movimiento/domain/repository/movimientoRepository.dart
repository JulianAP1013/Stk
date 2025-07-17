import '../entities/movimiento.dart';

abstract class Movimientorepository {
  Future<void> insertMovimiento(Movimiento movimiento);
  Future<List<Movimiento>> getMovimientos(int usuarioId);
  Future<Movimiento> getMovimientosById(int id, int usuarioId);
  Future<void> updateMovimiento(Movimiento movimiento);
  Future<void> deleteMovimiento(int id, int usuarioId);
}
