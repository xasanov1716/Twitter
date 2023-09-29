import 'package:twitter/data/models/universal_data.dart';
import 'package:twitter/data/network/secure_api_service.dart';
import 'package:twitter/service/service_locator.dart';

class ProfileRepository {

  ProfileRepository();

  Future<UniversalData> getUserData() async => getIt.get<SecureApiService>().getProfileData();
}
