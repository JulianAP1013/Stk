import 'package:get_it/get_it.dart';
import 'package:app/core/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Inicializar la base de datos y registrar el singleton
  final db = await DatabaseHelper.databse;

  sl.registerLazySingleton<Database>(() => db);
}
