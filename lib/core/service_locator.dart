import 'package:get_it/get_it.dart';
import 'package:app/core/database/database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
/* AUTH */
import '../features/auth/data/datasource/authDatasource.dart';
import '../features/auth/data/datasource/authDatasourceImpl.dart';
import '../features/auth/domain/repository/authRepository.dart';
import '../features/auth/domain/repository/authRepositoryImpl.dart';
// Firebase
import '../features/auth/data/datasource/firebase/authFirebaseDatasourceImpl.dart';
// Casos de uso
import 'package:app/features/auth/domain/usecase/login.dart';
import 'package:app/features/auth/domain/usecase/logout.dart';
import 'package:app/features/auth/domain/usecase/recuperarPassword.dart';
import 'package:app/features/auth/domain/usecase/register.dart';
// ViewModel
import 'package:app/features/auth/presentation/viewmodel/authRx_ViewModel.dart';
/* Productos */
import '../features/producto/data/datasource/productoDatasource.dart';
import '../features/producto/data/datasource/protucto_Datasource_Impl.dart';
import '../features/producto/domain/repository/producto_Repository.dart';
import '../features/producto/domain/repository/producto_Repository_Impl.dart';
// Firebase
import '../features/producto/data/datasource/firebase/productoFirebaseDatasourceImpl.dart';

// Casos de uso
import 'package:app/features/producto/domain/usecase/insertProducto.dart';
import 'package:app/features/producto/domain/usecase/getProducto.dart';
import 'package:app/features/producto/domain/usecase/getProductoById.dart';
import 'package:app/features/producto/domain/usecase/getProductoConStockBajo.dart';
import 'package:app/features/producto/domain/usecase/deleteProducto.dart';
import 'package:app/features/producto/domain/usecase/updateProducto.dart';
// ViewModel
import 'package:app/features/producto/presentation/viewmodels/productoRx_ViewModel.dart';
/* MOVIMIENTO */
import '../features/movimiento/data/datasource/movimientoDatasource.dart';
import '../features/movimiento/data/datasource/movimientoDatasourceImpl.dart';
import '../features/movimiento/domain/repository/movimientoRepository.dart';
import '../features/movimiento/domain/repository/movimientoRepositoryImpl.dart';
// Firebase
import '../features/movimiento/data/datasource/firebase/movimientoFirebaseDatasourceImpl.dart';
// Casos de uso
import 'package:app/features/movimiento/domain/usecase/deleteMovimiento.dart';
import 'package:app/features/movimiento/domain/usecase/getMovimiento.dart';
import 'package:app/features/movimiento/domain/usecase/getMovimientoById.dart';
import 'package:app/features/movimiento/domain/usecase/insertMovimiento.dart';
import 'package:app/features/movimiento/domain/usecase/updateMovimiento.dart';
// ViewModel
import 'package:app/features/movimiento/presentation/viewmodels/movimientoRx_ViewModel.dart';
/* USUARIO */
import '../features/usuario/data/datasource/usuarioDatasource.dart';
import '../features/usuario/data/datasource/usuarioDatasourceImpl.dart';
import '../features/usuario/domain/repository/usuarioRepository.dart';
import '../features/usuario/domain/repository/usuarioRepositoryImpl.dart';
// Firebase
import '../features/usuario/data/datasource/firebase/usuarioFirebaseDatasourceImpl.dart';
// Casos de uso
import 'package:app/features/usuario/domain/usecase/deleteUsuario.dart';
import 'package:app/features/usuario/domain/usecase/getUsuario.dart';
import 'package:app/features/usuario/domain/usecase/insertUsuario.dart';
import 'package:app/features/usuario/domain/usecase/updateUsuario.dart';
// ViewModel
import 'package:app/features/usuario/presentation/viewmodels/usuarioRx_ViewModel.dart';

final sl = GetIt.instance;

Future<void> setupLocator({required bool useFirestore}) async {
  if (useFirestore) {
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  } else {
    // SQLite: inicializa y registra la base de datos
    final db = await DatabaseHelper.databse;
    sl.registerLazySingleton<Database>(() => db);
  }

  /* AUTH */
  sl.registerLazySingleton<Authdatasource>(
    () =>
        useFirestore
            ? Authfirebasedatasourceimpl(
              sl<FirebaseAuth>(),
              sl<FirebaseFirestore>(),
            )
            : Authdatasourceimpl(sl<Database>()),
  );
  sl.registerLazySingleton<Authrepository>(() => Authrepositoryimpl(sl()));
  // Casos de uso
  sl.registerLazySingleton<Login>(() => Login(sl()));
  sl.registerLazySingleton<Register>(() => Register(sl()));
  sl.registerLazySingleton<Recuperarpassword>(() => Recuperarpassword(sl()));
  sl.registerLazySingleton<Logout>(() => Logout(sl()));
  // ViewModel
  sl.registerLazySingleton(
    () => AuthrxViewmodel(
      sl<Login>(),
      sl<Logout>(),
      sl<Recuperarpassword>(),
      sl<Register>(),
    ),
  );
  /* PRODUCTO */
  sl.registerLazySingleton<Productodatasource>(
    () =>
        useFirestore
            ? ProductoFirebaseDatasourceImpl(sl<FirebaseFirestore>())
            : ProtuctoDatasourceImpl(sl<Database>()),
  );
  sl.registerLazySingleton<ProductoRepository>(
    () => ProductoRepositoryImpl(sl<Productodatasource>()),
  );
  // Casos de uso
  sl.registerLazySingleton<InsertProducto>(() => InsertProducto(sl()));
  sl.registerLazySingleton<Getproducto>(() => Getproducto(sl()));
  sl.registerLazySingleton<Getproductobyid>(() => Getproductobyid(sl()));
  sl.registerLazySingleton<Getproductoconstockbajo>(
    () => Getproductoconstockbajo(sl()),
  );
  sl.registerLazySingleton<Updateproducto>(() => Updateproducto(sl()));
  sl.registerLazySingleton<Deleteproducto>(() => Deleteproducto(sl()));
  // ViewModel
  sl.registerLazySingleton(
    () => ProductorxViewmodel(
      sl<InsertProducto>(),
      sl<Getproducto>(),
      sl<Getproductobyid>(),
      sl<Getproductoconstockbajo>(),
      sl<Deleteproducto>(),
      sl<Updateproducto>(),
    ),
  );

  /* MOVIMIENTO */
  sl.registerLazySingleton<Movimientodatasource>(
    () =>
        useFirestore
            ? MovimientoFirebaseDatasourceImpl(sl<FirebaseFirestore>())
            : Movimientodatasourceimpl(sl<Database>()),
  );
  sl.registerLazySingleton<Movimientorepository>(
    () => Movimientorepositoryimpl(sl<Movimientodatasource>()),
  );
  // Casos de uso
  sl.registerLazySingleton<Insertmovimiento>(() => Insertmovimiento(sl()));
  sl.registerLazySingleton<Getmovimiento>(() => Getmovimiento(sl()));
  sl.registerLazySingleton<Getmovimientobyid>(() => Getmovimientobyid(sl()));
  sl.registerLazySingleton<Updatemovimiento>(() => Updatemovimiento(sl()));
  sl.registerLazySingleton<Deletemovimiento>(() => Deletemovimiento(sl()));
  // ViewModel
  sl.registerLazySingleton(
    () => MovimientorxViewmodel(
      sl<Insertmovimiento>(),
      sl<Getmovimiento>(),
      sl<Getmovimientobyid>(),
      sl<Deletemovimiento>(),
      sl<Updatemovimiento>(),
    ),
  );

  /* USUARIO */
  sl.registerLazySingleton<Usuariodatasource>(
    () =>
        useFirestore
            ? UsuarioFirebaseDatasourceImpl()
            : Usuariodatasourceimpl(sl<Database>()),
  );
  sl.registerLazySingleton<UsuarioRepository>(
    () => UsuarioRepositoryImpl(sl()),
  );
  // Casos de uso
  sl.registerLazySingleton<Insertusuario>(() => Insertusuario(sl()));
  sl.registerLazySingleton<Getusuario>(() => Getusuario(sl()));
  sl.registerLazySingleton<Updateusuario>(() => Updateusuario(sl()));
  sl.registerLazySingleton<Deleteusuario>(() => Deleteusuario(sl()));
  // ViewModel
  sl.registerLazySingleton(
    () => UsuariorxViewmodel(
      sl<Insertusuario>(),
      sl<Getusuario>(),
      sl<Updateusuario>(),
      sl<Deleteusuario>(),
    ),
  );
}
