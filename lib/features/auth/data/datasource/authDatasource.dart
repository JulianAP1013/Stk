import '../../../usuario/data/models/usuario_model.dart';

abstract class Authdatasource {
  Future<UsuarioModel?> login(String email, String password);
  Future<int> register(UsuarioModel usuario);
  Future<bool> recuperarPassword(String email, String newpassword);
  Future<void> logout();
}
