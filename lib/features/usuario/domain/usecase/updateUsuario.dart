import '../repository/usuarioRepositoryImpl.dart';
import '../entities/usuario.dart';

class Updateusuario {
  UsuarioRepositoryImpl repo;
  Updateusuario(this.repo);

  Future<void> call(Usuario usuario) => repo.updateUsuario(usuario);
}
