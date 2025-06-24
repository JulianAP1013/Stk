import '../repository/usuarioRepositoryImpl.dart';
import '../entities/usuario.dart';

class Getusuario {
  UsuarioRepositoryImpl repo;
  Getusuario(this.repo);

  Future<Usuario> call(String email, String password) =>
      repo.getUsuario(email, password);
}
