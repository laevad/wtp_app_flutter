import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wtp_app/domain/entities/incentive.dart';
import 'package:wtp_app/domain/repositories/incentive/incentive_repository.dart';

import '../../data_constants.dart';
import '../helpers/auth/is_auth.dart';

class DataIncentiveRepository extends IncentiveRepository {
  @override
  Future<IncentiveModel> getAllIncentive(int page) async {
    String url =
        "${await IsAuth.getData('url')}/incentive/incentive?page=$page";
    Map<String, dynamic> body = {"user_id": await IsAuth.getData('id')};
    var response = await http.post(Uri.parse(url),
        headers: await getHeader1(), body: jsonEncode(body));

    if (response.statusCode == 200) {
      return IncentiveModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load");
  }
}
