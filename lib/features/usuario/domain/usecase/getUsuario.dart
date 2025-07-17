import '../repository/usuarioRepository.dart';
import '../entities/usuario.dart';

class Getusuario {
  UsuarioRepository repo;
  Getusuario(this.repo);

  Future<Usuario> call(String email, String password) =>
      repo.getUsuario(email, password);
}
