import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sales_app/models/spesification/list_all_truck_model.dart';

import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/util/connection.dart';

class SpesificationProvider {
  Future<List<dynamic>> getAllProduct() async {
    final queryParameters = {'pusatid': "1", 'optional': "4"};

    final uri = Uri.http(apiHost, '/api/ver1/product/all', queryParameters);
    final Connection checkConnection = Connection();

    List<ListAllTruckModel> listAllProductDetail = [];
    final bool connect = await checkConnection.initConnectivity();
    try {
      if (connect) {
        http.Response response =
            await http.get(uri, headers: {"apikey": apikey});

        var decode = json.decode(response.body);

        if (response.statusCode == 200 && decode['status'] == 1) {
          List<dynamic> listJsonSubType =
              (decode as Map<String, dynamic>)['data'];

          for (int i = 0; i < listJsonSubType.length; i++) {
            listAllProductDetail
                .add(ListAllTruckModel.fromJson(listJsonSubType[i]));
          }
          return [true, listAllProductDetail];
        } else {
          return [false, decode['data'].toString()];
        }
      } else {
        return [false, "No Internet Connection"];
      }
    } catch (error) {
      return [false, "Error"];
    }
  }

  // Future<List<dynamic>> getListSpesification() async {
  //   final uri = Uri.http(apiHost, '/api/ver1/product/category');

  //   List<ListTruckModel> listSpesification = [];
  //   try {
  //     http.Response response = await http.get(uri, headers: {"apikey": apikey});
  //     var decode = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       List<dynamic> listJsonSpesification =
  //           (decode as Map<String, dynamic>)['data'];
  //       print(listJsonSpesification);

  //       for (int i = 0; i < listJsonSpesification.length; i++) {
  //         listSpesification
  //             .add(ListTruckModel.createList(listJsonSpesification[i]));
  //       }
  //     } else {
  //       return listSpesification;
  //     }
  //   } catch (error) {
  //     return listSpesification;
  //   }
  //   return listSpesification;
  // }

  // Future<List<ListTruckTypeModel>> getListTruckType(String category) async {
  //   String idPusat = await getIdPusat();

  //   final queryParameters = {
  //     'pusat': idPusat,
  //     'category': category,
  //   };
  //   final uri = Uri.http(host, '/api/ver1/product/type', queryParameters);

  //   List<ListTruckTypeModel> listTruckType = [];
  //   try {
  //     http.Response response = await http.get(uri, headers: {"apikey": apikey});

  //     var decode = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       List<dynamic> listJsonTrucktype =
  //           (decode as Map<String, dynamic>)['data'];

  //       for (int i = 0; i < listJsonTrucktype.length; i++) {
  //         listTruckType
  //             .add(ListTruckTypeModel.createList(listJsonTrucktype[i]));
  //       }
  //     } else {
  //       return listTruckType;
  //     }
  //   } catch (error) {
  //     return listTruckType;
  //   }
  //   return listTruckType;
  // }

  // Future<List<ListSubTypeModel>> getListSubType(String type) async {

  //   final queryParameters = {
  //     'type': type,
  //   };
  //   final uri = Uri.http(host, '/api/ver1/product/subtype', queryParameters);

  //   List<ListSubTypeModel> listSubType = [];
  //   try {
  //     http.Response response = await http.get(uri, headers: {"apikey": apikey});

  //     var decode = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       List<dynamic> listJsonSubType =
  //           (decode as Map<String, dynamic>)['data'];
  //       print(listJsonSubType);

  //       for (int i = 0; i < listJsonSubType.length; i++) {
  //         listSubType.add(ListSubTypeModel.createList(listJsonSubType[i]));
  //       }
  //     } else {
  //       return listSubType;
  //     }
  //   } catch (error) {
  //     return listSubType;
  //   }
  //   return listSubType;
  // }

  // Future<List<dynamic>> getProductDetail(String product) async {
  //   final queryParameters = {
  //     'product': product,
  //   };
  //   final uri = Uri.http(apiHost, '/api/ver1/product/detail', queryParameters);
  //   final Connection checkConnection = Connection();
  //   List<ListTruckDetailModel> listProductDetail = [];

  //   final bool connect = await checkConnection.initConnectivity();
  //   try {
  //     if (connect) {
  //       http.Response response =
  //           await http.get(uri, headers: {"apikey": apikey});

  //       var decode = json.decode(response.body);
  //       if (response.statusCode == 200 && decode['status'] == 1) {
  //         List<dynamic> listJsonSubType =
  //             (decode as Map<String, dynamic>)['data'];

  //         for (int i = 0; i < listJsonSubType.length; i++) {
  //           listProductDetail
  //               .add(ListTruckDetailModel.createList(listJsonSubType[i]));
  //         }
  //         return [true, listProductDetail];
  //       }
  //       return [false, decode['data'].toString()];
  //     } else {
  //       return [false, "No Internet Connection"];
  //     }
  //   } catch (error) {
  //     return listProductDetail;
  //   }
  // }
}
