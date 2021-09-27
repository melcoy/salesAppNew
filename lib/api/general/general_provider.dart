import 'dart:convert';

import 'package:sales_app/models/general/kota_model.dart';
import 'package:sales_app/models/general/provinsi_model.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:http/http.dart' as http;
import 'package:sales_app/util/connection.dart';

class GeneralProvider {
  Future<List<dynamic>> getListKota() async {
    final uri = Uri.http(apiHost, '/api/ver1/kota');
    final Connection checkConnection = Connection();
    List<KotaModel> listJsonKota = [];
    try {
      bool connect = await checkConnection.initConnectivity();
      if (connect) {
        http.Response response =
            await http.get(uri, headers: {"apikey": apikey});
        var decode = json.decode(response.body);

        if (response.statusCode == 200) {
          //listJsonKota = (decode as Map<String, dynamic>)['data'];

          // for (int i = 0; i < listJsonKota.length; i++)
          //   listKota.add(KotaModel.createCity(listJsonKota[i]));
          List<dynamic> listJson = (decode as Map<String, dynamic>)['data'];

          //print(listJsonCustomer.length);
          for (int i = 0; i < listJson.length; i++) {
            listJsonKota.add(KotaModel.createCity(listJson[i]));
          }

          return [true, listJsonKota];
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

  Future<List<dynamic>> getListProv() async {
    final uri = Uri.http(apiHost, '/api/ver1/provinsi');
    final Connection checkConnection = Connection();
    //List<ProvinsiModel> listProv = [];
    List<ProvinsiModel> listJsonProv = [];
    try {
      bool connect = await checkConnection.initConnectivity();
      if (connect) {
        http.Response response =
            await http.get(uri, headers: {"apikey": apikey});
        var decode = json.decode(response.body);
        if (response.statusCode == 200) {
          List<dynamic> listJson = (decode as Map<String, dynamic>)['data'];

          for (int i = 0; i < listJson.length; i++) {
            listJsonProv.add(ProvinsiModel.createProv(listJson[i]));
          }

          return [true, listJsonProv];
        } else {
          return [false, decode["data"].toString()];
        }
      } else {
        return [false, "No Internet Connection"];
      }
    } catch (error) {
      print("Error Prov" + error.toString());
      return [false, "Error"];
    }
  }
}
