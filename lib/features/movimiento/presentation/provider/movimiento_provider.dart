import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/service_locator.dart';
import '../viewmodels/movimientoRx_ViewModel.dart';

final movimientoViewModelProvider = Provider<MovimientorxViewmodel>((ref) {
  return sl<MovimientorxViewmodel>();
});
