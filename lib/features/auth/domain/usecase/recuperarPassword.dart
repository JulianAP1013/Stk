import '../../../usuario/domain/entities/usuario.dart';
import '../../data/datasource/authDatasource.dart';

class Recuperarpassword {
  final Authdatasource repo;
  Recuperarpassword(this.repo);

  Future<bool> call(String email, String newPassword) {
    return repo.recuperarPassword(email, newPassword);
  }
}
