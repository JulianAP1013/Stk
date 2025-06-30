import '../repository/usuarioRepository.dart';
import '../entities/usuario.dart';

class Deleteusuario {
  UsuarioRepository repo;
  Deleteusuario(this.repo);

  Future<void> call(int id) => repo.deleteUsuario(id);
}
