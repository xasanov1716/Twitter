import 'package:twitter/data/network/open_api_service.dart';
import 'package:twitter/data/network/secure_api_service.dart';
import 'package:twitter/service/service_locator.dart';

import '../local/storage_repository.dart';
import '../models/universal_data.dart';
import '../models/user/user_model.dart';

class AuthRepository {

  AuthRepository();

  Future<UniversalData> sendCodeToGmail({
    required String gmail,
    required String password,
  }) async =>
      getIt.get<OpenApiService>().sendCodeToGmail(
        gmail: gmail,
        password: password,
      );

  Future<UniversalData> confirmCode({required String code}) async =>
      getIt.get<OpenApiService>().confirmCode(code: code);

  Future<UniversalData> registerUser({required UserModel userModel}) async =>
      getIt.get<OpenApiService>().registerUser(userModel: userModel);

  Future<UniversalData> loginUser({
    required String gmail,
    required String password,
  }) async =>
      getIt.get<OpenApiService>().loginUser(
        gmail: gmail,
        password: password,
      );

  String getToken() => StorageRepository.getString("token");

  Future<bool?> deleteToken() async => StorageRepository.deleteString("token");

  Future<void> setToken(String newToken) async =>
      StorageRepository.putString("token", newToken);
}
