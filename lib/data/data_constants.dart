import 'repository/helpers/auth/is_auth.dart';

// const siteURL = 'http://192.168.210.54:8000/api';
const yetToStart = 1;
const complete = 2;
const ongoing = 3;
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
