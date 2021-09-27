import 'package:sales_app/models/general/reason_model.dart';
import 'package:sales_app/models/general/status_visit_plan_model.dart';
import 'package:sales_app/models/visit_plan/dto/visit_plan_saved_dto.dart';
import 'package:sales_app/models/visit_plan/list_visit_plan_model.dart';
import 'package:sales_app/models/visit_plan/visit_plan_add_model.dart';
import 'package:sales_app/models/visit_plan/visit_plan_check_in_model.dart';
import 'package:sales_app/models/visit_plan/visit_plan_list_sales.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/util/connection.dart';
import 'package:sales_app/util/util.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class VisitPlanProvider {
  Future<List<dynamic>> getListVp(String dateStart, String dateEnd) async {
    String session = await getSession();
    String id = await getIdUser();

    final queryParameters = {
      'id': id,
      'session': session,
      'start': dateStart,
      'end': dateEnd
    };
    final Connection checkConnection = Connection();
    final uri =
        Uri.http(apiHost, '/api/ver1/salesman/visitplan/list', queryParameters);

    List<ListVisitPlanModel> listVp = [];
    try {
      final bool connect = await checkConnection.initConnectivity();
      if (connect) {
        http.Response response =
            await http.get(uri, headers: {"apikey": apikey});

        var decode = json.decode(response.body);
        if (response.statusCode == 200 && decode['status'] == 1) {
          List<dynamic> listJsonVp = (decode as Map<String, dynamic>)['data'];
          for (int i = 0; i < listJsonVp.length; i++) {
            listVp.add(ListVisitPlanModel.fromJson(listJsonVp[i]));
          }

          return [true, listVp];
        } else {
          return [false, decode['data'].toString()];
        }
      } else {
        return [false, "No Internet Connection"];
      }
    } on SocketException {
      return [false, "Time Out Internet Connection"];
    } catch (error) {
      return [false, "Error"];
    }
  }

  Future<List<dynamic>> addVisitPlan(VisitPlanAddModel model) async {
    String session = await getSession();
    String id = await getIdUser();
    final Connection checkConnection = Connection();
    final queryParameters = {
      'id': id,
      'session': session,
    };

    final uri =
        Uri.http(apiHost, 'api/ver1/salesman/visitplan/add', queryParameters);

    var body = json.encode(model.toJson());
    final bool connect = await checkConnection.initConnectivity();

    try {
      if (connect) {
        http.Response response =
            await http.post(uri, headers: {"apikey": apikey}, body: body);
        var decode = json.decode(response.body);
        if (response.statusCode == 200 && decode['status'] == 1) {
          return [true, decode['data'].toString()];
        } else {
          return [false, decode['data'].toString()];
        }
      } else {
        return [false, "No Internet Connection"];
      }
    } on SocketException {
      return [false, "Time Out Internet Connection"];
    } catch (error) {
      return [false, "Error"];
    }
  }

  Future<List<dynamic>> checkInVisitPlan(
      VisitPlanCheckInModel model, String idVisitPlan) async {
    String session = await getSession();
    String id = await getIdUser();

    final queryParameters = {
      'id': id,
      'session': session,
      'visitplan': idVisitPlan
    };

    final uri = Uri.http(
        apiHost, '/api/ver1/salesman/visitplan/checkin', queryParameters);

    var body = json.encode(model.toJson());
    try {
      http.Response response =
          await http.post(uri, headers: {"apikey": apikey}, body: body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200 && decode['status'] == 1) {
        //List<dynamic> listResponse = (decode as Map<String, dynamic>)['data'];

        return [true, decode['data'].toString()];
      } else {
        return [false, decode['data'].toString()];
      }
    } on SocketException {
      return [false, "Time Out Internet Connection"];
    } catch (error) {
      return [false, "Error"];
    }
  }

  Future<bool> addSales(VisitPlanSavedDto model) async {
    String session = await getSession();
    String id = await getIdUser();
    final Connection checkConnection = Connection();
    final queryParameters = {
      'id': id,
      'session': session,
    };

    final uri =
        Uri.http(apiHost, '/api/ver1/salesman/sales/add', queryParameters);

    var body = json.encode(model.toJson());
    final bool connect = await checkConnection.initConnectivity();
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

  Future<List<dynamic>> getListSalesbyCust(String idCustomer) async {
    String session = await getSession();
    String id = await getIdUser();
    final Connection checkConnection = Connection();
    final queryParameters = {
      'id': id,
      'session': session,
      'customer': idCustomer,
    };
    final uri = Uri.http(
        apiHost, '/api/ver1/salesman/sales/list/customer', queryParameters);

    List<VisitPlanListSales> listSales = [];
    final bool connect = await checkConnection.initConnectivity();
    try {
      if (connect) {
        http.Response response =
            await http.get(uri, headers: {"apikey": apikey});
        var decode = json.decode(response.body);
        if (response.statusCode == 200 && decode['status'] == 1) {
          List<dynamic> listJsonSales =
              (decode as Map<String, dynamic>)['data'];

          //print(listJsonCustomer.length);
          for (int i = 0; i < listJsonSales.length; i++) {
            listSales.add(VisitPlanListSales.fromJson(listJsonSales[i]));
            //print(listJsonCustomer[i]);
          }

          return [true, listSales];
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

  Future<bool> updateStatusVisitPlan(String status, String visitPlanId) async {
    String session = await getSession();
    String id = await getIdUser();
    final Connection checkConnection = Connection();
    final queryParameters = {
      'id': id,
      'session': session,
      'visitplan': visitPlanId
    };
    final uri = Uri.http(
        apiHost, '/api/ver1/salesman/visitplan/update/status', queryParameters);

    Map credential = {'status': status};
    final bool connect = await checkConnection.initConnectivity();
    try {
      var body = json.encode(credential);
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

  Future<bool> checkout(
    String long,
    String lat,
    String visitPlanId,
  ) async {
    String session = await getSession();
    String id = await getIdUser();
    final Connection checkConnection = Connection();
    final queryParameters = {
      'id': id,
      'session': session,
      'visitplan': visitPlanId
    };

    final uri = Uri.http(
        apiHost, '/api/ver1/salesman/visitplan/checkout', queryParameters);
    Map credential = {'latitude': long, 'longitude': lat};
    var body = json.encode(credential);
    try {
      bool connect = await checkConnection.initConnectivity();

      if (connect) {
        http.Response response =
            await http.post(uri, headers: {"apikey": apikey}, body: body);
        var decode = json.decode(response.body);
        if (response.statusCode == 200 && decode['status'].toString() == "1") {
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

  Future<List<dynamic>> getStatusVisitPlan() async {
    final uri = Uri.http(apiHost, '/api/ver1/visitplan/status');
    final Connection checkConnection = Connection();
    List<StatusVisitPlanModel> listJsonVP = [];
    try {
      bool connect = await checkConnection.initConnectivity();
      if (connect) {
        http.Response response =
            await http.get(uri, headers: {"apikey": apikey});
        var decode = json.decode(response.body);

        if (response.statusCode == 200 && decode['status'] == 1) {
          List<dynamic> listJsonSales =
              (decode as Map<String, dynamic>)['data'];

          //print(listJsonCustomer.length);
          for (int i = 0; i < listJsonSales.length; i++) {
            listJsonVP.add(StatusVisitPlanModel.fromJson(listJsonSales[i]));
          }

          return [true, listJsonVP];
        } else {
          return [false, decode['data'].toString()];
        }
      } else {
        return [false, "No Internet Connection"];
      }
    } catch (error) {
      return [false, "error"];
    }
  }

  Future<List<dynamic>> getPendingReasonVisitPlan() async {
    final uri = Uri.http(apiHost, '/api/ver1/visitplan/pendingreason');
    final Connection checkConnection = Connection();
    List<ReasonModel> listJsonReasonVP = [];
    try {
      bool connect = await checkConnection.initConnectivity();
      if (connect) {
        http.Response response =
            await http.get(uri, headers: {"apikey": apikey});

        var decode = json.decode(response.body);

        if (response.statusCode == 200 && decode['status'] == 1) {
          List<dynamic> listJsonSales =
              (decode as Map<String, dynamic>)['data'];

          //print(listJsonCustomer.length);
          for (int i = 0; i < listJsonSales.length; i++) {
            listJsonReasonVP.add(ReasonModel.fromJson(listJsonSales[i]));
          }

          return [true, listJsonReasonVP];
        } else {
          return [false, decode["data"].toString()];
        }
      } else {
        return [false, "No Internet Connection"];
      }
    } catch (error) {
      return [false, "Error"];
    }
  }
}
