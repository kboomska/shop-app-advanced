import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:shop_app/Library/localization_storage.dart';

class DateTimeService {
  final _localeStorage = LocalizationStorage();

  late DateFormat _dateFormat;
  late DateFormat _yearFormat;

  void _setupLocale(Locale locale) {
    if (!_localeStorage.isLocaleUpdated(locale)) return;

    _dateFormat = DateFormat.MMMMd(_localeStorage.localeTag);
    _yearFormat = DateFormat.y(_localeStorage.localeTag);
  }

  String getDate(Locale locale) {
    _setupLocale(locale);
    return '${_dateFormat.format(DateTime.now())}, ${_yearFormat.format(DateTime.now())}';
  }
}
