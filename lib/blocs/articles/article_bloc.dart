import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blog_app/blocs/articles/article_event.dart';
import 'package:blog_app/blocs/articles/article_state.dart';
import 'package:blog_app/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc({required this.articleRepository}) : super(ArticlesNotLoaded()) {
    on<FetchArticles>(_fetchArticles);
    on<AddArticle>(_onAddArticle);
  }

  void _fetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    try {
      final blogs = await articleRepository.fetchAll();
      emit(ArticlesLoaded(blogs: blogs));
    } catch (e) {
      emit(ArticlesLoadFail());
    }
  }

  Future<void> _onAddArticle(
      AddArticle event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    try {
      final isAdded = await articleRepository.addArticle(
        title: event.blog.title!,
        content: event.blog.content!,
        author: event.blog.author!,
        image: event.blog.thumbnail != null
            ? XFile(event.blog.thumbnail!) // XFile olarak işle
            : null, // Eğer resim yoksa null olarak bırak
      );
      emit(ArticleAdded(isAdded: isAdded));
    } catch (_) {
      emit(ArticlesLoadFail());
    }
  }
}
