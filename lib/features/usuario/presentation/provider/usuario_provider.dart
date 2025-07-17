import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/service_locator.dart';
import '../viewmodels/usuarioRx_ViewModel.dart';

final usuarioViewModelProvider = Provider<UsuariorxViewmodel>((ref) {
  return sl<UsuariorxViewmodel>();
});
