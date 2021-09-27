import 'dart:convert';
import 'dart:io';

import 'package:sales_app/models/customer/customer_add_model.dart';
import 'package:sales_app/models/customer/list_customer_model.dart';
import 'package:sales_app/models/visit_plan/visit_plan_add_model.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/util/connection.dart';
import 'package:sales_app/util/util.dart';
import 'package:http/http.dart' as http;

class CustomerProvider {
  Future<List<dynamic>> getListCustomer() async {
    String session = await getSession();
    String id = await getIdUser();
    final Connection checkConnection = Connection();

    final queryParameters = {
      'id': id,
      'session': session,
    };
    final uri =
        Uri.http(apiHost, '/api/ver1/salesman/customer/list', queryParameters);

    List<ListCustomerModel> listCustomer = [];
    final bool connect = await checkConnection.initConnectivity();
    try {
      if (connect) {
        http.Response response =
            await http.get(uri, headers: {"apikey": apikey});
        var decode = json.decode(response.body);
        if (response.statusCode == 200 && decode['status'] == 1) {
          List<dynamic> listJsonCustomer =
              (decode as Map<String, dynamic>)['data'];

          //print(listJsonCustomer.length);
          for (int i = 0; i < listJsonCustomer.length; i++) {
            listCustomer.add(ListCustomerModel.createList(listJsonCustomer[i]));
            print(listCustomer[i]);
          }

          return [true, listCustomer];
        } else {
          return [false, decode['data'].toString()];
        }
      } else {
        return [false, "No Internet Connection"];
      }
    } on SocketException {
      return [false, "Time Out Internet Connection"];
    } catch (error) {
      return [false, error.toString()];
    }
  }

  Future<bool> addCustomer(CustomerAddModel model) async {
    String session = await getSession();
    String id = await getIdUser();
    final Connection checkConnection = Connection();

    final queryParameters = {
      'id': id,
      'session': session,
    };
    final bool connect = await checkConnection.initConnectivity();
    final uri =
        Uri.http(apiHost, '/api/ver1/salesman/customer/add', queryParameters);

    var body = json.encode(model.toJson());
    try {
      if (connect) {
        http.Response response =
            await http.post(uri, headers: {"apikey": apikey}, body: body);
        var decode = json.decode(response.body);
        if (response.statusCode == 200 && decode['status'] == 1) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
