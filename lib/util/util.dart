import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

void saveDataUser(String session, String id, String pusat, String cabang,
    String subcabang) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  pref.setString("session", session);
  pref.setString("id", id);
  pref.setString("pusat", pusat);
  pref.setString("cabang", cabang);
  pref.setString("subcabang", subcabang);
}

void deleteSession() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}

Future<String> getSession() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("session") ?? "";
}

Future<String> getIdPusat() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("pusat") ?? "ID Pusat null";
}

Future<String> getIdUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("id") ?? "ID null";
}

String dateFormat() {
  DateTime now = DateTime.now();
  String currentDate = DateFormat('y-MM-dd').format(now);
  var parsedDate = DateTime.parse(currentDate);
  var formatter = DateFormat('dd MMM yyyy');
  String formatted = formatter.format(parsedDate);
  return formatted;
}

String timeFormatPlus(int month) {
  DateTime now = DateTime.now();
  var newDate = DateTime(now.year, now.month + month, now.day);
  String currentDate = DateFormat('y-MM-dd').format(newDate);
  // var parsedDate = DateTime.parse(currentDate);
  // var formatter = new DateFormat('kk:mm');
  // String formatted = formatter.format(parsedDate);
  return currentDate.toString();
}

String trimDate(String date, String delimiterParams) {
  String delimiter = delimiterParams;
  int lastIndex = date.indexOf(delimiter);
  String trimmed = date.substring(0, lastIndex);
  return trimmed;
}

Future<bool> getPermissionCamera() async {
  final serviceStatus = await Permission.camera.status;
  final serviceStatus1 = await Permission.microphone;
  final serviceStatus2 = await Permission.speech;
  final PermissionStatus request = await Permission.camera.request();
  final PermissionStatus request1 = await Permission.microphone.request();
  final PermissionStatus request2 = await Permission.speech.request();
  print(serviceStatus);
  if (request == PermissionStatus.granted &&
      request1 == PermissionStatus.granted &&
      request2 == PermissionStatus.granted) {
    print('Permission granted');
    return true;
  } else if (request == PermissionStatus.denied &&
      request1 == PermissionStatus.denied &&
      request2 == PermissionStatus.denied) {
    print('Permission denied. Show a dialog and again ask for the permission');
    return false;
  } else if (request == PermissionStatus.permanentlyDenied &&
      request1 == PermissionStatus.permanentlyDenied &&
      request2 == PermissionStatus.permanentlyDenied) {
    print('Take the user to the settings page.');
    await openAppSettings();
    return false;
  } else {
    return false;
  }
}

Future<bool> getPermissionLocation() async {
  final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
  print(serviceStatus);
  final isGpsOn = serviceStatus == ServiceStatus.enabled;
  if (!isGpsOn) {
    print('Turn on location services before requesting permission.');
    return false;
  }

  final status = await Permission.locationWhenInUse.request();
  if (status == PermissionStatus.granted) {
    print('Permission granted');
    return true;
  } else if (status == PermissionStatus.denied) {
    print('Permission denied. Show a dialog and again ask for the permission');
    return false;
  } else if (status == PermissionStatus.permanentlyDenied) {
    print('Take the user to the settings page.');
    await openAppSettings();
    return false;
  } else {
    return false;
  }
}
