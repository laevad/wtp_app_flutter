import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wtp_app/domain/entities/expense.dart';
import 'package:wtp_app/domain/entities/expense_type.dart';
import 'package:wtp_app/domain/entities/trip_start_end.dart';
import 'package:wtp_app/domain/repositories/expense/expense_repository.dart';

import '../../data_constants.dart';
import '../helpers/auth/is_auth.dart';

class DataExpenseRepository extends ExpenseRepository {
  @override
  Future<ExpenseModel> getAllIncentive(int page) async {
    String url = "${await IsAuth.getData('url')}/expense/expense?page=$page";
    Map<String, dynamic> body = {"user_id": await IsAuth.getData('id')};
    var response = await http.post(Uri.parse(url),
        headers: await getHeader1(), body: jsonEncode(body));

    if (response.statusCode == 200) {
      return ExpenseModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to getAllIncentive");
  }

  @override
  Future<ExpenseTypeModel> getExpenseTypeModel() async {
    String url = "${await IsAuth.getData('url')}/expense/expense";
    var response = await http.get(Uri.parse(url), headers: await getHeader1());

    if (response.statusCode == 200) {
      return ExpenseTypeModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to getExpenseTypeModel");
  }

  @override
  Future<TripStartEndModel> getTripStartEndModel() async {
    String url = "${await IsAuth.getData('url')}/expense/booking-s-e";
    Map<String, dynamic> body = {"user_id": await IsAuth.getData('id')};
    var response = await http.post(Uri.parse(url),
        headers: await getHeader1(), body: jsonEncode(body));
    if (response.statusCode == 200) {
      return TripStartEndModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to getAllIncentive");
  }
}
