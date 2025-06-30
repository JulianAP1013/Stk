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
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
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
                    Navigator.pushNamed(
                      context,
                      '/Productos',
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
