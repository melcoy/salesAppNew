import 'package:sales_app/api/general/general_provider.dart';

class GeneralRepo {
  final GeneralProvider _generalProvider = GeneralProvider();
  Future<List<dynamic>> fetchGetListProv() => _generalProvider.getListProv();
  Future<List<dynamic>> fetchgetListKota() => _generalProvider.getListKota();
}
