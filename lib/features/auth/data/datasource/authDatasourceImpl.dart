import 'package:sqflite/sqflite.dart';
import '../../../usuario/data/models/usuario_model.dart';
import 'authDatasource.dart';

class Authdatasourceimpl implements Authdatasource {
  final Database db;
  Authdatasourceimpl(this.db);

  @override
  Future<UsuarioModel?> login(String email, String password) async {
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
  Future<int> register(UsuarioModel usuario) async {
    return await db.insert('usuarios', usuario.toMap());
  }

  @override
  Future<bool> recuperarPassword(String email, String newPassword) async {
    final count = await db.update(
      'usuarios',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
    return count > 0;
  }

  @override
  Future<void> logout() async {
    //Falta agregar logica para cerrar sesion
  }
}
