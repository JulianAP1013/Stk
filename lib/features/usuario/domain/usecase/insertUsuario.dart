import '../repository/usuarioRepositoryImpl.dart';
import '../entities/usuario.dart';

class Insertusuario {
  UsuarioRepositoryImpl repo;
  Insertusuario(this.repo);

  Future<void> call(Usuario usuario) => repo.insertUsuario(usuario);
}
