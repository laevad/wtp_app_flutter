import 'package:wtp_app/data/repository/helpers/auth/is_auth.dart';

const siteURL = 'http://192.168.176.225:8000/api';

Future<Map<String, String>> getHeader() async {
  return {
    'Content-Type': 'multipart/form-data',
    'Authorization': 'bearer ${await IsAuth.getData("token")}',
    'Accept': 'multipart/form-data'
  };
}

Future<Map<String, String>> getHeader1() async {
  return {
    'Content-Type': 'application/json',
    'Authorization': 'bearer ${await IsAuth.getData("token")}',
    'Accept': 'application/json'
  };
}
