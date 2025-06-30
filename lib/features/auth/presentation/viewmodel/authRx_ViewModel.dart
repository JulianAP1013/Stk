import 'package:rxdart/rxdart.dart';
import '../../../usuario/domain/entities/usuario.dart';
import '../../domain/usecase/login.dart';
import '../../domain/usecase/logout.dart';
import '../../domain/usecase/recuperarPassword.dart';
import '../../domain/usecase/register.dart';

class AuthrxViewmodel {
  final Login _login;
  final Register _register;
  final Recuperarpassword _recuperarpassword;
  final Logout _logout;

  AuthrxViewmodel(
    this._login,
    this._logout,
    this._recuperarpassword,
    this._register,
  );

  /* STREAM */
  final _authUserSubject = BehaviorSubject<Usuario?>();
  Stream<Usuario?> get authUserStream => _authUserSubject.stream;

  //Geter para obtener el usuario Actual(Utimo valor del stream)
  Usuario? get usuarioActual => _authUserSubject.valueOrNull;

  //Getter para obtener el id del usuario actual
  int? get usuarioId => _authUserSubject.valueOrNull?.id;

  /* ACCION */
  Future<void> login(String email, String password) async {
    final usuario = await _login(email, password);
    if (usuario == null) {
      throw Exception('Correo o contraseña incorrectos');
    }
    _authUserSubject.add(usuario);
  }

  Future<void> register(Usuario usuario) async {
    await _register(usuario);
  }

  Future<void> recuperarPassword(String email, String newPassword) async {
    await _recuperarpassword(email, newPassword);
  }

  Future<void> logout() async {
    _authUserSubject.add(null);
  }
  /* LIMPIEZA */

  void dispose() {
    _authUserSubject.close();
  }
}
