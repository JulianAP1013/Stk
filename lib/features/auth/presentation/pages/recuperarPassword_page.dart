import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';

class RecuperarPasswordPage extends ConsumerWidget {
  const RecuperarPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controladores para los campos de texto
    final emailController = TextEditingController();
    final newPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Campo de email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email),
                ),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Por favor ingresa tu correo' : null,
              ),
              const SizedBox(height: 16),
              // Campo de nueva contraseña
              TextFormField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Nueva contraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator:
                    (value) =>
                        value!.isEmpty
                            ? 'Por favor ingresa la nueva contraseña'
                            : null,
              ),
              const SizedBox(height: 24),
              // Botón de recuperación
              ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(authViewModelProvider)
                      .recuperarPassword(
                        emailController.text.trim(),
                        newPasswordController.text.trim(),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contraseña actualizada')),
                  );
                  Navigator.pop(context); // Vuelve al login
                },
                child: const Text('Recuperar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
