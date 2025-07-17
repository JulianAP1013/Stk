import 'package:app/features/producto/data/models/producto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/movimiento_provider.dart';
import '../../../producto/presentation/provider/producto_provider.dart';
import '../../../producto/domain/entities/producto.dart';
import '../../domain/entities/movimiento.dart';

class MovimientoPages extends ConsumerWidget {
  final int usuarioId;
  MovimientoPages({required this.usuarioId});

  void _mostrarFormularioMovimiento(
    BuildContext context,
    WidgetRef ref,
    int usuarioId,
  ) {
    final cantidadController = TextEditingController();
    final observacionController = TextEditingController();
    String tipoMovimiento = 'entrada';
    Producto? productoSeleccionado;

    showDialog(
      context: context,
      builder:
          (context) => FutureBuilder<List<Producto>>(
            future: ref
                .watch(productoViewModelProvider)
                .getProductos(usuarioId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final productos =
                  snapshot.data!
                      .where((p) => p.usuarioId == usuarioId)
                      .toList();

              return StatefulBuilder(
                builder:
                    (context, setState) => AlertDialog(
                      title: const Text('Registrar Movimiento'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            DropdownButtonFormField<Producto>(
                              value: productoSeleccionado,
                              items:
                                  productos.map((producto) {
                                    return DropdownMenuItem(
                                      value: producto,
                                      child: Text(producto.nombre),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  productoSeleccionado = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Producto',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: tipoMovimiento,
                              items:
                                  ['entrada', 'salida'].map((tipo) {
                                    return DropdownMenuItem(
                                      value: tipo,
                                      child: Text(tipo.toUpperCase()),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  tipoMovimiento = value!;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Tipo de Movimiento',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: cantidadController,
                              decoration: InputDecoration(
                                labelText: 'Cantidad',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: observacionController,
                              decoration: InputDecoration(
                                labelText: 'Observación',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (productoSeleccionado == null ||
                                productoSeleccionado?.id == null ||
                                cantidadController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Por favor, completa todos los campos, y selecciona un producto valido',
                                  ),
                                ),
                              );
                              return;
                            }
                            print(
                              'productoSeleccionado: $productoSeleccionado',
                            );
                            print(
                              'productoSeleccionado?.id: ${productoSeleccionado?.id}',
                            );
                            print('usuarioId: $usuarioId');
                            print('cantidad: ${cantidadController.text}');

                            final movimiento = Movimiento(
                              productoId: productoSeleccionado!.id!,
                              tipo: tipoMovimiento,
                              cantidad: int.parse(cantidadController.text),
                              fecha: DateTime.now(),
                              detalles: observacionController.text,
                              usuarioId: usuarioId,
                            );

                            try {
                              await ref
                                  .read(movimientoViewModelProvider)
                                  .insertMovimiento(movimiento);
                              // Actualizar el stock del producto
                              int nuevoStock = productoSeleccionado!.stock;
                              int cantidad = int.parse(cantidadController.text);

                              if (tipoMovimiento == 'entrada') {
                                nuevoStock += cantidad;
                              } else if (tipoMovimiento == 'salida') {
                                nuevoStock -= cantidad;
                                if (nuevoStock < 0)
                                  nuevoStock = 0; // Evita stock negativo
                              }

                              final productoActualizado = (productoSeleccionado
                                      as ProductoModel)
                                  .copyWith(stock: nuevoStock);
                              await ref
                                  .read(productoViewModelProvider)
                                  .updateProducto(productoActualizado);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Movimiento registrado con éxito',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            }
                          },
                          child: const Text('Registrar'),
                        ),
                      ],
                    ),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(movimientoViewModelProvider);
    vm.getMovimiento(usuarioId);

    final productoProvider = ref.watch(productoViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Movimientos'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<List<Movimiento>>(
        stream: vm.movimientoStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay movimientos registrados.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          final movimientos = snapshot.data!;

          return FutureBuilder<List<Producto>>(
            future: productoProvider.getProductos(usuarioId),
            builder: (context, productoSnapshot) {
              if (productoSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!productoSnapshot.hasData) {
                return const Center(
                  child: Text('No se pudieron cargar los productos.'),
                );
              }
              final productos = productoSnapshot.data!;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: movimientos.length,
                itemBuilder: (context, index) {
                  final movimiento = movimientos[index];
                  final producto = productos.firstWhere(
                    (p) =>
                        p.id == movimiento.productoId &&
                        p.usuarioId == usuarioId,
                    orElse:
                        () => ProductoModel(
                          id: 0,
                          nombre: 'Producto no encontrado',
                          descripcion: '',
                          stock: 0,
                          precio: 0.0,
                          categoria: '',
                          umbralStockBajo: 0,
                          usuarioId: usuarioId,
                        ),
                  );

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            movimiento.tipo == 'entrada'
                                ? Colors.green.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                        child: Icon(
                          movimiento.tipo == 'entrada'
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color:
                              movimiento.tipo == 'entrada'
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      ),
                      title: Text(
                        movimiento.tipo == 'entrada' ? 'Entrada' : 'Salida',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Producto: ${producto.nombre}'),
                          Text('Cantidad: ${movimiento.cantidad}'),
                          if (movimiento.detalles.isNotEmpty)
                            Text('Observación: ${movimiento.detalles}'),
                        ],
                      ),
                      trailing: Text(
                        movimiento.fecha.toIso8601String().substring(
                          0,
                          10,
                        ), // yyyy-MM-dd
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarFormularioMovimiento(context, ref, usuarioId);
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
