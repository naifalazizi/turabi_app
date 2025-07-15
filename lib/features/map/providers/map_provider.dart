import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../shared/models/user_model.dart';

class MapProvider extends ChangeNotifier {
  List<UserModel> _availableDrivers = [];
  UserModel? _selectedDriver;
  LatLng? _selectedLocation;
  LatLng? _currentLocation;
  bool _isLoading = false;

  List<UserModel> get availableDrivers => _availableDrivers;
  UserModel? get selectedDriver => _selectedDriver;
  LatLng? get selectedLocation => _selectedLocation;
  LatLng? get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  
  // إنشاء markers للسائقين المتاحين
  List<Marker> get markers {
    List<Marker> markers = [];
    
    // إضافة markers للسائقين المتاحين
    for (int i = 0; i < _availableDrivers.length; i++) {
      final driver = _availableDrivers[i];
      if (driver.currentLocation != null) {
        markers.add(
          Marker(
            markerId: MarkerId('driver_${driver.id}'),
            position: LatLng(
              driver.currentLocation!.latitude,
              driver.currentLocation!.longitude,
            ),
            infoWindow: InfoWindow(
              title: driver.name,
              snippet: 'سائق متاح - ${driver.rating?.toStringAsFixed(1) ?? '0.0'} ⭐',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
      }
    }
    
    // إضافة marker للموقع المحدد
    if (_selectedLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: _selectedLocation!,
          infoWindow: const InfoWindow(title: 'الموقع المحدد'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
    
    // إضافة marker للموقع الحالي
    if (_currentLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'موقعي الحالي'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
    
    return markers;
  }

  // تحديث قائمة السائقين المتاحين
  void updateAvailableDrivers(List<UserModel> drivers) {
    _availableDrivers = drivers;
    notifyListeners();
  }

  // تحديد سائق
  void selectDriver(UserModel driver) {
    _selectedDriver = driver;
    notifyListeners();
  }

  // تحديد موقع على الخريطة
  void setSelectedLocation(LatLng location) {
    _selectedLocation = location;
    notifyListeners();
  }

  // تحديث الموقع الحالي
  void updateCurrentLocation(LatLng location) {
    _currentLocation = location;
    notifyListeners();
  }
  
  // تحميل بيانات تجريبية للسائقين
  void loadSampleDrivers() {
    _availableDrivers = [
      UserModel(
        id: 'driver_1',
        name: 'أحمد محمد',
        email: 'ahmed@example.com',
        phone: '+966501234567',
        userType: 'driver',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: true,
        rating: 4.8,
        totalRatings: 150,
        currentLocation: LocationModel(
          latitude: 24.7236,
          longitude: 46.6853,
          address: 'الرياض، حي الملقا',
          city: 'الرياض',
          district: 'الملقا',
        ),
        trucks: [
          TruckModel(
            id: 'truck_1',
            type: 'قلاب متوسط',
            brand: 'مرسيدس',
            model: 'أكتروس',
            year: 2020,
            plateNumber: 'أ ب ج 1234',
            capacity: 10.0,
            isAvailable: true,
          ),
        ],
      ),
      UserModel(
        id: 'driver_2',
        name: 'محمد علي',
        email: 'mohammed@example.com',
        phone: '+966501234568',
        userType: 'driver',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: true,
        rating: 4.5,
        totalRatings: 95,
        currentLocation: LocationModel(
          latitude: 24.7336,
          longitude: 46.6653,
          address: 'الرياض، حي النرجس',
          city: 'الرياض',
          district: 'النرجس',
        ),
        trucks: [
          TruckModel(
            id: 'truck_2',
            type: 'قلاب كبير',
            brand: 'فولفو',
            model: 'FH16',
            year: 2021,
            plateNumber: 'د هـ و 5678',
            capacity: 15.0,
            isAvailable: true,
          ),
        ],
      ),
      UserModel(
        id: 'driver_3',
        name: 'عبدالله سعد',
        email: 'abdullah@example.com',
        phone: '+966501234569',
        userType: 'driver',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: true,
        rating: 4.9,
        totalRatings: 200,
        currentLocation: LocationModel(
          latitude: 24.7036,
          longitude: 46.6953,
          address: 'الرياض، حي الياسمين',
          city: 'الرياض',
          district: 'الياسمين',
        ),
        trucks: [
          TruckModel(
            id: 'truck_3',
            type: 'قلاب صغير',
            brand: 'إيسوزو',
            model: 'NPR',
            year: 2019,
            plateNumber: 'ز ح ط 9012',
            capacity: 5.0,
            isAvailable: true,
          ),
        ],
      ),
    ];
    notifyListeners();
  }

  // البحث عن موقع
  Future<void> searchLocation(String query) async {
    if (query.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        _selectedLocation = LatLng(location.latitude, location.longitude);
      }
    } catch (e) {
      debugPrint('خطأ في البحث عن الموقع: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // حساب المسافة بين نقطتين
  double calculateDistance(LatLng point1, LatLng point2) {
    return Geolocator.distanceBetween(
      point1.latitude,
      point1.longitude,
      point2.latitude,
      point2.longitude,
    ) / 1000; // تحويل إلى كيلومتر
  }

  // تحديث مسافات السائقين من الموقع الحالي
  void updateDriverDistances(LatLng userLocation) {
    for (var driver in _availableDrivers) {
      if (driver.currentLocation != null) {
        final distance = calculateDistance(
          userLocation,
          LatLng(
            driver.currentLocation!.latitude,
            driver.currentLocation!.longitude,
          ),
        );
        // تحديث المسافة في النموذج (يحتاج إضافة خاصية distance في UserModel)
        driver.distance = distance;
      }
    }
    notifyListeners();
  }

  // جلب السائقين المتاحين في المنطقة
  Future<void> loadAvailableDrivers(LatLng userLocation, {double radiusKm = 10.0}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: استبدال هذا بـ API call حقيقي
      await Future.delayed(const Duration(seconds: 1));
      
      // بيانات تجريبية للسائقين
      _availableDrivers = _generateMockDrivers(userLocation, radiusKm);
      
      // تحديث المسافات
      updateDriverDistances(userLocation);
    } catch (e) {
      debugPrint('خطأ في جلب السائقين: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // توليد بيانات تجريبية للسائقين
  List<UserModel> _generateMockDrivers(LatLng center, double radiusKm) {
    final List<UserModel> mockDrivers = [];
    
    // إنشاء 5 سائقين وهميين في المنطقة
    for (int i = 0; i < 5; i++) {
      // توليد موقع عشوائي ضمن الدائرة المحددة
      final randomLat = center.latitude + ((_random() - 0.5) * (radiusKm / 111)); // تقريبي
      final randomLng = center.longitude + ((_random() - 0.5) * (radiusKm / 111));
      
      mockDrivers.add(
        UserModel(
          id: 'driver_$i',
          name: 'السائق ${i + 1}',
          email: 'driver$i@example.com',
          phone: '05000000${i}0',
          userType: 'driver',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          rating: 3.5 + (_random() * 1.5), // تقييم بين 3.5 و 5
          totalRatings: 20 + (i * 5),
          licenseNumber: 'DL${1000 + i}',
          nationalId: '${1234567890 + i}',
          currentLocation: LocationModel(
            latitude: randomLat,
            longitude: randomLng,
          ),
          trucks: [
            TruckModel(
              id: 'truck_$i',
              type: ["small", "medium", "large"][i % 3],
              brand: 'هيونداي',
              model: 'شاحنة ${["صغيرة", "متوسطة", "كبيرة"][i % 3]}',
              year: 2020,
              plateNumber: 'ABC-${1000 + i}',
              capacity: [5000, 10000, 15000][i % 3].toDouble(),
              isAvailable: true,
            ),
          ],
        ),
      );
    }
    
    return mockDrivers;
  }

  // دالة مساعدة لتوليد أرقام عشوائية
  double _random() {
    return (DateTime.now().millisecondsSinceEpoch % 1000) / 1000.0;
  }

  // تنظيف البيانات
  void clearSelection() {
    _selectedDriver = null;
    _selectedLocation = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
