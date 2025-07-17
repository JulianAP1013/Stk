import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/movimiento_model.dart';
import '../movimientoDatasource.dart';

class MovimientoFirebaseDatasourceImpl implements Movimientodatasource {
  final FirebaseFirestore firestore;

  MovimientoFirebaseDatasourceImpl(this.firestore);

  @override
  Future<int> insertMovimiento(MovimientoModel movimiento) async {
    final docRef = await firestore
        .collection('movimientos')
        .add(movimiento.toMap());

    // Firebase genera un ID string, pero mantenemos retorno int para compatibilidad
    return docRef.id.hashCode;
  }

  @override
  Future<List<MovimientoModel>> getMovimientos(int usuarioId) async {
    final snapshot =
        await firestore
            .collection('movimientos')
            .where('usuarioId', isEqualTo: usuarioId)
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              MovimientoModel.fromMap(doc.data()..['id'] = doc.id.hashCode),
        )
        .toList();
  }

  @override
  Future<MovimientoModel> getMovimientosById(int id, int usuarioId) async {
    final snapshot =
        await firestore
            .collection('movimientos')
            .where('usuarioId', isEqualTo: usuarioId)
            .get();

    final doc = snapshot.docs.firstWhere(
      (doc) => doc.id.hashCode == id,
      orElse: () => throw Exception('Movimiento no encontrado'),
    );

    return MovimientoModel.fromMap(doc.data()..['id'] = doc.id.hashCode);
  }

  @override
  Future<int> updateMovimiento(MovimientoModel movimiento) async {
    final snapshot =
        await firestore
            .collection('movimientos')
            .where('usuarioId', isEqualTo: movimiento.usuarioId)
            .get();

    final doc = snapshot.docs.firstWhere(
      (doc) => doc.id.hashCode == movimiento.id,
      orElse: () => throw Exception('Movimiento no encontrado para actualizar'),
    );

    await firestore
        .collection('movimientos')
        .doc(doc.id)
        .update(movimiento.toMap());

    return 1; // Simula éxito como SQLite
  }

  @override
  Future<int> deleteMovimiento(int id, int usuarioId) async {
    final snapshot =
        await firestore
            .collection('movimientos')
            .where('usuarioId', isEqualTo: usuarioId)
            .get();

    final doc = snapshot.docs.firstWhere(
      (doc) => doc.id.hashCode == id,
      orElse: () => throw Exception('Movimiento no encontrado para eliminar'),
    );

    await firestore.collection('movimientos').doc(doc.id).delete();

    return 1; // Simula éxito
  }
}
