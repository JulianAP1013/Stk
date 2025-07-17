import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/producto_model.dart';
import '../productoDatasource.dart';

class ProductoFirebaseDatasourceImpl implements Productodatasource {
  final FirebaseFirestore firestore;

  ProductoFirebaseDatasourceImpl(this.firestore);

  @override
  Future<int> insertProducto(ProductoModel producto) async {
    final docRef = firestore.collection('productos').doc();

    final int generatedId = DateTime.now().millisecondsSinceEpoch;

    final productoConId = producto.copyWith(id: generatedId);

    await docRef.set({...productoConId.toMap(), 'firebaseId': docRef.id});

    return 1;
  }

  @override
  Future<List<ProductoModel>> getProductos(int usuarioId) async {
    final querySnapshot =
        await firestore
            .collection('productos')
            .where('usuarioId', isEqualTo: usuarioId)
            .get();

    return querySnapshot.docs
        .map((doc) => ProductoModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<ProductoModel>> getProductosConStockBajo(int usuarioId) async {
    final querySnapshot =
        await firestore
            .collection('productos')
            .where('usuarioId', isEqualTo: usuarioId)
            .get();

    return querySnapshot.docs
        .map((doc) => ProductoModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<ProductoModel> getProductoById(int id, int usuarioId) async {
    final querySnapshot =
        await firestore
            .collection('productos')
            .where('usuarioId', isEqualTo: usuarioId)
            .where('id', isEqualTo: id)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      return ProductoModel.fromFirestore(doc.data(), doc.id);
    } else {
      throw Exception('Producto no encontrado');
    }
  }

  @override
  Future<int> updateProducto(ProductoModel producto) async {
    final querySnapshot =
        await firestore
            .collection('productos')
            .where('id', isEqualTo: producto.id)
            .where('usuarioId', isEqualTo: producto.usuarioId)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await firestore
          .collection('productos')
          .doc(docId)
          .update(producto.toMap());
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Future<int> deleteProducto(int id, int usuarioId) async {
    final querySnapshot =
        await firestore
            .collection('productos')
            .where('usuarioId', isEqualTo: usuarioId)
            .where('id', isEqualTo: id)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await firestore.collection('productos').doc(docId).delete();
      return 1;
    } else {
      return 0;
    }
  }
}
