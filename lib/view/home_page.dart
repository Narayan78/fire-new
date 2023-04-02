import 'package:fireapp/common_provider/firebase_instances.dart';
import 'package:fireapp/providers/auth_provider.dart';
import 'package:fireapp/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/sizes.dart';



class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final us = ref.watch(auth);
        final users = ref.watch(usersStream);
        final user = ref.watch(singeUser(us.currentUser!.uid));
        return Scaffold(
            appBar: AppBar(
              title: Text('Sample Social'),
            ),
            drawer: Drawer(
              child: user.whenOrNull(
                data: (data){
                  return  ListView(
                    children: [
                      DrawerHeader(child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(data.imageUrl!),fit: BoxFit.cover)
                        ),
                      )),
                      ListTile(
                        onTap: (){
                          ref.read(authProvider.notifier).userLogOut();
                        },
                        leading: Icon(Icons.person),
                        title: Text(data.firstName!),
                      ),
                      ListTile(
                        onTap: (){
                          ref.read(authProvider.notifier).userLogOut();
                        },
                        leading: Icon(Icons.mail),
                        title: Text(data.metadata!['email']),
                      ),

                      ListTile(
                        onTap: (){
                          ref.read(authProvider.notifier).userLogOut();
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Sign Out'),
                      )
                    ],
                  );
                }
              )
            ),
            body: Column(
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  child: users.when(
                      data: (data){
                        return ListView.builder(
                          itemCount: data.length,
                            itemBuilder: (context, index){
                              return Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(data[index].imageUrl!),
                                    ),
                                    gapH12,
                                    Text(data[index].firstName!)
                                  ],
                                ),
                              );
                            }
                        );
                      },
                      error: (err, stack) => Center(child: Text('$err')),
                      loading: () => Container()
                  ),

                )
              ],
            )
        );
      }
    );
  }
}
