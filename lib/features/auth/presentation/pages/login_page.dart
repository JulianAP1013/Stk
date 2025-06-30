import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //controladores para los campos de texto
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Campo Email
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
              //Campo contraseña
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Constraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator:
                    (value) =>
                        value!.isEmpty
                            ? 'Por favor ingresa tu contraseña'
                            : null,
              ),
              const SizedBox(height: 24),
              //Boton de Login
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
                      Navigator.pushReplacementNamed(context, '/Home');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Correo o contraseña incorrectos'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Iniciar Sesión'),
              ),
              //Boton Para ir a registro
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Register');
                },
                child: const Text('¿No tienes cuenta? Registrate'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Recuperar');
                },
                child: const Text('¿Olvidaste tu contraseña?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
