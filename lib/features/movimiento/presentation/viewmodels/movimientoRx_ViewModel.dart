import 'package:rxdart/rxdart.dart';
import '../../domain/entities/movimiento.dart';
import '../../domain/usecase/deleteMovimiento.dart';
import '../../domain/usecase/getMovimiento.dart';
import '../../domain/usecase/getMovimientoById.dart';
import '../../domain/usecase/insertMovimiento.dart';
import '../../domain/usecase/updateMovimiento.dart';

class MovimientorxViewmodel {
  final Insertmovimiento _insertmovimiento;
  final Getmovimiento _getmovimiento;
  final Getmovimientobyid _getmovimientobyid;
  final Deletemovimiento _deleteMovimiento;
  final Updatemovimiento _updateMovimiento;

  MovimientorxViewmodel(
    this._insertmovimiento,
    this._getmovimiento,
    this._getmovimientobyid,
    this._deleteMovimiento,
    this._updateMovimiento,
  );

  /* STREAM */
  final _movimientoSubject = BehaviorSubject<List<Movimiento>>();
  Stream<List<Movimiento>> get movimientoStream => _movimientoSubject.stream;
  /* ACCION */
  Future<void> insertMovimiento(Movimiento movimiento) async {
    await _insertmovimiento(movimiento);
    await getMovimiento(movimiento.usuarioId);
  }

  Future<List<Movimiento>> getMovimiento(int usuarioId) async {
    final movimientos = await _getmovimiento(usuarioId);
    _movimientoSubject.add(movimientos);
    return movimientos;
  }

  Future<Movimiento> getMovimientoById(int id, usuarioId) async {
    final movimientos = await _getmovimientobyid(id, usuarioId);
    return movimientos;
  }

  Future<void> deleteMovimiento(int id, int usuarioId) async {
    await _deleteMovimiento(id, usuarioId);
    await getMovimiento(usuarioId);
  }

  Future<void> updateMovimiento(Movimiento movimiento) async {
    await _updateMovimiento(movimiento);
    await getMovimiento(movimiento.usuarioId);
  }
  /* LIMPIEZA */

  void dispose() {
    _movimientoSubject.close();
  }
}
