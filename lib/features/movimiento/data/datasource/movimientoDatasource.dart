import 'package:app/features/movimiento/data/models/movimiento_model.dart';

abstract class Movimientodatasource {
  Future<int> insertMovimiento(MovimientoModel movimiento);
  Future<List<MovimientoModel>> getMovimientos(int usuarioId);
  Future<MovimientoModel> getMovimientosById(int id, int usuarioId);
  Future<int> updateMovimiento(MovimientoModel movimiento);
  Future<int> deleteMovimiento(int id, int usuarioId);
}
