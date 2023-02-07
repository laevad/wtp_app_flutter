import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/entities/expense.dart';
import '../../../domain/entities/expense_type.dart';
import '../../../domain/entities/trip_start_end.dart';
import '../../../domain/repositories/expense/expense_repository.dart';
import '../../data_constants.dart';
import '../helpers/auth/is_auth.dart';

class DataExpenseRepository extends ExpenseRepository {
  @override
  Future<ExpenseModel> getAllIncentive(int page) async {
    String url = "${await IsAuth.getData('url')}/expense/expense?page=$page";
    print(url);
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

  @override
  Future<ExpenseModel> addExpense(String expenseTypeId, String bookingId,
      String amount, String description, String image_path) async {
    print("image path=====================$image_path");
    print("PRINT TST: $expenseTypeId");
    String url = "${await IsAuth.getData('url')}/expense/add-expense";

    Map<String, String> body = {
      "expense_type_id":
          expenseTypeId != "null" ? int.parse(expenseTypeId).toString() : "",
      "amount": amount != "null"
          ? amount.isNotEmpty
              ? double.parse(amount).toString()
              : ""
          : "",
      "description": description == "null" ? "" : description,
      "booking_id": bookingId == "null" ? "" : bookingId,
    };

    // var response = await http.post(Uri.parse(url),
    //     headers: await getHeader1(), body: jsonEncode(body));

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers.addAll(await getHeader1())
      ..fields.addAll(body)
      ..files.add(await http.MultipartFile.fromPath('image_path', image_path));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    final result = await jsonDecode(response.body) as Map<String, dynamic>;
    print(result);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 422) {
      return ExpenseModel.fromJsonError(
        jsonDecode(response.body),
        response.statusCode,
      );
    }
    throw Exception("failed to addExpense");
  }
}
