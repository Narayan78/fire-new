import 'package:fireapp/common_provider/firebase_instances.dart';
import 'package:fireapp/providers/auth_provider.dart';
import 'package:fireapp/service/auth_service.dart';
import 'package:fireapp/view/add_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../constants/sizes.dart';
import '../service/crud_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final us = ref.watch(auth);
      final users = ref.watch(usersStream);
      final user = ref.watch(singeUser(us.currentUser!.uid));
      final posts = ref.watch(postsStream);
      return Scaffold(
          appBar: AppBar(
            title: Text('Sample Social'),
          ),
          drawer: Drawer(child: user.whenOrNull(data: (data) {
            return ListView(
              children: [
                DrawerHeader(
                    child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(data.imageUrl!),
                          fit: BoxFit.cover)),
                )),
                ListTile(
                  onTap: () {
                    ref.read(authProvider.notifier).userLogOut();
                  },
                  leading: Icon(Icons.person),
                  title: Text(data.firstName!),
                ),
                ListTile(
                  onTap: () {
                    ref.read(authProvider.notifier).userLogOut();
                  },
                  leading: Icon(Icons.mail),
                  title: Text(data.metadata!['email']),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(() => AddPage());
                  },
                  leading: Icon(Icons.add),
                  title: Text('create Post'),
                ),
                ListTile(
                  onTap: () {
                    ref.read(authProvider.notifier).userLogOut();
                  },
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Sign Out'),
                )
              ],
            );
          })),
          body: Column(
            children: [
              Container(
                height: 170,
                width: double.infinity,
                child: users.when(
                    data: (data) {
                      return ListView.builder(
                          itemCount: data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(data[index].imageUrl!),
                                  ),
                                  gapH12,
                                  Text(data[index].firstName!)
                                ],
                              ),
                            );
                          });
                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => Container()),
              ),
              Expanded(
                  child: posts.when(
                      data: (data) {
                        return Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(data[index].title),
                                          Spacer(),
                                          if (us.currentUser!.uid ==
                                              data[index].userId)
                                            IconButton(
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                      title: 'Customize Post',
                                                      content: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          _buildIconButton(
                                                            onpress: (){

                                                            },
                                                            iconData: Icons.edit
                                                          ),
                                                          _buildIconButton(
                                                              onpress: (){

                                                              },
                                                              iconData: Icons.delete
                                                          ),
                                                          _buildIconButton(
                                                              onpress: (){

                                                              },
                                                              iconData: Icons.close
                                                          ),

                                                        ],
                                                      ));
                                                },
                                                icon: Icon(Icons.more_horiz))
                                        ],
                                      ),
                                      Image.network(data[index].imageUrl, height: 300,),
                                    ],
                                  ),
                                );
                              }),
                        );
                      },
                      error: (err, stack) => Text('$err'),
                      loading: () =>
                          Center(child: CircularProgressIndicator())))
            ],
          ));
    });
  }

  IconButton _buildIconButton({required VoidCallback onpress,required IconData iconData}) {
    return IconButton(
        onPressed: onpress,
        icon: Icon(iconData)
    );
  }
}
