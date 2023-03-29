import 'package:fireapp/common_provider/other_provider.dart';
import 'package:fireapp/models/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../constants/sizes.dart';
import '../providers/auth_provider.dart';


class AuthPage extends ConsumerWidget {

  final userNameController = TextEditingController();
  final mailController = TextEditingController();
  final passController = TextEditingController();
  final _form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context, ref) {

    ref.listen(authProvider, (previous, next) {
      if(next.isError){

      }else if (next.isSuccess){

      }

    });
    print('build');

    final auth = ref.watch(authProvider);
    final isLogin = ref.watch(loginProvider);
    final mod = ref.watch(mode);
    final pass = ref.watch(passHide);
    return Scaffold(
      body: SafeArea(
        child: Form(
         autovalidateMode: mod,
          key: _form,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: ListView(
              children: [

                Text(isLogin ? 'Login Form': 'SignUp Form'),
                  gapH32,
                if(!isLogin)  TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10)
                    ],
                    decoration: InputDecoration(
                        hintText: 'Username'
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val){
                      if(val!.isEmpty){
                        return  'username is required';
                      }else if(val.length < 7){
                        return 'minimum 6 character required';
                      }
                      return null;
                    },
                    controller: userNameController,
                  ),
                gapH16,
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email'
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (val){

                    if(val!.isEmpty){
                      return  'email is required';
                    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val)){
                      return 'please provide valid email';
                    }
                    return null;
                  },
                  controller: mailController,
                ),
                gapH16,
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20)
                  ],
                  decoration: InputDecoration(
                      hintText: 'Pass',
                    suffixIcon: IconButton(
                        onPressed: (){
                          ref.read(passHide.notifier).state = !ref.read(passHide.notifier).state;
                        },
                        icon: Icon(pass ?Icons.lock: Icons.lock_open_sharp)
                    )
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (val){
                      if(val!.isEmpty){
                        return  'password is required';
                      }else if(val.length < 7){
                        return 'minimum 6 character required';
                      }
                      return null;
                  },
                  obscureText:pass ? true : false,
                  controller: passController,
                ),
                gapH16,
                if(!isLogin)  InkWell(
                    onTap: (){},
                    child: Container()),

                ElevatedButton(
                    onPressed:auth.isLoad ? null : (){
                      _form.currentState!.save();
                      if(_form.currentState!.validate()){
                        ref.read(authProvider.notifier).userLogin(
                            email: mailController.text.trim(),
                            password: passController.text.trim()
                        );
                      
                      }else{
                        ref.read(mode.notifier).change();
                      }

                    },
                    child:auth.isLoad ? CircularProgressIndicator(): Text('Submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
