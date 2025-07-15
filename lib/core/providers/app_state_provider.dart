import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool _isInitialized = false;
  bool _isLoading = true;
  String? _errorMessage;
  
  // Getters
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  // Initialize app state
  Future<void> initializeApp() async {
    if (_isInitialized) return;
    
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate app initialization
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Initialize any global state here
      
      _isInitialized = true;
      _isLoading = false;
      _errorMessage = null;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'حدث خطأ أثناء تهيئة التطبيق';
      debugPrint('App initialization error: $e');
    }
    
    notifyListeners();
  }

  // Reset app state
  void resetState() {
    _isInitialized = false;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
  }

  // Set loading state
  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  // Set error
  void setError(String? error) {
    if (_errorMessage != error) {
      _errorMessage = error;
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }
}
