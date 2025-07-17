import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Fondo decorativo con gradiente
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
                      'Iniciar Sesión',
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
                              // Campo correo
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

                              // Campo contraseña
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator:
                                    (value) =>
                                        value!.isEmpty
                                            ? 'Por favor ingresa tu contraseña'
                                            : null,
                              ),
                              const SizedBox(height: 24),

                              // Botón login
                              ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      await ref
                                          .read(authViewModelProvider)
                                          .login(
                                            emailController.text.trim(),
                                            passwordController.text.trim(),
                                          );
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/Home',
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Correo o contraseña incorrectos',
                                          ),
                                        ),
                                      );
                                    }
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
                                  'Iniciar Sesión',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),

                              // Links
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Register');
                                },
                                child: const Text(
                                  '¿No tienes cuenta? Regístrate',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Recuperar');
                                },
                                child: const Text(
                                  '¿Olvidaste tu contraseña?',
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
