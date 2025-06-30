import 'package:flutter/material.dart';
import 'package:water_saver/models/user_info.dart';

class PersonalInfoController extends ChangeNotifier {
  String? _expandedField;
  UserInfo _userInfo = UserInfo();
  bool _isLoading = false;

  final Map<String, TextEditingController> _controllers = {
    'Name': TextEditingController(),
    'Surname': TextEditingController(),
    'Email': TextEditingController(),
    'Contact': TextEditingController(),
    'Country': TextEditingController(),
    'State': TextEditingController(),
    'Pin': TextEditingController(),
    'Address': TextEditingController(),
  };

  String? get expandedField => _expandedField;
  UserInfo get userInfo => _userInfo;
  bool get isLoading => _isLoading;
  Map<String, TextEditingController> get controllers => _controllers;

  void toggleField(String field) {
    if (_expandedField == field) {
      _expandedField = null;
    } else {
      _expandedField = field;
      if (_controllers[field] != null) {
        _controllers[field]!.text = _userInfo.getFieldValue(field);
      }
    }
    notifyListeners();
  }

  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^[\+]?[1-9][\d]{0,15}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  String? validateField(String field, String value) {
    if (value.trim().isEmpty) {
      return '$field cannot be empty';
    }

    switch (field) {
      case 'Email':
        if (!isValidEmail(value)) {
          return 'Please enter a valid email address';
        }
        break;
      case 'Contact':
        if (!isValidPhoneNumber(value)) {
          return 'Please enter a valid phone number';
        }
        break;
      case 'Pin':
        if (!RegExp(r'^\d{6}$').hasMatch(value)) {
          return 'Pin must be exactly 6 digits';
        }
        break;
    }
    return null;
  }

  Future<String?> handleFieldSave(String field) async {
    final value = _controllers[field]!.text.trim();
    if (value.isEmpty) {
      return '$field cannot be empty';
    }

    final validationError = validateField(field, value);
    if (validationError != null) {
      return validationError;
    }

    _userInfo.setFieldValue(field, value);
    _expandedField = null;
    notifyListeners();
    return null; 
  }

  void cancelFieldEdit() {
    _expandedField = null;
    notifyListeners();
  }

  String getFieldDisplayValue(String fieldName) {
    return _userInfo.getFieldValue(fieldName);
  }

  bool hasFieldValue(String fieldName) {
    return _userInfo.getFieldValue(fieldName).isNotEmpty;
  }

  TextInputType getKeyboardType(String field) {
    switch (field) {
      case 'Email':
        return TextInputType.emailAddress;
      case 'Contact':
      case 'Pin':
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
