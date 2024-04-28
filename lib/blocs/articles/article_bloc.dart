import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blog_app/blocs/articles/article_event.dart';
import 'package:blog_app/blocs/articles/article_state.dart';
import 'package:blog_app/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc({required this.articleRepository}) : super(ArticlesNotLoaded()) {
    on<FetchArticles>(_fetchArticles);
    on<AddArticle>(_addArticles);
    on<UpdateArticle>(_updatedArticles);
    on<DeleteArticles>(_deleteArticles);
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

  void _addArticles(AddArticle event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    try {
      final isAdded = await articleRepository.addArticle(
        title: event.blog.title!,
        content: event.blog.content!,
        author: event.blog.author!,
        image:
            event.blog.thumbnail != null ? XFile(event.blog.thumbnail!) : null,
      );
      emit(ArticleAdded(isAdded: isAdded));
    } catch (_) {
      emit(ArticlesAddLoadFail());
    }
  }

  void _updatedArticles(UpdateArticle event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    try {
      final isUpdated = await articleRepository.updateArticle(
        id: event.blog.id!,
        title: event.blog.title!,
        content: event.blog.content!,
        author: event.blog.author!,
        thumbnail: event.blog.thumbnail,
      );
      emit(ArticleUpdated(isUpdated: isUpdated));
    } catch (_) {
      emit(ArticleUpdateLoadFailed());
    }
  }

  void _deleteArticles(DeleteArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    try {
      final isDeleted = await articleRepository.deleteArticle(event.blog.id!);
      emit(ArticleDeleted(isDeleted: isDeleted));
    } catch (_) {
      emit(ArticleDeletedLoadFailed());
    }
  }
}
