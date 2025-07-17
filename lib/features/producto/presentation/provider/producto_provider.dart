import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/service_locator.dart';
import 'package:app/features/producto/presentation/viewmodels/productoRx_ViewModel.dart';

final productoViewModelProvider = Provider<ProductorxViewmodel>((ref) {
  return sl<ProductorxViewmodel>();
});
