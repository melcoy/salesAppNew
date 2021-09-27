import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sales_app/models/dashboard/dashboard_model.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/util/connection.dart';
import 'package:sales_app/util/util.dart';

class DashboardProvider {
  Future<List<dynamic>> getDashboardData(
      String dateStart, String dateEnd) async {
    String session = await getSession();
    String id = await getIdUser();
    final queryParameters = {
      'id': id,
      'session': session,
      'start': dateStart,
      'end': dateEnd
    };
    final Connection checkConnection = Connection();

    final uri = Uri.http(apiHost, '/api/ver1/salesman/kpi/', queryParameters);

    try {
      final bool connect = await checkConnection.initConnectivity();
      if (connect) {
        http.Response response =
            await http.get(uri, headers: {"apikey": apikey});
        var decode = json.decode(response.body);

        if (response.statusCode == 200 && decode['status'] == 1) {
          DashboardModel model = DashboardModel.fromJson(decode['data'][0]);

          return [true, model];
        } else {
          return [false, decode['data'].toString()];
        }
      } else {
        return [false, "No Internet Connection"];
      }
    } on SocketException catch (error) {
      return [false, "Time Out Internet Connection"];
    } catch (error) {
      return [false, "Error"];
    }
  }

  // Future<List<DashboardTotalSalesModel>> getTotalReportSales() async {
  //   String session = await getSession();
  //   String id = await getIdUser();
  //   final queryParameters = {
  //     'id': id,
  //     'session': session,
  //   };
  //   final uri =
  //       Uri.http(host, '/api/ver1/salesman/sales/total', queryParameters);

  //   List<DashboardTotalSalesModel> listReport = [];
  //   try {
  //     http.Response response = await http.get(uri, headers: {"apikey": apikey});
  //     var decode = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       List<dynamic> listJsonReport = (decode as Map<String, dynamic>)['data'];
  //       for (int i = 0; i < listJsonReport.length; i++) {
  //         listReport.add(DashboardTotalSalesModel.fromJson(listJsonReport[i]));
  //       }
  //     } else {
  //       return listReport;
  //     }
  //   } catch (error) {
  //     return listReport;
  //   }
  //   return listReport;
  // }
}
