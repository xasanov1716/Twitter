import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/cubits/article_add/article_add_state.dart';
import 'package:twitter/data/models/articles/articles_model.dart';
import 'package:twitter/data/repositories/article_repositories.dart';
import 'package:twitter/utils/ui_utils/loading_dialog.dart';

import '../../data/models/universal_data.dart';
import '../../service/service_locator.dart';

class ArticleAddCubit extends Cubit<ArticleAddState> {
  ArticleAddCubit(this.articleRepositories) : super(ArticleInitial());

 final ArticleRepositories articleRepositories;

  createArticles({required ArticleModel articleModel}) async {
    emit(ArticleAddLoadingState());
    UniversalData universalData =
    await articleRepositories.createArticle(articleModel);
    UniversalData universalData2 = await articleRepositories.getArticle();
    if (universalData.error.isEmpty) {
      emit(ArticleAddSuccessCreateState(
          articleModels: universalData2.data as List<ArticleModel>));
    } else {
      emit(ArticleAddErrorState(errorText: universalData.error));
    }
  }
}