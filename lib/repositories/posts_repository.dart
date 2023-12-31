import 'dart:convert';

import '../models/post_model.dart';
import 'package:http/http.dart' as http;

class PostsRepository {
  
  Future<List<PostModel>> getPosts() async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      var jsonPosts = jsonDecode(response.body);
      return (jsonPosts as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}