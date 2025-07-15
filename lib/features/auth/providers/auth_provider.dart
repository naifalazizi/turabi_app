import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Disabled to avoid build issues
import '../../../shared/models/user_model.dart';
import '../../../core/constants/app_constants.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _token;

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;
  bool get isCustomer => _currentUser?.userType == AppConstants.customerType;
  bool get isDriver => _currentUser?.userType == AppConstants.driverType;

  // Initialize auth state
  Future<void> initializeAuth() async {
    if (_isLoading) return; // Prevent multiple initializations
    
    _isLoading = true;
    // Don't notify during initialization
    
    try {
      // Simulate loading time
      await Future.delayed(const Duration(milliseconds: 500));
      
      // For demo purposes, we'll set a default user
      // In a real app, you would check SharedPreferences or secure storage
      _currentUser = UserModel(
        id: '1',
        name: 'مستخدم تجريبي',
        email: 'test@turabi.com',
        phone: '+966501234567',
        userType: AppConstants.customerType,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: true,
      );
      _isLoggedIn = false; // Start with logged out state
      _token = null;
    } catch (e) {
      debugPrint('Error initializing auth: $e');
      _currentUser = null;
      _isLoggedIn = false;
      _token = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login
  Future<bool> login(String email, String password, String userType) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock successful login
      if (email.isNotEmpty && password.length >= 6) {
        _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
        _currentUser = UserModel(
          id: '1',
          name: userType == AppConstants.customerType ? 'عميل تجريبي' : 'سائق تجريبي',
          email: email,
          phone: '+966501234567',
          userType: userType,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isVerified: true,
          rating: userType == AppConstants.driverType ? 4.5 : null,
          totalRatings: userType == AppConstants.driverType ? 120 : null,
        );
        _isLoggedIn = true;

        // Save to local storage
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString(AppConstants.userTokenKey, _token!);
        // await prefs.setString(AppConstants.userDataKey, 'user_data'); // In real app, save JSON

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint('Login error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Register
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String userType,
    String? companyName,
    String? commercialRegister,
    String? licenseNumber,
    String? nationalId,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock successful registration
      _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      _currentUser = UserModel(
        id: '1',
        name: name,
        email: email,
        phone: phone,
        userType: userType,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: false,
        companyName: companyName,
        commercialRegister: commercialRegister,
        licenseNumber: licenseNumber,
        nationalId: nationalId,
      );
      _isLoggedIn = true;

      // Save to local storage
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString(AppConstants.userTokenKey, _token!);
      // await prefs.setString(AppConstants.userDataKey, 'user_data');

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Register error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Clear local storage
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.remove(AppConstants.userTokenKey);
      // await prefs.remove(AppConstants.userDataKey);

      // Clear state
      _currentUser = null;
      _token = null;
      _isLoggedIn = false;
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? profileImage,
  }) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = _currentUser!.copyWith(
        name: name ?? _currentUser!.name,
        email: email ?? _currentUser!.email,
        phone: phone ?? _currentUser!.phone,
        profileImage: profileImage ?? _currentUser!.profileImage,
        updatedAt: DateTime.now(),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Update profile error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Verify account
  Future<bool> verifyAccount(String verificationCode) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock verification
      if (verificationCode == '1234') {
        _currentUser = _currentUser!.copyWith(
          isVerified: true,
          updatedAt: DateTime.now(),
        );

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint('Verify account error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful reset
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Reset password error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}

