class AppConstants {
  // App Info
  static const String appName = 'ترابي';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'منصة حجز الشاحنات الإنشائية';
  
  // API
  static const String baseUrl = 'https://api.turabi.com';
  static const String apiVersion = 'v1';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String languageKey = 'language';
  static const String themeKey = 'theme';
  static const String onboardingKey = 'onboarding_completed';
  
  // User Types
  static const String customerType = 'customer';
  static const String driverType = 'driver';
  
  // Truck Types
  static const List<String> truckTypes = [
    'قلاب صغير',
    'قلاب متوسط', 
    'قلاب كبير',
    'شيول',
    'لودر',
    'بوكلين',
  ];
  
  // Material Types
  static const List<String> materialTypes = [
    'تراب',
    'رمل',
    'حصى',
    'خرسانة',
    'مخلفات بناء',
    'أسفلت',
  ];
  
  // Booking Status
  static const String pendingStatus = 'pending';
  static const String acceptedStatus = 'accepted';
  static const String inProgressStatus = 'in_progress';
  static const String completedStatus = 'completed';
  static const String cancelledStatus = 'cancelled';
  
  // Payment Methods
  static const String cashPayment = 'cash';
  static const String cardPayment = 'card';
  static const String walletPayment = 'wallet';
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 500;
  
  // Map
  static const double defaultLatitude = 24.7136;
  static const double defaultLongitude = 46.6753; // Riyadh
  static const double defaultZoom = 12.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration locationTimeout = Duration(seconds: 10);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}

