import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/usuario_model.dart';
import '../usuarioDatasource.dart';

class UsuarioFirebaseDatasourceImpl implements Usuariodatasource {
  final FirebaseFirestore firestore;

  UsuarioFirebaseDatasourceImpl({FirebaseFirestore? firestoreInstance})
    : firestore = firestoreInstance ?? FirebaseFirestore.instance;

  @override
  Future<int> insertUsuario(UsuarioModel usuario) async {
    final docRef = firestore.collection('usuarios').doc(usuario.id.toString());

    await docRef.set(usuario.toMap());

    // En SQLite retornabas el ID, en Firestore podrías retornar 1 como éxito
    return 1;
  }

  @override
  Future<UsuarioModel?> getUsuario(String email, String password) async {
    final query =
        await firestore
            .collection('usuarios')
            .where('email', isEqualTo: email)
            .where('password', isEqualTo: password)
            .limit(1)
            .get();

    if (query.docs.isNotEmpty) {
      return UsuarioModel.fromMap(query.docs.first.data());
    }

    return null;
  }

  @override
  Future<int> updateUsuario(UsuarioModel usuario) async {
    try {
      await firestore
          .collection('usuarios')
          .doc(usuario.id.toString())
          .update(usuario.toMap());

      return 1;
    } catch (e) {
      return 0; // Si falla
    }
  }

  @override
  Future<int> deleteUsuario(int id) async {
    try {
      await firestore.collection('usuarios').doc(id.toString()).delete();
      return 1;
    } catch (e) {
      return 0;
    }
  }
}
