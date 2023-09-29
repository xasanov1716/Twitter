import 'package:twitter/data/models/articles/articles_model.dart';
import 'package:twitter/data/models/universal_data.dart';
import 'package:twitter/data/network/open_api_service.dart';
import 'package:twitter/data/network/secure_api_service.dart';
import 'package:twitter/service/service_locator.dart';

class ArticleRepositories{



 ArticleRepositories();

 Future<UniversalData> getArticle()=>getIt.get<OpenApiService>().getAllArticles();


 Future<UniversalData> createArticle(ArticleModel newArticleModel) async =>
     getIt.get<SecureApiService>().addArticle(articleModel: newArticleModel);
}