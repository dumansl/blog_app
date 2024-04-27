import 'package:blog_app/models/blog.dart';

abstract class ArticleState {}

// get metodu
class ArticlesNotLoaded extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Blog> blogs;

  ArticlesLoaded({required this.blogs});
}

class ArticlesLoading extends ArticleState {}

class ArticlesLoadFail extends ArticleState {}

// post metodu
class ArticleAdded extends ArticleState {
  final bool isAdded;

  ArticleAdded({required this.isAdded});
}

class ArticlesAddLoadFail extends ArticleState {}

// push metodu

class ArticleUpdated extends ArticleState {
  final bool isUpdated;

  ArticleUpdated({required this.isUpdated});
}

class ArticleUpdateLoadFailed extends ArticleState {}

// delete metodu

class ArticleDeleted extends ArticleState {
  final bool isDeleted;

  ArticleDeleted({required this.isDeleted});
}

class ArticleDeletedLoadFailed extends ArticleState {}
