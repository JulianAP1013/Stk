import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/producto_provider.dart';

class ProductoPage extends ConsumerWidget {
  final int usuarioId;
  ProductoPage({required this.usuarioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(productoViewModelProvider);
    vm.getProductos(usuarioId);

    return Scaffold(
      appBar: AppBar(title: Text('Productos')),
      body: StreamBuilder(
        stream: vm.productoStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final productos = snapshot.data!;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder:
                (_, i) => ListTile(
                  title: Text(productos[i].nombre),
                  subtitle: Text('Stock: ${productos[i].stock}'),
                ),
          );
        },
      ),
    );
  }
}
