import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/movimiento_provider.dart';

class MovimientoPages extends ConsumerWidget {
  final int usuarioId;
  MovimientoPages({required this.usuarioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(movimientoViewModelProvider);
    vm.getMovimiento(usuarioId);

    return Scaffold(
      appBar: AppBar(title: Text('Movimientos')),
      body: StreamBuilder(
        stream: vm.movimientoStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final movimientos = snapshot.data!;
          return ListView.builder(
            itemCount: movimientos.length,
            itemBuilder:
                (_, i) => ListTile(
                  title: Text(
                    '${movimientos[i].tipo} - ${movimientos[i].cantidad} ',
                  ),
                  subtitle: Text('Fecha: ${movimientos[i].fecha}'),
                ),
          );
        },
      ),
    );
  }
}
