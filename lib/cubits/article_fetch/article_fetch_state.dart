part of 'article_fetch_cubit.dart';

@immutable
abstract class ArticleFetchState extends Equatable {}

class ArticleInitial extends ArticleFetchState {
  @override
  List<Object?> get props => [];
}

class ArticleLoadingState extends ArticleInitial{}

class ArticleGetState extends ArticleFetchState {

  ArticleGetState({required this.articleModel});

 final List<ArticleModel> articleModel;

  @override
  List<Object?> get props => [articleModel];
}


class ArticleErrorState extends ArticleFetchState {

  ArticleErrorState({required this.errorText});

 final String errorText;

  @override
  List<Object?> get props => [];
}
