import 'package:flutter/material.dart';

import 'package:shop_app/domain/services/date_time_service.dart';

class ShoppingCartScreenViewModel extends ChangeNotifier {
  final _dateTimeService = DateTimeService();

  String _date = '';
  String get date => _date;

  void getDate(Locale locale) {
    _date = _dateTimeService.getDate(locale);
    notifyListeners();
  }
}
