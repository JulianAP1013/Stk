import 'package:sqflite/sqflite.dart';
import 'productoDatasource.dart';
import 'package:app/features/producto/data/models/producto_model.dart';

class ProtuctoDatasourceImpl implements Productodatasource {
  final Database db;
  ProtuctoDatasourceImpl(this.db);

  @override
  //Funcion para insetar un producto
  Future<int> insertProducto(ProductoModel producto) async {
    return await db.insert('productos', producto.toMap());
  }

  @override
  //Funcion para obtener todos los productos de un usuario
  Future<List<ProductoModel>> getProductos(int usuarioId) async {
    final result = await db.query(
      'productos',
      where: 'usuarioId = ?',
      whereArgs: [usuarioId],
    );
    return result.map((e) => ProductoModel.fromMap(e)).toList();
  }

  @override
  //Funcion para obtener productos con stock bajo
  Future<List<ProductoModel>> getProductosConStockBajo(int usuarioId) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'productos',
      where: 'usuarioId = ? AND stock <= umbral_stock_bajo',
      whereArgs: [usuarioId],
    );
    return List.generate(maps.length, (i) {
      return ProductoModel.fromMap(maps[i]);
    });
    /* final result = await db.query(
      'productos',
      where: 'usuarioId = ? AND cantidad <= umbralStockBajo',
      whereArgs: [usuarioId],
    );
    return result.map((e) => ProductoModel.fromMap(e)).toList(); */
  }

  @override
  //Funcion para obtener un producto por su id
  Future<ProductoModel> getProductoById(int id, int usuarioId) async {
    final result = await db.query(
      'productos',
      where: 'id = ? AND usuarioId = ?',
      whereArgs: [id, usuarioId],
    );

    if (result.isNotEmpty) {
      return ProductoModel.fromMap(result.first);
    } else {
      throw Exception('Producto no encontrado');
    }
  }

  //Funcion para actualizar un producto
  @override
  Future<int> updateProducto(ProductoModel producto) async {
    return await db.update(
      'productos',
      producto.toMap(),
      where: 'id = ? AND usuarioId = ?',
      whereArgs: [producto.id, producto.usuarioId],
    );
  }

  //Funcion para eliminar un producto
  @override
  Future<int> deleteProducto(int id, int usuarioId) async {
    return await db.delete(
      'productos',
      where: 'id = ? AND usuarioId = ?',
      whereArgs: [id, usuarioId],
    );
  }
}
