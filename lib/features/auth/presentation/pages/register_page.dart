import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../usuario/domain/entities/usuario.dart';
import '../provider/auth_provider.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Controladores para campos de texto
    final nombreController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Campo Nombre
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                ),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Por favor Ingresa tu nombre' : null,
              ),
              const SizedBox(height: 16),
              //Campo Email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email),
                ),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Por favor Ingresa tu correo' : null,
              ),
              //Campo Contraseña
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator:
                    (value) =>
                        value!.isEmpty
                            ? 'Por favor ingresa tu contraseña'
                            : null,
              ),
              //Boton de registro
              ElevatedButton(
                onPressed: () async {
                  final usuario = Usuario(
                    id: 0,
                    nombre: nombreController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  await ref.read(authViewModelProvider).register(usuario);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuario registrado exitosamente'),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
