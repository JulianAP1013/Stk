import '../../data/datasource/authDatasource.dart';
import '../../../usuario/domain/entities/usuario.dart';
import '../../../usuario/data/models/usuario_model.dart';
import 'authRepository.dart';

class Authrepositoryimpl implements Authrepository {
  final Authdatasource datasource;
  Authrepositoryimpl(this.datasource);

  @override
  Future<Usuario?> login(String email, String password) async {
    final userModel = await datasource.login(email, password);
    return userModel;
  }

  @override
  Future<int> register(Usuario usuario) async {
    return await datasource.register(
      UsuarioModel(
        id: usuario.id,
        nombre: usuario.nombre,
        email: usuario.email,
        password: usuario.password,
      ),
    );
  }

  @override
  Future<bool> recuperarPassword(String email, String newPassword) {
    return datasource.recuperarPassword(email, newPassword);
  }

  @override
  Future<void> logout() {
    return datasource.logout();
  }
}
