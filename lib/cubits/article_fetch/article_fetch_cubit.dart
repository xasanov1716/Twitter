import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:twitter/data/models/articles/articles_model.dart';
import 'package:twitter/data/models/universal_data.dart';
import 'package:twitter/data/repositories/article_repositories.dart';
import 'package:twitter/service/service_locator.dart';

part 'article_fetch_state.dart';

class ArticleFetchCubit extends Cubit<ArticleFetchState> {
  ArticleFetchCubit(this.articleRepositories) : super(ArticleInitial());


  final ArticleRepositories articleRepositories;



 Future<void> fetchArticle()async{
   emit(ArticleLoadingState());
   UniversalData universalData = await articleRepositories.getArticle();
   if(universalData.error.isEmpty){
     emit(ArticleGetState(articleModel: universalData.data as List<ArticleModel>));
   }else{
     emit(ArticleErrorState(errorText: universalData.error));
   }
 }




}
