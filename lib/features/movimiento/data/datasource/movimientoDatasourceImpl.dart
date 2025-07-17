import 'package:sqflite/sqflite.dart';
import 'movimientoDatasource.dart';
import '../models/movimiento_model.dart';

class Movimientodatasourceimpl implements Movimientodatasource {
  final Database db;
  Movimientodatasourceimpl(this.db);

  @override
  Future<int> insertMovimiento(MovimientoModel movimiento) async {
    return await db.insert('movimientos', movimiento.toMap());
  }

  @override
  Future<List<MovimientoModel>> getMovimientos(int usuarioId) async {
    final result = await db.query(
      'movimientos',
      where: 'usuarioId = ?',
      whereArgs: [usuarioId],
    );
    return result.map((e) => MovimientoModel.fromMap(e)).toList();
  }

  @override
  Future<MovimientoModel> getMovimientosById(int id, int usuarioId) async {
    final result = await db.query(
      'movimientos',
      where: 'id = ? AND usuarioId = ?',
      whereArgs: [id, usuarioId],
    );
    return MovimientoModel.fromMap(result.first);
  }

  @override
  Future<int> updateMovimiento(MovimientoModel movimiento) async {
    return await db.update(
      'movimientos',
      movimiento.toMap(),
      where: 'id = ? AND usuarioId = ?',
      whereArgs: [movimiento.id, movimiento.usuarioId],
    );
  }

  @override
  Future<int> deleteMovimiento(int id, int usuarioId) async {
    return await db.delete(
      'movimientos',
      where: 'id = ? AND usuarioId = ?',
      whereArgs: [id, usuarioId],
    );
  }
}
