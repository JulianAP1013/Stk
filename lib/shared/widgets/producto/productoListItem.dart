import 'package:flutter/material.dart';
import 'productDetail.dart';
import 'package:app/features/producto/domain/entities/producto.dart';

class Productolistitem extends StatelessWidget {
  final Producto producto;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const Productolistitem({
    super.key,
    required this.producto,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent.withOpacity(0.2),
                  child: const Icon(Icons.inventory, color: Colors.blueAccent),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.cyan,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Productdetail(
                  label: 'Descripcion',
                  value:
                      producto.descripcion.isNotEmpty
                          ? producto.descripcion
                          : 'N/A',
                  valuerColor: Colors.grey[800],
                ),
                Productdetail(
                  label: 'Precio',
                  value: '\$${producto.precio.toStringAsFixed(2)}',
                  valuerColor: Colors.green,
                ),
                Productdetail(
                  label: 'Categoria',
                  value: producto.categoria,
                  valuerColor: Colors.teal,
                ),
                Productdetail(
                  label: 'Cantidad',
                  value: '${producto.stock}',
                  valuerColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
