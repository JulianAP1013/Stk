import '../repository/usuarioRepositoryImpl.dart';
import '../entities/usuario.dart';

class Deleteusuario {
  UsuarioRepositoryImpl repo;
  Deleteusuario(this.repo);

  Future<void> call(int id) => repo.deleteUsuario(id);
}
