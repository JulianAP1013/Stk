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

  /// Stream que mantiene al usuario autenticado
  final _authUserSubject = BehaviorSubject<Usuario?>();
  Stream<Usuario?> get authUserStream => _authUserSubject.stream;

  /// Usuario actual (último valor del stream)
  Usuario? get usuarioActual => _authUserSubject.valueOrNull;

  /// ID del usuario actual (en Firebase sería el UID)
  int? get usuarioId => _authUserSubject.valueOrNull?.id;
  String? get firebaseId => _authUserSubject.valueOrNull?.uid;

  /// Inicia sesión con email y contraseña (FirebaseAuth)
  Future<void> login(String email, String password) async {
    try {
      final usuario = await _login(email, password); // Usa el UseCase
      if (usuario == null) {
        throw Exception('Correo o contraseña incorrectos');
      }
      _authUserSubject.add(usuario); // Emitimos el usuario en sesión
    } catch (e) {
      _authUserSubject.addError('Error al iniciar sesión: ${e.toString()}');
      rethrow;
    }
  }

  /// Registra un nuevo usuario (FirebaseAuth)
  Future<void> register(Usuario usuario) async {
    try {
      await _register(usuario); // Firebase crea usuario
      _authUserSubject.add(usuario); // Emitimos el nuevo usuario
    } catch (e) {
      _authUserSubject.addError('Error al registrar: ${e.toString()}');
      rethrow;
    }
  }

  /// Recupera contraseña (FirebaseAuth: sendPasswordResetEmail o updatePassword)
  Future<void> recuperarPassword(String email, String newPassword) async {
    try {
      await _recuperarpassword(email, newPassword);
    } catch (e) {
      _authUserSubject.addError(
        'Error al recuperar contraseña: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Cierra la sesión
  Future<void> logout() async {
    await _logout(); // FirebaseAuth.signOut()
    _authUserSubject.add(null); // Usuario fuera de sesión
  }

  /// Limpieza del stream
  void dispose() {
    _authUserSubject.close();
  }
}
