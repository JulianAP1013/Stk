import '../repository/usuarioRepository.dart';
import '../entities/usuario.dart';

class Insertusuario {
  UsuarioRepository repo;
  Insertusuario(this.repo);

  Future<void> call(Usuario usuario) => repo.insertUsuario(usuario);
}
