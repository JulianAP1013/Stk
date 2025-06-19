import '../entities/producto.dart';
import '../repository/producto_Repository_Impl.dart';

class Getproductoconstockbajo {
  final ProductoRepositoryImpl repo;
  Getproductoconstockbajo(this.repo);
  Future<List<Producto>> call(int usuarioId) => repo.getProductosConStockBajo(usuarioId);
}