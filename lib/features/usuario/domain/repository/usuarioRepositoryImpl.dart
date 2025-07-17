import '../entities/usuario.dart';
import 'usuarioRepository.dart';
import '../../data/models/usuario_model.dart';
import '../../data/datasource/usuarioDatasource.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final Usuariodatasource datasource;

  UsuarioRepositoryImpl(this.datasource);

  @override
  Future<void> insertUsuario(Usuario usuario) async {
    await datasource.insertUsuario(UsuarioModel.fromUsuario(usuario));
  }

  @override
  Future<Usuario> getUsuario(String email, String password) async {
    final usuarioModel = await datasource.getUsuario(email, password);
    if (usuarioModel == null) {
      throw Exception('Usuario no encontrado');
    }
    return usuarioModel;
  }

  @override
  Future<void> updateUsuario(Usuario usuario) async {
    await datasource.updateUsuario(UsuarioModel.fromUsuario(usuario));
  }

  @override
  Future<void> deleteUsuario(int id) async {
    await datasource.deleteUsuario(id);
  }
}
