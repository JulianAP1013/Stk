class Usuario {
  final int? id;
  final String? uid;
  final String nombre;
  final String email;
  final String password;

  Usuario({
    this.id,
    this.uid,
    required this.nombre,
    required this.email,
    required this.password,
  });
}
