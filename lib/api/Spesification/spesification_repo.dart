import 'package:sales_app/api/Spesification/spesification_provider.dart';

class SpesificationRepo {
  final SpesificationProvider _spesificationProvider = SpesificationProvider();

  // Future<List<ListTruckModel>> fetchListSpesification() =>
  //     _spesificationProvider.getListSpesification();

  // Future<List<ListTruckTypeModel>> fetchListTruckType(String category) =>
  //     _spesificationProvider.getListTruckType(category);

  // Future<List<ListSubTypeModel>> getListSubType(String type) =>
  //     _spesificationProvider.getListSubType(type);

  // Future<List<ListTruckDetailModel>> getProductDetail(String product) =>
  //     _spesificationProvider.getProductDetail(product);

  Future<List<dynamic>> fetchAllProductDetail() =>
      _spesificationProvider.getAllProduct();
}
