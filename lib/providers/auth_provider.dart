
import 'dart:async';

import 'package:fireapp/models/common_state.dart';
import 'package:fireapp/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthProvider, CommonState>((ref) => AuthProvider(CommonState.empty(), ref.watch(authService)));

class AuthProvider extends StateNotifier<CommonState>{
  final AuthService service;
  AuthProvider(super.state, this.service);

  Future<void> userLogin({
    required String email,
    required String password
  }) async{
    state = state.copyWith(isLoad: true, errText: '', isError: false, isSuccess: false);
    final response = await service.userLogin(email: email, password: password);
    response.fold(
            (l) {
              state = state.copyWith(isLoad: false, errText: l, isError: true, isSuccess: false);
            },
            (r) {
              state = state.copyWith(isLoad: false, errText: '', isError: false, isSuccess: r);
            }
    );
  }

}
