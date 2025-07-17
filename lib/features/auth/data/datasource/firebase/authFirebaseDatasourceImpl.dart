import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../usuario/data/models/usuario_model.dart';
import '../authDatasource.dart';

class Authfirebasedatasourceimpl implements Authdatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore;
  Authfirebasedatasourceimpl(this._firebaseAuth, this.firestore);

  @override
  Future<UsuarioModel?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        return UsuarioModel(
          id: 0,
          nombre: user.displayName ?? '',
          email: user.email ?? '',
          password: '', // No se expone
        );
      }
      return null;
    } catch (e) {
      print('Error al iniciar sesión: $e');
      rethrow; // Lanza el error para verlo en consola
      return null;
    }
  }

  @override
  Future<int> register(UsuarioModel usuario) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.password,
      );

      final user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(usuario.nombre);

        // Solo guarda nombre y correo (NO la contraseña)
        await firestore.collection('usuarios').doc(user.uid).set({
          'nombre': usuario.nombre,
          'email': usuario.email,
        });

        return 1;
      }
      return 0;
    } catch (e) {
      print('Error en register: $e');
      return 0;
    }
  }

  @override
  Future<bool> recuperarPassword(String email, String newPassword) async {
    try {
      // FirebaseAuth no permite cambiar la contraseña sin autenticación.
      // Normalmente se envía un correo de recuperación:
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
