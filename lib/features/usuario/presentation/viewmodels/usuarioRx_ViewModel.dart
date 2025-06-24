import 'package:rxdart/rxdart.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/usecase/deleteUsuario.dart';
import '../../domain/usecase/getUsuario.dart';
import '../../domain/usecase/insertUsuario.dart';
import '../../domain/usecase/updateUsuario.dart';

class UsuariorxViewmodel {
  final Insertusuario _insertUsuario;
  final Getusuario _getusuario;
  final Updateusuario _updateusuario;
  final Deleteusuario _deleteusuario;

  UsuariorxViewmodel(
    this._insertUsuario,
    this._getusuario,
    this._updateusuario,
    this._deleteusuario,
  );

  /* STREAM */
  final _usuarioSubject = BehaviorSubject<List<Usuario>>();
  Stream<List<Usuario>> get usuarioStream => _usuarioSubject.stream;
  /* ACCION */
  Future<void> insertUsuario(Usuario usuario) async {
    await _insertUsuario(usuario);
    await getUsuario(usuario.email, usuario.password);
  }

  Future<Usuario> getUsuario(String email, String password) async {
    final usuario = await _getusuario(email, password);
    if (usuario != null) {
      _usuarioSubject.add([usuario]);
    } else {
      _usuarioSubject.add([]);
    }
    return usuario;
  }

  Future<void> updateUsuario(Usuario usuario) async {
    await _updateusuario(usuario);
    await getUsuario(usuario.email, usuario.password);
  }

  Future<void> deleteUsuario(int id) async {
    await _deleteusuario(id);
    _usuarioSubject.add([]);
  }

  /* LIMPIEZA */
  void dispose() {
    _usuarioSubject.close();
  }
}
