import 'dart:convert';
import 'package:blog_app/model/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class BlogServices {
  final String apiUrl = "https://tobetoapi.halitkalayci.com/api/Articles";

  Future<List<BlogPost>> getBlog() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      debugPrint(data.toString());

      return data.map((json) => BlogPost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<void> addBlogPost({
    required String title,
    required String content,
    required String author,
    XFile? image,
  }) async {
    try {
      Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

      var request = http.MultipartRequest("POST", url);
      request.fields["Title"] = title;
      request.fields["Content"] = content;
      request.fields["Author"] = author;

      final file = await http.MultipartFile.fromPath("File", image!.path);

      request.files.add(file);

      final response = await request.send();

      if (response.statusCode == 201) {
        debugPrint("Blog başarıyla eklendi");
      } else {
        debugPrint("Blog yazısı eklenemedi");
      }
    } catch (error) {
      debugPrint('Network error: $error');
    }
  }
}
