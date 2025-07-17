import '../repository/usuarioRepository.dart';
import '../entities/usuario.dart';

class Updateusuario {
  UsuarioRepository repo;
  Updateusuario(this.repo);

  Future<void> call(Usuario usuario) => repo.updateUsuario(usuario);
}
