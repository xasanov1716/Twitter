import 'package:get_it/get_it.dart';
import 'package:twitter/data/network/open_api_service.dart';
import 'package:twitter/data/network/secure_api_service.dart';

final getIt = GetIt.instance;

void getItSetup(){

  getIt.registerLazySingleton<OpenApiService>(() => OpenApiService());

  getIt.registerLazySingleton<SecureApiService>(() => SecureApiService());

}
















