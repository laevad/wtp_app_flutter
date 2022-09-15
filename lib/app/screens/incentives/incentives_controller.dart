import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class IncentivesController extends Controller {
  DateTime? _date;

  String dateString() {
    if (_date == null) {
      return "${DateTime.now().day.toString()} - ${DateTime.now().month.toString()} - ${DateTime.now().year.toString()}";
    } else {
      return '${_date?.day} - ${_date?.month} - ${_date?.year}';
    }
  }

  @override
  void initListeners() {}

  selectDate() async {
    final dateRes = await showDatePicker(
        context: getContext(),
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));

    if (dateRes != null) {
      _date = dateRes;
      refreshUI();
    }
  }
}
