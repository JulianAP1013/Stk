import '../../domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  UsuarioModel({
    String? uid,
    int? id,
    required String nombre,
    required String email,
    String password = '',
  }) : super(
         id: id,
         uid: uid,
         nombre: nombre,
         email: email,
         password: password,
       );

  /// Construir desde Firestore
  factory UsuarioModel.fromFirestore(Map<String, dynamic> map, String uid) {
    return UsuarioModel(
      uid: uid,
      nombre: map['nombre'] ?? '',
      email: map['email'] ?? '',
    );
  }

  /// Construir desde SQLite
  factory UsuarioModel.fromMap(Map<String, dynamic> map) => UsuarioModel(
    id: map['id'],
    nombre: map['nombre'],
    email: map['email'],
    password: map['password'] ?? '',
  );

  /// Guardar en SQLite
  Map<String, dynamic> toMap() => {
    'id': id,
    'nombre': nombre,
    'email': email,
    'password': password,
  };

  factory UsuarioModel.fromUsuario(Usuario usuario) {
    return UsuarioModel(
      id: usuario.id,
      nombre: usuario.nombre,
      email: usuario.email,
      password: usuario.password,
    );
  }

  @override
  String toString() => 'UsuarioModel(id: $id, uid: $uid, email: $email)';
}
