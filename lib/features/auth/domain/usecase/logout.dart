import '../../../usuario/domain/entities/usuario.dart';
import '../../data/datasource/authDatasource.dart';

class Logout {
  final Authdatasource repo;
  Logout(this.repo);

  Future<void> call() {
    return repo.logout();
  }
}
