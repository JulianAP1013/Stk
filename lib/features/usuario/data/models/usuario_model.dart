import 'package:flutter/foundation.dart';

import '../../domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  UsuarioModel({
    required int id,
    required String nombre,
    required String email,
    required String password,
  }) : super(id: id, nombre: nombre, email: email, password: password);
  factory UsuarioModel.fromMap(Map<String, dynamic> map) => UsuarioModel(
    id: map['id'],
    nombre: map['nombre'],
    email: map['email'],
    password: map['password'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'nombre': nombre,
    'email': email,
    'password': password,
  };
}
