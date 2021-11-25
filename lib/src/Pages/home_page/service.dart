import 'package:dio/dio.dart';
import 'package:flutter_api_get_test/src/Pages/home_page/model.dart';

class PostApiServiec {
  PostApiServiec();
  var dio = Dio();
  Future<List<AllPosts>> getAllPosts() async {
    Response response =
        await dio.get('https://jsonplaceholder.typicode.com/posts');
    print("All Posts =-=-=> ${response.data is List<dynamic>}");

    List<AllPosts> allPosts = (response.data as List<dynamic>).map((post) {
      AllPosts allPosts = AllPosts.fromJson(post);
      return allPosts;
    }).toList();

    return allPosts;
  }
}
