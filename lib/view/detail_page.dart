import 'package:fireapp/providers/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class DetailPage extends StatelessWidget {
final Post post;
final types.User user;
DetailPage(this.post, this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Consumer(
              builder: (context, ref, child) {
                return Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'add comment'
                      ),
                      onFieldSubmitted: (val) {
                        if (val.isNotEmpty) {
                        ref.read(crudProvider.notifier).commentPost(
                            postId: post.id,
                            comment: Comment(
                                userName: user.firstName!,
                                comment: val,
                                userImage: user.imageUrl!
                            )
                        );
                        }
                      },
                    )
                  ],
                );
              }
            ),
          ),
        )
    );
  }
}
