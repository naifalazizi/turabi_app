import 'package:flutter/material.dart';
import '../../../shared/models/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<BookingModel> _bookings = [];
  BookingModel? _currentBooking;

  bool get isLoading => _isLoading;
  List<BookingModel> get bookings => _bookings;
  BookingModel? get currentBooking => _currentBooking;

  Future<bool> createBooking(BookingModel booking) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _bookings.add(booking);
      _currentBooking = booking;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadBookings() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      // Load bookings from API
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      final index = _bookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        _bookings[index] = _bookings[index].copyWith(status: 'cancelled');
      }
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

