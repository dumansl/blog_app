import 'package:blog_app/models/blog.dart';

abstract class ArticleState {}

class ArticlesNotLoaded extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Blog> blogs;

  ArticlesLoaded({required this.blogs});
}

class ArticlesLoading extends ArticleState {}

class ArticlesLoadFail extends ArticleState {}

class ArticleAdded extends ArticleState {
  final bool isAdded;

  ArticleAdded({required this.isAdded});
}
