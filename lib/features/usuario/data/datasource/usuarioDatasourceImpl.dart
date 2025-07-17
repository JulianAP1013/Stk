import 'package:sqflite/sqflite.dart';
import 'usuarioDatasource.dart';
import '../models/usuario_model.dart';

class Usuariodatasourceimpl implements Usuariodatasource {
  final Database db;
  Usuariodatasourceimpl(this.db);

  @override
  Future<int> insertUsuario(UsuarioModel usuario) async {
    return await db.insert('usuarios', usuario.toMap());
  }

  @override
  Future<UsuarioModel?> getUsuario(String email, String password) async {
    final result = await db.query(
      'usuarios',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return UsuarioModel.fromMap(result.first);
    }
    return null;
  }

  @override
  Future<int> updateUsuario(UsuarioModel usuario) async {
    return await db.update(
      'usuarios',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  @override
  Future<int> deleteUsuario(int id) async {
    return await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }
}
