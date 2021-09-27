import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sales_app/models/auth/user_login.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/util/connection.dart';

class ApiLoginProvider {
  Future<List<dynamic>> getUserLogin(String email, String password) async {
    final Uri uri = Uri.http(apiHost, '/api/ver1/salesman/login');
    Map credential = {'email': email, 'password': password};
    final Connection checkConnection = Connection();
    print(uri);
    try {
      String body = json.encode(credential);
      final bool connect = await checkConnection.initConnectivity();
      if (connect) {
        http.Response response =
            await http.post(uri, headers: {"apikey": apikey}, body: body);

        final dynamic decode =
            json.decode(response.body) as Map<String, dynamic>;

        final UserLogin model =
            UserLogin.loginUser(decode['data'][0] as Map<String, dynamic>);

        if (response.statusCode == 200 && decode['status'] == 1) {
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
      return [false, error.toString()];
    }
  }
}
