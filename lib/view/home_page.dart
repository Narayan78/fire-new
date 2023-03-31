import 'package:fireapp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Sample Social'),
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(child: Container()),
                  ListTile(
                    onTap: (){
                      ref.read(authProvider.notifier).userLogOut();
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Sign Out'),
                  )
                ],
              ),
            ),
            body: const Placeholder()
        );
      }
    );
  }
}
