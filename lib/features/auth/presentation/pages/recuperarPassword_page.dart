import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';

class RecuperarPasswordPage extends ConsumerWidget {
  const RecuperarPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final newPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Fondo con gradiente decorativo
          Container(
            height: size.height * 0.4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),

          // Contenido centrado
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Text(
                      'Recuperar Contraseña',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // Correo
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Correo',
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator:
                                    (value) =>
                                        value!.isEmpty
                                            ? 'Por favor ingresa tu correo'
                                            : null,
                              ),
                              const SizedBox(height: 16),

                              // Nueva contraseña
                              TextFormField(
                                controller: newPasswordController,
                                decoration: InputDecoration(
                                  labelText: 'Nueva Contraseña',
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                obscureText: true,
                                validator:
                                    (value) =>
                                        value!.isEmpty
                                            ? 'Por favor ingresa una nueva contraseña'
                                            : null,
                              ),
                              const SizedBox(height: 24),

                              // Botón de recuperación
                              ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await ref
                                        .read(authViewModelProvider)
                                        .recuperarPassword(
                                          emailController.text.trim(),
                                          newPasswordController.text.trim(),
                                        );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Contraseña actualizada correctamente',
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context); // Volver al login
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Recuperar',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Volver atrás
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Volver al inicio de sesión',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
