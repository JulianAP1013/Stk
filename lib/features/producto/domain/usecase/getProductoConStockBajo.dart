import '../entities/producto.dart';
import '../repository/producto_Repository.dart';

class Getproductoconstockbajo {
  final ProductoRepository repo;
  Getproductoconstockbajo(this.repo);
  Future<List<Producto>> call(int usuarioId) =>
      repo.getProductosConStockBajo(usuarioId);
}
