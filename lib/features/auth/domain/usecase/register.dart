import '../../../usuario/domain/entities/usuario.dart';
import '../../data/datasource/authDatasource.dart';
import '../../../usuario/data/models/usuario_model.dart';

class Register {
  final Authdatasource repo;
  Register(this.repo);

  Future<void> call(Usuario usuario) {
    final usuarioModel = UsuarioModel(
      id: usuario.id,
      nombre: usuario.nombre,
      email: usuario.email,
      password: usuario.password,
    );
    return repo.register(usuarioModel);
  }
}
