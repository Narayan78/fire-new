import 'package:fireapp/models/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../providers/auth_provider.dart';


class AuthPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {

    ref.listen(authProvider, (previous, next) {
      if(next.isError){
        Get.defaultDialog(title: next.errText);

      }else{

      }

    });

    final auth = ref.watch(authProvider);

    return ElevatedButton(
        onPressed: (){
          ref.read(authProvider.notifier).userLogin(email: '', password: '');
          // if(auth.isError){
          //   Get.defaultDialog('sdkll;sd');
          // }
        },
        child: const Placeholder());
  }
}
