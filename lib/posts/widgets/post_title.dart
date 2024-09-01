import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const   Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Search Posts',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
  }
}