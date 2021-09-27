import 'auth_provider.dart';

class ApiLoginRepo {
  final ApiLoginProvider _apiLoginProvider = ApiLoginProvider();

  Future<List<dynamic>> fetchUserLogin(String email, String password) =>
      _apiLoginProvider.getUserLogin(email, password);
}
