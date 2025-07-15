import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}

