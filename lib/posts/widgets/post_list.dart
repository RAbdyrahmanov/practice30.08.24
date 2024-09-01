import 'package:flutter/material.dart';
import 'package:practice30_08_24/posts/domain/entity/post_entity.dart';
import 'package:practice30_08_24/posts/presentation/post_screen.dart';

class PostList extends StatelessWidget {
  const PostList({super.key, required this.allposts,});
  final List<PostEntity>? allposts;

  @override
  Widget build(BuildContext context) {
    return   Expanded(
            child: ListView.builder(
              itemCount: allposts?.length,
              itemBuilder: (context, index) {
                final post = allposts?[index];
                return PostCard(post: post ?? PostEntity.emty() , 
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(post?.title ?? ''),
                      content: Text(post?.description ?? ''),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                });
              },
            ),
          );
  }
}