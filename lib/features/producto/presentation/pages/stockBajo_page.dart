import 'package:app/features/auth/presentation/provider/auth_provider.dart';
import 'package:app/features/producto/domain/entities/producto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/producto_provider.dart';

class StockBajoPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuarioId = ref.read(authViewModelProvider).usuarioId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos con Stock Bajo'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<List<Producto>>(
        future: ref
            .watch(productoViewModelProvider)
            .getProductoConStockBajo(usuarioId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay productos con stock bajo.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          final productosConStockBajo = snapshot.data!;
          print(
            productosConStockBajo
                .map((p) => '${p.nombre}: ${p.stock}/${p.umbralStockBajo}')
                .toList(),
          );
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: productosConStockBajo.length,
            itemBuilder: (context, index) {
              final producto = productosConStockBajo[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.redAccent.withOpacity(0.2),
                            child: const Icon(
                              Icons.warning,
                              color: Colors.redAccent,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              producto.nombre,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255, 247, 33, 33),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStockDetail(
                            label: 'Cantidad',
                            value: '${producto.stock}',
                            valueColor: Colors.blue,
                          ),
                          _buildStockDetail(
                            label: 'Umbral',
                            value: '${producto.umbralStockBajo}',
                            valueColor: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStockDetail({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
