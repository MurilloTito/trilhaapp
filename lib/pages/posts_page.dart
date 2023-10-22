import 'package:flutter/material.dart';
import 'package:trilhaapp/repositories/posts_repository.dart';

import '../models/post_model.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => PostsPageState();
}

class PostsPageState extends State<PostsPage> {
  var postsRepository = PostsRepository();
  var posts = <PostModel>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    posts = await postsRepository.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      appBar: AppBar(title: const Center(child: Text('Posts')),),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (_, index) {
          var post = posts[index];
          return Text(post.title);
        },),
      )
    );
  }
}