import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blog_app/models/blog.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ArticleRepository {
  Future<List<Blog>> fetchAll() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    final response = await http.get(url);

    final List body = json.decode(response.body);

    return body.map((element) => Blog.fromJson(element)).toList();
  }

  Future<bool> addArticle({
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
        return true;
      } else {
        return false;
      }
    } catch (error) {
      debugPrint('Network error: $error');
      return false;
    }
  }
}
