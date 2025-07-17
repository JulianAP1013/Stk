import '../../../usuario/domain/entities/usuario.dart';
import '../../data/datasource/authDatasource.dart';

class Login {
  final Authdatasource repo;
  Login(this.repo);

  Future<Usuario?> call(String email, String password) {
    return repo.login(email, password);
  }
}
