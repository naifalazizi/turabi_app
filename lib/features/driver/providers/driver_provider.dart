import 'package:flutter/material.dart';
import '../../../shared/models/booking_model.dart';

class DriverProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isAvailable = true;
  List<BookingModel> _availableJobs = [];
  List<BookingModel> _myJobs = [];

  bool get isLoading => _isLoading;
  bool get isAvailable => _isAvailable;
  List<BookingModel> get availableJobs => _availableJobs;
  List<BookingModel> get myJobs => _myJobs;

  void toggleAvailability() {
    _isAvailable = !_isAvailable;
    notifyListeners();
  }

  Future<void> loadAvailableJobs() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      // Load available jobs from API
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> acceptJob(String jobId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      // Accept job logic
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

