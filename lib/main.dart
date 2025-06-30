import 'package:app/features/movimiento/presentation/pages/movimiento_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/service_locator.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'package:app/features/auth/presentation/pages/register_page.dart';
import 'features/auth/presentation/pages/recuperarPassword_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'package:app/features/producto/presentation/pages/produto_Pages.dart';
import 'package:app/features/producto/presentation/pages/stockBajo_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa el service locator
  await setupLocator();
  // --- BORRAR LA BASE DE DATOS (solo para desarrollo) ---
  /* final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'app.db');
  await deleteDatabase(path);
  print('Base de datos eliminada en: $path'); */

  runApp(
    const ProviderScope(child: MyApp()),
  ); // Habilita Riverpod en toda la app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STK2',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Página inicial
      initialRoute: '/Login',
      routes: {
        '/Login': (context) => const LoginPage(),
        '/Register': (context) => const RegisterPage(),
        '/Recuperar': (context) => const RecuperarPasswordPage(),
        '/Home': (context) => const HomePage(),
        '/StkBajo': (context) => StockBajoPage(),
        // Agrega aquí más rutas si las necesitas (por ejemplo, productos, reportes, movimientos)
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/Productos') {
          final usuarioId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => ProductoPage(usuarioId: usuarioId),
          );
        } else if (settings.name == '/Movimientos') {
          final usuarioId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => MovimientoPages(usuarioId: usuarioId),
          );
        }
        return null;
      },
    );
  }
}
