import 'package:blog_app/blocs/articles/article_bloc.dart';
import 'package:blog_app/pages/pages.dart';
import 'package:blog_app/repositories/article_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleBloc(articleRepository: ArticleRepository()),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffF4F4F4),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xffF4F4F4),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
