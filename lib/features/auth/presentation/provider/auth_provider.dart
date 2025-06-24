import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/authRx_ViewModel.dart';
import '../../../../core/service_locator.dart';

final authViewModelProvider = Provider<AuthrxViewmodel>((ref) {
  return sl<AuthrxViewmodel>();
});
