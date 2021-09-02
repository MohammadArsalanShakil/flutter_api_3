import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '/models/blogpost.dart';

import '/constants/urls.dart';
import 'package:http/http.dart' as http;

class APIFunctions {
  Future<List<BlogPost>?> fetchAllBlogPosts() async {
    try {
      final response = await http.get(Uri.parse(blogpost_get_url_all));

      if (response.statusCode == 200) {
        List<dynamic> postData = jsonDecode(response.body);

        List<BlogPost> posts =
            postData.map((post) => BlogPost.fromJson(post)).toList();
        return posts;
      } else {
        throw SocketException;
      }
    } on TimeoutException catch (e) {
      print('fetchAllBlogPosts Timeout: ' + e.message.toString());
    } on HttpException catch (e) {
      print('fetchAllBlogPosts Http: ' + e.message.toString());
    } on SocketException catch (e) {
      print('fetchAllBlogPosts Socket: ' + e.message.toString());
    } on Exception catch (e) {
      print('fetchAllBlogPosts Exception: ' + e.toString());
    }
  }

  Future<BlogPost?> fetchBlogPost() async {
    try {
      final response = await http.get(Uri.parse(blogpost_get_url));

      if (response.statusCode == 200) {
        BlogPost blog = BlogPost.fromJson(jsonDecode(response.body));
        return blog;
      } else {
        throw SocketException;
      }
    } on TimeoutException catch (e) {
      print('fetchBlogPost Timeout: ' + e.message.toString());
    } on HttpException catch (e) {
      print('fetchBlogPost Http: ' + e.message.toString());
    } on SocketException catch (e) {
      print('fetchBlogPost Socket: ' + e.message.toString());
    } on Exception catch (e) {
      print('fetchBlogPost Exception: ' + e.toString());
    }
  }

  Future<BlogPost?> addBlogPost(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse(blogpost_post_url),
        body: jsonEncode(
          <String, String>{
            'title': title,
            'body': body,
          },
        ),
      );

      if (response.statusCode == 201) {
        final BlogPost blog = BlogPost.fromJson(jsonDecode(response.body));
        return blog;
      } else {
        throw SocketException;
      }
    } on TimeoutException catch (e) {
      print('addBlogPost Timeout: ' + e.message.toString());
    } on HttpException catch (e) {
      print('addBlogPost Http: ' + e.message.toString());
    } on SocketException catch (e) {
      print('addBlogPost Socket: ' + e.message.toString());
    } on Exception catch (e) {
      print('addBlogPost Exception: ' + e.toString());
    }
  }
}
