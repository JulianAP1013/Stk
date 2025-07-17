import '../models/usuario_model.dart';

abstract class Usuariodatasource {
  Future<int> insertUsuario(UsuarioModel usuario);
  Future<UsuarioModel?> getUsuario(String email, String password);
  Future<int> updateUsuario(UsuarioModel usuario);
  Future<int> deleteUsuario(int id);
}
