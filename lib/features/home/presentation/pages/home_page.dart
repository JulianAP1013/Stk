import 'package:app/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../producto/presentation/provider/producto_provider.dart';
import '../../../usuario/presentation/provider/usuario_provider.dart';
import '../../../../shared/widgets/custom_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Accede al ViewModel de productos con RiverPod
    final productoViewModel = ref.watch(productoViewModelProvider);
    final usuarioId = ref.read(authViewModelProvider).usuarioId;
    // Lama a getProductos cada vez qie cambia el usuarioId
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productoViewModel.getProductos(usuarioId!);
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              ref.read(authViewModelProvider).logout();
              Navigator.pushReplacementNamed(context, '/Login');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        //Escucha al stream de productos
        stream: productoViewModel.productoStream,
        builder: (context, snapshot) {
          final produtos = snapshot.data ?? [];
          final totalProductos = produtos.length;
          //Calcula productos cons stock bajo
          /* final alertaStockBajo =
              produtos.where((p) => p.stock <= p.umbralStockBajo).length; */

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCard(
                  icon: Icons.inventory,
                  iconColor: Colors.blue,
                  title: 'Total de Productos',
                  subtitle: '$totalProductos productos registrados',
                  buttonLabel: 'Ver productos',
                  onTap: () {
                    print('usuarioId para Productos: $usuarioId');
                    Navigator.pushNamed(
                      context,
                      '/Productos',
                      arguments: usuarioId,
                    );
                  },
                ),
                CustomCard(
                  icon: Icons.book,
                  iconColor: Colors.orangeAccent,
                  title: 'Reportes Mensuales',
                  subtitle: 'Consulte el balance mensual de entradas y salidas',
                  buttonLabel: 'Ver Reportes',
                  onTap: () {
                    print('usuarioId para Reportes: $usuarioId');
                    Navigator.pushNamed(
                      context,
                      '/Reportes',
                      arguments: usuarioId,
                    );
                  },
                ),
                CustomCard(
                  icon: Icons.history,
                  iconColor: Colors.lightGreen,
                  title: 'Historial de Movimientos',
                  subtitle: 'Consulta los movimientos del inventario',
                  buttonLabel: 'Ver Historial',
                  onTap: () {
                    print('usuarioId para movimientos: $usuarioId');
                    Navigator.pushNamed(
                      context,
                      '/Movimientos',
                      arguments: usuarioId,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
