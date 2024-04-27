import 'package:blog_app/models/blog.dart';

abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class AddArticle extends ArticleEvent {
  final Blog blog;

  AddArticle(this.blog);
}

class UpdateArticle extends ArticleEvent {
  final Blog blog;

  UpdateArticle(this.blog);
}

class DeleteArticles extends ArticleEvent {
  final Blog blog;

  DeleteArticles(this.blog);
}
