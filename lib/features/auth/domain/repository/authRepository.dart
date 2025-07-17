import '../../../usuario/domain/entities/usuario.dart';

abstract class Authrepository {
  Future<Usuario?> login(String email, String password);
  Future<int> register(Usuario usuario);
  Future<bool> recuperarPassword(String email, String newPassword);
  Future<void> logout();
}
