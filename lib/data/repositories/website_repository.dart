
import 'package:twitter/data/models/universal_data.dart';
import 'package:twitter/data/models/websites/website_model.dart';
import 'package:twitter/data/network/open_api_service.dart';
import 'package:twitter/data/network/secure_api_service.dart';
import 'package:twitter/service/service_locator.dart';

class WebsiteRepository {

  WebsiteRepository();

  Future<UniversalData> getWebsites() async => getIt.get<OpenApiService>().getWebsites();

  Future<UniversalData> getWebsiteById(int websiteId) async =>
      getIt.get<OpenApiService>().getWebsiteById(websiteId);

  Future<UniversalData> createWebsite(WebsiteModel newWebsite) async =>
      getIt.get<SecureApiService>().createWebsite(websiteModel: newWebsite);
}
