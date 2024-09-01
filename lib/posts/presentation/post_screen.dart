import 'package:flutter/material.dart';
import 'package:practice30_08_24/posts/domain/entity/post_entity.dart';
import 'package:practice30_08_24/posts/widgets/post_list.dart';
import 'package:practice30_08_24/posts/widgets/post_title.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final List<PostEntity> _allPosts = List.generate(
    100,
    (index) => PostEntity(
      title: 'Post $index',
      description: 'Description for Post $index',
      author: 'Author $index',
    ),
  );

  List<PostEntity>? _filteredPosts;

  @override
  void initState() {
    super.initState();
    _filteredPosts = _allPosts;
  }

  void _filterPosts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPosts = _allPosts;
      } else {
        _filteredPosts = _allPosts
            .where((post) =>
                post.title.toLowerCase().contains(query.toLowerCase()) ||
                post.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: PostSearchDelegate(
                allPosts: _allPosts,
                onQueryChanged: _filterPosts,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const PostTitle(),
          PostList(
            allposts: _filteredPosts,
          ),
        ],
      ),
    );
  }
}



class PostCard extends StatelessWidget {
  final PostEntity post;
  final VoidCallback onTap;

  const PostCard({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.description),
        trailing: const Icon(Icons.more_vert),
        onTap: onTap,
      ),
    );
  }
}

class PostSearchDelegate extends SearchDelegate<String> {
  final List<PostEntity> allPosts;
  final Function(String) onQueryChanged;

  PostSearchDelegate({required this.allPosts, required this.onQueryChanged});

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allPosts
        .where((post) =>
            post.title.toLowerCase().contains(query.toLowerCase()) ||
            post.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final post = suggestions[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.description),
          onTap: () {
            query = post.title;
            showResults(context);
            onQueryChanged(query);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allPosts
        .where((post) =>
            post.title.toLowerCase().contains(query.toLowerCase()) ||
            post.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final post = results[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.description),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostDetailPage(post: post),
            ));
          },
        );
      },
    );
  }

  Widget buildCancelButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.cancel),
      onPressed: () {
        query = '';
        onQueryChanged(query);
        showSuggestions(context);
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
   
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    
    throw UnimplementedError();
  }
}

class PostDetailPage extends StatelessWidget {
  final PostEntity post;

  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(post.description),
            const SizedBox(height: 16),
            Text('Author: ${post.author}',
                style: const TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}
