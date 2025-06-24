import '../entities/usuario.dart';

abstract class UsuarioRepository {
  Future<void> insertUsuario(Usuario usuario);
  Future<Usuario> getUsuario(String email, String password);
  Future<void> updateUsuario(Usuario usuario);
  Future<void> deleteUsuario(int id);
}
