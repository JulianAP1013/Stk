import 'package:app/shared/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/producto_provider.dart';
import 'package:app/features/producto/domain/entities/producto.dart';
import '../../../../shared/widgets/producto/productoListItem.dart';
import '../../../../shared/widgets/emptyListMessage.dart';
import '../../../../shared/widgets/loadingIndicator.dart';

class ProductoPage extends ConsumerWidget {
  final int usuarioId;
  ProductoPage({super.key, required this.usuarioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(productoViewModelProvider);
    //Cargar productos del usuario cada vez que se construye la pantalla
    vm.getProductos(usuarioId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: vm.productoStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loadingindicator();
          }
          final productos = snapshot.data!;
          final totalStockBajo =
              productos.where((p) => p.stock <= p.umbralStockBajo).length;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar Producto'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white70,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      _mostrarFormularioProducto(context, ref, usuarioId);
                    },
                  ),
                ),
              ),
              ...(productos.isEmpty
                  ? [
                    const Expanded(
                      child: Emptylistmessage(
                        message: 'No hay Produtos Registrados',
                      ),
                    ),
                  ]
                  : [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: productos.length,
                        itemBuilder: (context, index) {
                          final producto = productos[index];
                          return Productolistitem(
                            producto: producto,
                            onEdit:
                                () => _mostrarFormularioProducto(
                                  context,
                                  ref,
                                  usuarioId,
                                  producto: producto,
                                ),
                            onDelete: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: const Text(
                                        'Confirmar Eliminacion',
                                      ),
                                      content: const Text(
                                        '¿Estas seguro que deseas eliminar este producto?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () =>
                                                  Navigator.pop(context, false),
                                          child: const Text('Cancelar'),
                                        ),
                                        ElevatedButton(
                                          onPressed:
                                              () =>
                                                  Navigator.pop(context, true),
                                          child: const Text('Eliminar'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                              );
                              if (confirm == true) {
                                try {
                                  if (producto.id != null) {
                                    await vm.deleteProducto(
                                      producto.id!,
                                      usuarioId,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Producto Eliminado'),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Error: Producto ID es nulo',
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e')),
                                  );
                                }
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomCard(
                  icon: Icons.warning,
                  iconColor: Colors.red,
                  title: 'Alertas de Stock Bajo',
                  subtitle: '$totalStockBajo productos con stock bajo',
                  buttonLabel: 'Productos con Bajo Stock',
                  onTap: () {
                    Navigator.pushNamed(context, '/StkBajo');
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _mostrarFormularioProducto(
    BuildContext context,
    WidgetRef ref,
    int usuarioId, {
    Producto? producto,
  }) {
    final nombreController = TextEditingController(
      text: producto?.nombre ?? '',
    );
    final descripcionController = TextEditingController(
      text: producto?.descripcion ?? '',
    );
    final cantidadController = TextEditingController(
      text: producto?.stock.toString() ?? '',
    );
    final precioController = TextEditingController(
      text: producto?.precio.toString() ?? '',
    );
    final categoriaController = TextEditingController(
      text: producto?.categoria ?? '',
    );
    final umbralController = TextEditingController(
      text: producto?.umbralStockBajo.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            producto == null ? 'Agregar Producto' : 'Editar Producto',
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: descripcionController,
                  decoration: const InputDecoration(labelText: 'Descripcion'),
                ),
                TextField(
                  controller: cantidadController,
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: precioController,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: categoriaController,
                  decoration: const InputDecoration(labelText: 'Categoria'),
                ),
                TextField(
                  controller: umbralController,
                  decoration: const InputDecoration(
                    labelText: 'Umbral de Stock Bajo',
                  ),
                  keyboardType: TextInputType.number,
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
                final vm = ref.read(productoViewModelProvider);
                if (nombreController.text.isEmpty ||
                    cantidadController.text.isEmpty ||
                    precioController.text.isEmpty ||
                    umbralController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, completa todos los campos'),
                    ),
                  );
                  return;
                }
                try {
                  if (producto == null) {
                    // Agregar nuevo producto
                    await vm.insertProducto(
                      Producto(
                        id: null,
                        nombre: nombreController.text,
                        descripcion: descripcionController.text,
                        stock: int.tryParse(cantidadController.text) ?? 0,
                        precio: double.tryParse(precioController.text) ?? 0.0,
                        categoria: categoriaController.text,
                        umbralStockBajo:
                            int.tryParse(umbralController.text) ?? 0,
                        usuarioId: usuarioId,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Producto agregado')),
                    );
                  } else {
                    // Editar producto existente
                    await vm.updateProducto(
                      Producto(
                        id: producto.id,
                        nombre: nombreController.text,
                        descripcion: descripcionController.text,
                        stock: int.tryParse(cantidadController.text) ?? 0,
                        precio: double.tryParse(precioController.text) ?? 0.0,
                        categoria: categoriaController.text,
                        umbralStockBajo:
                            int.tryParse(umbralController.text) ?? 0,
                        usuarioId: usuarioId,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Producto actualizado')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
                Navigator.pop(context);
              },
              child: Text(producto == null ? 'Agregar' : 'Actualizar'),
            ),
          ],
        );
      },
    );
  }
}
