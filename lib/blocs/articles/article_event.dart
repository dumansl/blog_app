import 'package:blog_app/models/blog.dart';

abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class AddArticle extends ArticleEvent {
  final Blog blog;

  AddArticle(this.blog);
}
