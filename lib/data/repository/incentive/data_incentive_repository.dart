import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wtp_app/domain/entities/incentive.dart';
import 'package:wtp_app/domain/repositories/incentive/incentive_repository.dart';

import '../../data_constants.dart';

class DataIncentiveRepository extends IncentiveRepository {
  @override
  Future<IncentiveModel> getAllIncentive(int page) async {
    String url = "$siteURL/incentive/incentive?page=$page";
    var response = await http.get(Uri.parse(url), headers: await getHeader1());

    if (response.statusCode == 200) {
      return IncentiveModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load");
  }
}
