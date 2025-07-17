import 'package:app/features/movimiento/presentation/provider/movimiento_provider.dart';
import 'package:app/shared/widgets/emptyListMessage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../movimiento/domain/entities/movimiento.dart';
import '../../../movimiento/presentation/viewmodels/movimientoRx_ViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportesPage extends ConsumerStatefulWidget {
  final int usuarioId;
  const ReportesPage({Key? key, required this.usuarioId}) : super(key: key);

  @override
  ConsumerState<ReportesPage> createState() =>
      _ReportesPageState(usuarioId: usuarioId);
}

class _ReportesPageState extends ConsumerState<ReportesPage> {
  Map<String, Map<String, dynamic>> _reportes = {};

  final int usuarioId;
  _ReportesPageState({required this.usuarioId});

  @override
  void initState() {
    super.initState();
    _generarReportes();
  }

  Future<void> _generarReportes() async {
    final movimientos = await ref
        .read(movimientoViewModelProvider)
        .getMovimiento(usuarioId);
    final Map<String, Map<String, dynamic>> reportes = {};

    for (var movimiento in movimientos) {
      final mes = DateFormat('MMMM yyyy').format(movimiento.fecha);

      if (!reportes.containsKey(mes)) {
        reportes[mes] = {'entradas': 0, 'salidas': 0, 'balance': 0};
      }

      if (movimiento.tipo == 'entrada') {
        reportes[mes]!['entradas'] += movimiento.cantidad;
        reportes[mes]!['balance'] += movimiento.cantidad;
      } else if (movimiento.tipo == 'salida') {
        reportes[mes]!['salidas'] += movimiento.cantidad;
        reportes[mes]!['balance'] -= movimiento.cantidad;
      }
    }

    setState(() {
      _reportes = reportes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes Mensuales'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body:
          _reportes.isEmpty
              ? const Center(
                child: Expanded(
                  child: Emptylistmessage(
                    message: 'No se han agregado Movimientos',
                  ),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _reportes.keys.length,
                itemBuilder: (context, index) {
                  final mes = _reportes.keys.elementAt(index);
                  final data = _reportes[mes]!;

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mes,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildReportItem(
                                label: 'Entradas',
                                value: data['entradas'],
                                color: Colors.green,
                              ),
                              _buildReportItem(
                                label: 'Salidas',
                                value: data['salidas'],
                                color: Colors.red,
                              ),
                              _buildReportItem(
                                label: 'Balance',
                                value: data['balance'],
                                color:
                                    data['balance'] >= 0
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }

  Widget _buildReportItem({
    required String label,
    required int value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$value',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
