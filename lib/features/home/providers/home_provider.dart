import 'package:flutter/material.dart';
import '../../../shared/models/booking_model.dart';
import '../../../shared/models/user_model.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<BookingModel> _recentBookings = [];
  List<UserModel> _nearbyDrivers = [];
  String _selectedMaterialType = 'تراب';
  double _selectedQuantity = 1.0;
  String _selectedUnit = 'متر مكعب';

  // Getters
  bool get isLoading => _isLoading;
  List<BookingModel> get recentBookings => _recentBookings;
  List<UserModel> get nearbyDrivers => _nearbyDrivers;
  String get selectedMaterialType => _selectedMaterialType;
  double get selectedQuantity => _selectedQuantity;
  String get selectedUnit => _selectedUnit;

  // Initialize home data
  Future<void> initializeHome() async {
    if (_isLoading) return; // Prevent multiple initializations
    
    _isLoading = true;
    notifyListeners();

    try {
      await Future.wait([
        loadRecentBookings(),
        loadNearbyDrivers(),
      ]);
    } catch (e) {
      debugPrint('Error initializing home: $e');
      // Set empty data on error
      _recentBookings = [];
      _nearbyDrivers = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load recent bookings
  Future<void> loadRecentBookings() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      _recentBookings = [
        BookingModel(
          id: '1',
          customerId: '1',
          driverId: '2',
          materialType: 'تراب',
          quantity: 5.0,
          unit: 'متر مكعب',
          pickupLocation: LocationModel(
            latitude: 24.7136,
            longitude: 46.6753,
            address: 'الرياض، حي النرجس',
            city: 'الرياض',
            district: 'النرجس',
          ),
          deliveryLocation: LocationModel(
            latitude: 24.7236,
            longitude: 46.6853,
            address: 'الرياض، حي الملقا',
            city: 'الرياض',
            district: 'الملقا',
          ),
          scheduledDate: DateTime.now().add(const Duration(hours: 2)),
          status: 'accepted',
          estimatedPrice: 500.0,
          paymentMethod: 'cash',
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
          updatedAt: DateTime.now(),
        ),
        BookingModel(
          id: '2',
          customerId: '1',
          materialType: 'رمل',
          quantity: 3.0,
          unit: 'متر مكعب',
          pickupLocation: LocationModel(
            latitude: 24.7036,
            longitude: 46.6653,
            address: 'الرياض، حي العليا',
            city: 'الرياض',
            district: 'العليا',
          ),
          deliveryLocation: LocationModel(
            latitude: 24.7336,
            longitude: 46.6953,
            address: 'الرياض، حي الصحافة',
            city: 'الرياض',
            district: 'الصحافة',
          ),
          scheduledDate: DateTime.now().add(const Duration(days: 1)),
          status: 'pending',
          estimatedPrice: 300.0,
          paymentMethod: 'card',
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
          updatedAt: DateTime.now(),
        ),
      ];
    } catch (e) {
      debugPrint('Error loading recent bookings: $e');
    }
  }

  // Load nearby drivers
  Future<void> loadNearbyDrivers() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      _nearbyDrivers = [
        UserModel(
          id: '2',
          name: 'أحمد محمد',
          email: 'ahmed@example.com',
          phone: '+966501234568',
          userType: 'driver',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isVerified: true,
          rating: 4.8,
          totalRatings: 150,
          licenseNumber: 'D123456789',
          nationalId: '1234567890',
          trucks: [
            TruckModel(
              id: '1',
              type: 'قلاب متوسط',
              brand: 'مرسيدس',
              model: 'أكتروس',
              year: 2020,
              plateNumber: 'أ ب ج 1234',
              capacity: 10.0,
              isAvailable: true,
              insuranceNumber: 'INS123456',
              insuranceExpiry: DateTime.now().add(const Duration(days: 365)),
            ),
          ],
        ),
        UserModel(
          id: '3',
          name: 'محمد علي',
          email: 'mohammed@example.com',
          phone: '+966501234569',
          userType: 'driver',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isVerified: true,
          rating: 4.5,
          totalRatings: 89,
          licenseNumber: 'D987654321',
          nationalId: '0987654321',
          trucks: [
            TruckModel(
              id: '2',
              type: 'قلاب كبير',
              brand: 'فولفو',
              model: 'FH16',
              year: 2019,
              plateNumber: 'د ه و 5678',
              capacity: 15.0,
              isAvailable: true,
              insuranceNumber: 'INS789012',
              insuranceExpiry: DateTime.now().add(const Duration(days: 200)),
            ),
          ],
        ),
      ];
    } catch (e) {
      debugPrint('Error loading nearby drivers: $e');
    }
  }

  // Set material type
  void setMaterialType(String materialType) {
    _selectedMaterialType = materialType;
    notifyListeners();
  }

  // Set quantity
  void setQuantity(double quantity) {
    _selectedQuantity = quantity;
    notifyListeners();
  }

  // Set unit
  void setUnit(String unit) {
    _selectedUnit = unit;
    notifyListeners();
  }

  // Refresh data
  Future<void> refresh() async {
    await initializeHome();
  }

  // Search drivers
  Future<List<UserModel>> searchDrivers({
    String? materialType,
    double? quantity,
    LocationModel? location,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Return filtered drivers based on criteria
      return _nearbyDrivers.where((driver) {
        // Add filtering logic here
        return driver.trucks?.any((truck) => truck.isAvailable) ?? false;
      }).toList();
    } catch (e) {
      debugPrint('Error searching drivers: $e');
      return [];
    }
  }

  // Get price estimate
  Future<double> getPriceEstimate({
    required String materialType,
    required double quantity,
    required String unit,
    required LocationModel pickupLocation,
    required LocationModel deliveryLocation,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock price calculation
      double basePrice = 50.0; // Base price per unit
      double distance = 10.0; // Mock distance calculation
      double materialMultiplier = materialType == 'تراب' ? 1.0 : 1.2;
      
      return (basePrice * quantity * materialMultiplier) + (distance * 5);
    } catch (e) {
      debugPrint('Error getting price estimate: $e');
      return 0.0;
    }
  }
}

