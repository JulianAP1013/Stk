import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../usuario/domain/entities/usuario.dart';
import '../provider/auth_provider.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nombreController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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

          // Formulario centrado
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Text(
                      'Registrarse',
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
                              // Nombre
                              TextFormField(
                                controller: nombreController,
                                decoration: InputDecoration(
                                  labelText: 'Nombre',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator:
                                    (value) =>
                                        value!.isEmpty
                                            ? 'Por favor ingresa tu nombre'
                                            : null,
                              ),
                              const SizedBox(height: 16),

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

                              // Contraseña
                              TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                obscureText: true,
                                validator:
                                    (value) =>
                                        value!.isEmpty
                                            ? 'Por favor ingresa tu contraseña'
                                            : null,
                              ),
                              const SizedBox(height: 24),

                              // Botón de registro
                              ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final usuario = Usuario(
                                      id: 0,
                                      nombre: nombreController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );

                                    await ref
                                        .read(authViewModelProvider)
                                        .register(usuario);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Usuario registrado exitosamente',
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
                                  'Registrarse',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Volver al login
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  '¿Ya tienes cuenta? Inicia sesión',
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
